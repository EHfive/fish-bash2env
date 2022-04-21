# fish-bash2env

Source bash env in fish shell, implemented purely in bash ([\_\_bash2env.sh](./functions/__bash2env.sh)) and fish.

## Usage

```fish
$ set fish_function_path $fish_function_path /path/to/fish-bash2env/functions
$ # or copy/link files in ./functions into somewhere already specified in $fish_function_path (e.g. /etc/fish/functions)
$ bash2env export x=123
$ echo $x
123
$ bash2env source /etc/profile
```

## Performance

Time by sourcing `/etc/profile` on my personal Arch Linux desktop setup.

| Test                                    | Time             |
| --------------------------------------- | ---------------- |
| `bash -c "source /etc/profile"`         | 12.9 ms ± 1.8 ms |
| `__bash2env.sh source /etc/profile`     | 22.7 ms ± 2.5 ms |
| `fish __pre_generated_etc_profile.fish` | 12.1 ms ± 1.6 ms |

This scripts would consumes roughly 22 more milliseconds to source my `/etc/profile` than sourcing with bash directly.

## Alternatives

| Name                                                            | Notes                                                  |
| --------------------------------------------------------------- | ------------------------------------------------------ |
| [foreign-env](https://github.com/oh-my-fish/plugin-foreign-env) | No multi-line env value support                        |
| [bass](https://github.com/edc/bass)                             | Uses python, which is heavy and overkill for this task |
| [babelfish](https://github.com/bouk/babelfish)                  | Can't transpile some builtin commands (e.g. `read`)    |

## TODO
* Diff old & new environment variables (or just use `env -i` ?)
