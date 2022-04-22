#!/usr/bin/env bash
# shellcheck disable=SC2076
set -e

disallowd_vars_arr=(
    _
    fish_kill_signal
    fish_killring
    fish_pid
    history
    hostname
    PWD
    pipestatus
    SHLVL
    status
    status_generation
    version
)
disallowd_vars=" ${disallowd_vars_arr[*]} "

fish_escape() {
    value="${1//\\/\\\\}"
    value="${value//\'/\\\'}"
    echo "'${value}'"
}

read_old_env() {
    env -0 | while IFS= read -rs -d $'\0' line; do
        echo -n " $line"
    done
}

old_env=" $(read_old_env) "

eval "$*" 1>&2 || true

env -0 | while IFS= read -rs -d $'\0' line; do
    if [[ "${old_env}" =~ " ${line} " ]]; then
        continue
    fi

    name="${line%%=*}"
    if [[ "${disallowd_vars}" =~ " ${name} " ]]; then
        continue
    fi

    value=$(fish_escape "${line#*=}")
    echo "set -gx ${name} ${value}"
done
