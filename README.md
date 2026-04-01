## Introduction

This repository manages my dotfiles using [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

To bootstrap a new machine, install `chezmoi` and apply this repo:

Run this command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" \
  && PATH="$HOME/.local/bin:$PATH" \
  && chezmoi init --apply matthewpbyrne
```

After that, chezmoi manages all configuration and bootstrap scripts.

## Managed tools

| Tool    | Config path                           | Notes                              |
| ------- | ------------------------------------- | ---------------------------------- |
| tmux    | `~/.config/tmux/`                     | Modular config split into subdirectories |
| Zellij  | `~/.config/zellij/`                   | KDL config + default layout        |
| Neovim  | `~/.config/nvim/`                     |                                    |
| Zsh     | `~/.config/zsh/profiles/default/`     | Profile-based setup via ZDOTDIR    |
| Alacritty | `~/.config/alacritty/`              |                                    |

## Zellij

Zellij config lives in `~/.config/zellij/`:

- `config.kdl` — main configuration (shell, mouse, scroll buffer, keybinds)
- `layouts/default.kdl` — default layout (tab bar, shell pane, status bar)

Install Zellij via your package manager (e.g. `brew install zellij` on macOS or
`pacman -S zellij` on Arch) and run `zellij` to start with the managed config.

To preview changes before applying:

```bash
chezmoi diff ~/.config/zellij/
chezmoi apply ~/.config/zellij/
```
