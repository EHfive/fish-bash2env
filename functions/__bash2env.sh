#!/usr/bin/env bash
# Copyright (c) 2022 Huang-Huang Bao
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

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


flag_impure="$__FISH_BASH2ENV_IMPURE"
unset __FISH_BASH2ENV_IMPURE

if [[ -z "$flag_impure" ]]; then
    old_env=" $(env -0 | tr '\0' ' ') "
fi

eval_status=
eval "$*" 1>&2 || eval_status=$?

env -0 | while IFS= read -rs -d $'\0' line; do
    if [[ -z "$flag_impure" && "${old_env}" =~ " ${line} " ]]; then
        continue
    fi

    name="${line%%=*}"
    if [[ "${disallowd_vars}" =~ " ${name} " ]]; then
        continue
    fi

    value="$(fish_escape "${line#*=}")"
    echo "set -gx ${name} ${value}"
done

exit $eval_status
