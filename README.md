# fzf-docker

Small Zsh helpers for selecting Docker image and container IDs with [fzf](https://github.com/junegunn/fzf).

## Requirements

- Docker CLI
- fzf
- Zsh

## Install

Source `fzf-docker.plugin.zsh` from your `.zshrc`, or place this repository in an Oh My Zsh plugin directory and add `fzf-docker` to `plugins=(...)`.

```zsh
source /path/to/fzf-docker/fzf-docker.plugin.zsh
```

## Insert IDs into the current command

Type a command, then press **Esc**, followed by **d** and one of these keys:

- **i** — opens an image picker showing image ID, name/tag, and size.
- **c** — opens a picker of running containers showing ID, name, image, and status.

Choose one or more rows and press Enter; their IDs are appended to the command line. For example, type `docker stop ` and press **Esc d c** to insert a running container ID.

Most terminal emulators do not send macOS **Command** key chords to Zsh. To use Command-d then Command-i or Command-d then Command-c instead, configure the terminal emulator to send `Esc d i` or `Esc d c` respectively.
