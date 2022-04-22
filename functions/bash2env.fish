function bash2env -d "Source environment variables modified by given bash command"
    if test (count $argv) -eq 0
        echo 'Usage:' \
            (set_color $fish_color_command)'bash2env' \
            (set_color $fish_color_param)'<bash command>'
        return 22
    end

    set -l DIR (dirname (status -f))
    command bash $DIR/__bash2env.sh $argv | source
    return $status
end
