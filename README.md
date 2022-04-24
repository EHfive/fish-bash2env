# fish-bash2env

A lightweight fish plugin to import environment variables modified by given bash command/script, implemented purely in bash ([\_\_bash2env.sh](./functions/__bash2env.sh)) and fish.

## Requirements

-   fish
-   bash
-   coreutils (`env -0`, `tr`)

## Usage

([Install](#install) the plugin first to use the `bash2env` function)

**bash2env** [_-i/--impure_] _\<bash command\>_

-   -i, --impure: By default bash2env runs given bash command with `--norc` flag (see bash(1)) and imports only changed environment variables, `--impure` flag disables this behavior.

```fish
$ bash2env source /etc/profile
$ bash2env export x=123
$ echo $x
123
$ # bash2env is just a wrapper that sources outputs of __bash2env.sh
$ bash /path/to/__bash2env.sh  export x=123
set -gx x '123'
```

<details>
<summary>Demo</summary>

[![asciicast](https://asciinema.org/a/489496.svg)](https://asciinema.org/a/489496)

</details>

<details>
<summary>Setting fish as default shell(login shell)</summary>

Check if fish is installed:

```
$ chsh -l | grep fish
```

Change default shell to fish (the path of fish binary might differ):

```
$ chsh -s /bin/fish
```

Source `/etc/profile` with `bash2env` in your fish config, this ensures `PATH` and other important environment variables been added to your environment.

```fish
# ~/.config/fish/config.fish or /etc/fish/config.fish
if status is-login
    bash2env source /etc/profile
end

# ...
```

</details>

## Install

#### Makefile

```
$ make FISH_FUNCTION_DIR=~/.config/fish/functions install
$ # or install globally
$ sudo make install
$ sudo make uninstall
```

#### [fisher](https://github.com/jorgebucaran/fisher)

```
$ fisher install EHfive/fish-bash2env
$ fisher remove EHfive/fish-bash2env
```

#### [fish_function_path](https://fishshell.com/docs/current/language.html#autoloading-functions)

```
$ set -l function_path /path/to/fish-bash2env/functions
$ set fish_function_path $fish_function_path $function_path
```

### Packages

| Distribution | Repo | Package                                                           |
| ------------ | ---- | ----------------------------------------------------------------- |
| Arch Linux   | AUR  | [fish-bash2env](https://aur.archlinux.org/packages/fish-bash2env) |

## Performance

Time by sourcing `/etc/profile` on my personal Arch Linux desktop setup.

| Test (1000 runs)                                   | Time             |
| -------------------------------------------------- | ---------------- |
| bash -c "source /etc/profile"                      | 13.0 ms ± 1.7 ms |
| env -i bash -c "source /etc/profile"               | 14.1 ms ± 1.8 ms |
| env -i \_\_bash2env.sh source /etc/profile \| fish | 16.1 ms ± 1.3 ms |
| \_\_bash2env.sh source /etc/profile \| fish        | 22.4 ms ± 3.1 ms |

## Alternatives

| Name                                                            | Note                                                                   |
| --------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [foreign-env](https://github.com/oh-my-fish/plugin-foreign-env) | No multiline env value support                                         |
| [bass](https://github.com/edc/bass)                             | Supports alias; Uses python, which is heavy and overkill for this task |
| [babelfish](https://github.com/bouk/babelfish)                  | Can't transpile some builtin commands (e.g. `read`)                    |
