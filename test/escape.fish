set DIR (dirname (status -f))
source $DIR/../functions/bash2env.fish

set escaped ' \'\\\n"$ '

bash2env 'export escaped_env=" \'\\\\\n\"$ "'

if test $escaped != $escaped_env
    exit 1
end
