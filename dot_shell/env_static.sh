# shellcheck shell=sh

export PNPM_HOME="$HOME/.local/share/pnpm"
export WORKSPACE_HOME="$HOME/tmp/workspaces"

if command -v nvim >/dev/null 2>&1; then
	EDITOR="$(command -v nvim)"
elif command -v vim >/dev/null 2>&1; then
	EDITOR="$(command -v vim)"
else
	EDITOR="$(command -v vi)"
fi
export EDITOR

if [ -z "${VISUAL:-}" ]; then
	VISUAL="$EDITOR"
fi
export VISUAL

export PAGER=less
