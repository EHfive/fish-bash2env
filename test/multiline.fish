set DIR (dirname (status -f))
source $DIR/../functions/bash2env.fish

set multiline "line 1
line2

line4
"

bash2env "export multiline_env=\"$multiline\""

if test $multiline != $multiline_env
    exit 1
end
