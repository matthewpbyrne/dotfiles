# shellcheck shell=sh

export PNPM_HOME="$HOME/.local/share/pnpm"
export WORKSPACE_HOME="$HOME/tmp/workspaces"
export MISE_DATA_DIR="${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}"

export PAGER=less
