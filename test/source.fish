set DIR (dirname (status -f))
source $DIR/../functions/bash2env.fish

bash2env source $DIR/fixtures/profile_source.sh

set expected_d "
1
2
3
"

if test $expected_d != $d
    exit 1
end
