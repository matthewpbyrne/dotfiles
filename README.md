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

## Optional shell tooling (zoxide / fzf / direnv)

These dotfiles include conservative integrations for:

- `zoxide` (`z` command for directory jumping; does **not** replace `cd`)
- `fzf` (zsh bindings/completion + helper functions)
- `direnv` (official shell hooks)
- `bat` (used as an `fzf` file previewer when available)

### Install dependencies

Install with your package manager, for example:

```bash
# Debian/Ubuntu
sudo apt install -y zoxide fzf direnv bat
# Note: on Debian/Ubuntu the `bat` package provides a `batcat` binary. These dotfiles
# support `batcat` out of the box, so no extra configuration is needed.

# Fedora
sudo dnf install -y zoxide fzf direnv bat

# Arch
sudo pacman -S --needed zoxide fzf direnv bat

# Homebrew (Linux/macOS)
brew install zoxide fzf direnv bat
```

Then apply your dotfiles:

```bash
chezmoi apply
```

### Added helper commands

From shared shell functions:

- `ff` — fuzzy-find file and open in `$EDITOR`
- `fh` — fuzzy-search command history and print selected command
- `tss` — fuzzy tmux session switch/attach
- `zproj` — jump to project-y directories using zoxide ranking (`z code`)
- `zjump` — fuzzy pick from `zoxide query -l` and `cd` there

Convenience aliases:

- `vf` → `ff`
- `vfh` → `fh`

### direnv safe starter patterns

Use per-project `.envrc` files and explicitly allow each one:

```bash
direnv allow
```

Example `.envrc` snippets:

```bash
# 1) Python virtualenv (direnv stdlib helper)
layout python3
```

```bash
# 2) Project-local bin path
PATH_add ./bin
```

```bash
# 3) AWS/Terraform style environment variables
export AWS_PROFILE=my-dev
export AWS_REGION=us-east-1
export TF_VAR_environment=dev
```

```bash
# 4) Load non-committed local overrides safely
dotenv_if_exists .env.local
```

Notes:

- Keep real secrets in non-committed files such as `.env.local`.
- Prefer least-privilege credentials and short-lived tokens.
