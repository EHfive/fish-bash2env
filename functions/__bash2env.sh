#!/usr/bin/env bash
set -e

eval "$*" || true

readonly_vars=(
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

fish_escape() {
    value="${1//\\/\\\\}"
    value="${value//\'/\\\'}"
    echo "'${value}'"
}

printenv -0 | while IFS= read -r -d $'\0' line; do
    name=${line%%=*}
    if [[ " ${readonly_vars[*]} " =~ ^.*\ ${name}\ .*$ ]]; then
        continue
    fi

    value=$(fish_escape "${line#*=}")
    echo "set -gx ${name} ${value}"
done
