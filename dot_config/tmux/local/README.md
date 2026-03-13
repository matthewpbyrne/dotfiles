# tmux local overrides

Place machine-local tmux overrides in:

- `~/.config/tmux/local/overrides.conf`

The profile-aware tmux entrypoint will source this file if present, after shared and profile config.

This directory intentionally ignores `overrides.conf` so private machine tweaks stay untracked.
