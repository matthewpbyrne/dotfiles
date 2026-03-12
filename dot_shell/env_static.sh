# shellcheck shell=sh

export EDITOR=/snap/bin/nvim
export VISUAL="$EDITOR"
export PAGER=less

export PNPM_HOME="$HOME/.local/share/pnpm"
export SCRATCH_HOME="$HOME/tmp"

export PATH="$HOME/.local/bin:$PNPM_HOME:$PATH"
