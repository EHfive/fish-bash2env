# fish-bash2env

Source bash env in fish shell, implemented purely in bash ([\_\_bash2env.sh](./functions/__bash2env.sh)) and fish.

## Requirements

-   fish
-   bash
-   coreutils (`env -0`)

## Usage

```fish
$ set function_path /path/to/fish-bash2env/functions
$ set fish_function_path $fish_function_path $function_path
$ # or copy/link files in ./functions into one of $fish_function_path (e.g. /etc/fish/functions)
$ bash2env source /etc/profile
$ bash2env export x=123
$ echo $x
123
$ # bash2env is just a wrapper that sources outputs of __bash2env.sh
$ bash $function_path/__bash2env.sh export x=123
set -gx x '123'
```

## Performance

Time by sourcing `/etc/profile` on my personal Arch Linux desktop setup.

| Test (1000 runs)                                   | Time             |
| -------------------------------------------------- | ---------------- |
| bash -c "source /etc/profile"                      | 13.0 ms ± 1.7 ms |
| env -i bash -c "source /etc/profile"               | 14.1 ms ± 1.8 ms |
| env -i \_\_bash2env.sh source /etc/profile \| fish | 16.1 ms ± 1.3 ms |
| \_\_bash2env.sh source /etc/profile \| fish        | 22.4 ms ± 3.1 ms |

## Alternatives

| Name                                                            | Note                                                   |
| --------------------------------------------------------------- | ------------------------------------------------------ |
| [foreign-env](https://github.com/oh-my-fish/plugin-foreign-env) | No multi-line env value support                        |
| [bass](https://github.com/edc/bass)                             | Uses python, which is heavy and overkill for this task |
| [babelfish](https://github.com/bouk/babelfish)                  | Can't transpile some builtin commands (e.g. `read`)    |
