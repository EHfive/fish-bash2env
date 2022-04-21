function bash2env
    set -l DIR (dirname (status -f))
    command bash $DIR/__bash2env.sh $argv | source
end
