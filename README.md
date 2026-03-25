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

## Tool runtime manager: mise

This dotfiles repo now uses [mise](https://mise.jdx.dev/) instead of asdf.

### Workflow

- Keep per-project tool versions in `.tool-versions` while migrating (mise supports this).
- Put user/global tool choices in `~/.config/mise/config.toml` (managed here via chezmoi).
- Use `mise use` for project versions and `mise use -g` for global user defaults.

### Local migration steps (one time)

1. Install mise (for example via Homebrew): `brew install mise`.
2. Install tools declared by your current project:
   `mise install`.
3. Re-create any asdf global versions in mise global config, for example:
   `mise use -g node@20 python@3.12`.
4. Remove asdf-specific shell customizations from your local machine if any remain
   outside chezmoi-managed files.
5. Open a new shell and confirm:
   `mise doctor` and `mise ls`.
