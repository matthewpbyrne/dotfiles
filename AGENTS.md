# AGENTS.md

## Purpose

This repository is a chezmoi source-state repository.

The repo root is intended to live at:

    ~/.local/share/chezmoi

Changes should be made to the source-state files in this repository and then applied to the target home directory with `chezmoi apply`.

Goals for any change:

- keep shell setup understandable and modular
- keep behaviour consistent across bash, zsh, tmux, and chezmoi
- avoid breaking interactive shell startup
- avoid committing secrets or machine-specific private values
- prefer small, reviewable changes

## Important repository conventions

This is a chezmoi repo, so tracked files are usually source-state names such as:

- `dot_profile`
- `dot_bashrc`
- `dot_zshenv`
- `dot_tmux.conf`
- `dot_config/zsh/profiles/default/dot_zshrc`
- `dot_config/zsh/profiles/minimal/dot_zshrc`
- `dot_shell/env_static.sh`
- `dot_shell/env_dynamic.sh`
- `dot_shell/aliases.sh`
- `dot_shell/functions.sh`
- `dot_shell/functions_workspaces.sh`

When editing shell config, edit the chezmoi source-state files in this repo, not the live files in `$HOME`, unless explicitly asked to work against the applied target state.

## Shell layout

Responsibilities are split as follows:

- `dot_profile` — shared login-shell environment
- `dot_bashrc` — interactive bash setup
- `dot_zshenv` — selects zsh profile via `ZSH_PROFILE` / `ZDOTDIR`
- `dot_config/zsh/profiles/default/dot_zshrc` — main zsh profile
- `dot_config/zsh/profiles/minimal/dot_zshrc` — minimal zsh profile for debugging
- `dot_shell/env_static.sh` — static environment variables
- `dot_shell/env_dynamic.sh` — tool-dependent environment setup
- `dot_shell/aliases.sh` — shared aliases
- `dot_shell/functions.sh` — general helper functions
- `dot_shell/functions_workspaces.sh` — workspace helpers
- `dot_shell/secrets.example.sh` — template only; do not commit real secrets

Do not reintroduce legacy monolithic shell setup.

Do not duplicate the same logic across `dot_profile`, `dot_bashrc`, and zsh profile files unless required by shell startup semantics.

## Secrets and private data

Never commit real secrets.

Real secrets belong in the applied target file:

- `~/.shell/secrets.sh`

Only the template file should be tracked here:

- `dot_shell/secrets.example.sh`

If an example is needed, update the template only.

## Zsh profile conventions

Zsh uses a profile-based setup.

`dot_zshenv` should control profile selection via:

- `ZSH_PROFILE`
- `ZDOTDIR`

The `default` profile is the main interactive shell.

The `minimal` profile should stay intentionally minimal and useful for debugging startup issues. Prefer that it avoids plugin managers, heavy shell customisation, and overlapping startup machinery. Only add more to `minimal` if there is a clear debugging or baseline-shell reason.

## asdf / Homebrew / direnv

Assume `asdf` is installed via Homebrew, not via a `~/.asdf` git checkout.

Do not reintroduce old startup patterns such as sourcing `~/.asdf/asdf.sh` unless the repository is explicitly changed to support that installation method.

Prefer Homebrew-aware initialization.

Use the official `direnv` hook for the relevant shell.

Do not add multiple overlapping direnv integrations.

## tmux conventions

Keep tmux configuration minimal and predictable.

Avoid duplicate or conflicting tmux settings.

Preserve environment propagation behaviour where relevant.

## Formatting and linting

Because this is a chezmoi source-state repo, run formatting and linting against the repo files here, not the applied files in `$HOME`.

Recommended commands from the repo root:

```sh
shfmt -w dot_profile dot_bashrc dot_shell/*.sh
shellcheck -x dot_profile dot_bashrc dot_shell/*.sh
```

Do not run `shfmt` on zsh-specific files if it breaks valid zsh syntax. In particular, skip:

- `dot_config/zsh/profiles/default/dot_zshrc`
- `dot_config/zsh/profiles/minimal/dot_zshrc`

Use `shellcheck` primarily for `dot_profile`, `dot_bashrc`, and `dot_shell/*.sh`.

## Chezmoi workflow

Typical workflow:

1. edit source-state files in this repo
2. run formatting / linting where appropriate
3. run `chezmoi diff` to inspect target-state changes that would be applied
4. run `chezmoi apply`
5. optionally run `chezmoi diff` again to confirm the applied state is clean

`chezmoi diff` is still useful in this repo because it shows how the source state differs from the current applied target state, including permission drift and local changes.

## Change guidelines

When making changes:

- prefer minimal diffs
- preserve existing working behaviour unless intentionally refactoring
- explain any startup-order changes clearly
- keep shell startup robust when commands are missing
- guard optional tooling with checks such as `command -v ... >/dev/null 2>&1`

## Commit conventions

Use Conventional Commits.

Use clear scopes. Current preferred scopes include:

- `shell`
- `zsh`
- `bash`
- `tmux`
- `chezmoi`
- `vim`
- `nvim`
- `emacs`

This list can expand over time as the repo grows.

Examples:

- `feat(shell): add workspaces helpers`
- `refactor(shell): simplify startup logic`
- `chore(chezmoi): add ignore rules`
- `refactor(tmux): clean up status line`
- `feat(emacs): add org helper aliases`

## What to avoid

- do not commit secrets
- do not hardcode machine-private credentials
- do not reintroduce duplicated shell setup
- do not add unnecessary plugin complexity
- do not change file permissions casually without explaining why
- do not replace working shell startup logic with speculative changes

## When proposing changes

Prefer:

1. short explanation of the issue
2. minimal patch
3. validation steps
4. suggested commit message
