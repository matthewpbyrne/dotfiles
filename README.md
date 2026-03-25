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


## Trying alternative shells (without replacing zsh)

See [docs/alternative-shell-trials.md](docs/alternative-shell-trials.md) for trial-use configs and launch instructions for xonsh, Nushell, elvish, oil, and ion.
