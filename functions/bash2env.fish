# Copyright (c) 2022 Huang-Huang Bao
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

function bash2env -d "Import environment variables modified by given bash command"
    argparse --stop-nonopt h/help i/impure -- $argv
    or set argv

    function _print_usage
        echo 'Usage:' \
            (set_color $fish_color_command)'bash2env' \
            (set_color $fish_color_normal)'[-i/--impure]' \
            (set_color $fish_color_param)"<bash command>"
    end

    if test -n "$_flag_help"
        _print_usage
        return
    end
    if test (count $argv) -eq 0
        _print_usage
        return 22
    end

    set -l bash_flags

    if test -n "$_flag_impure"
        set _flag_impure 1
    else
        set bash_flags $bash_flags --norc
    end

    set -l DIR (dirname (status -f))
    __FISH_BASH2ENV_IMPURE=$_flag_impure \
        command bash $bash_flags $DIR/__bash2env.sh $argv | source
    return $status
end
