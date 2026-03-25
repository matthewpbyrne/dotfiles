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

## Terminal support

This repo includes first-class config for:

- Alacritty (`~/.config/alacritty/alacritty.toml` via chezmoi source-state)
- Kitty (`~/.config/kitty/kitty.conf`)
- Ghostty (`~/.config/ghostty/config`)

Theme files are kept in terminal-native locations:

- Alacritty: `~/.config/alacritty/themes/...` (managed by `run_once_install_alacritty_themes.sh`)
- Kitty: `~/.config/terminal-themes/kitty/...`
- Ghostty: `~/.config/ghostty/themes/...`

Both Kitty and Ghostty configs are set up with shared baseline defaults (font size, padding, opacity, login shell) and dedicated theme override points.

## Package/bootstrap notes

Install at least one terminal package you plan to use, for example:

- `alacritty`
- `kitty`
- `ghostty`

On Linux, Ghostty packaging varies by distro; you may need to install from your distro repo, a COPR/PPA, or upstream release artifacts.
