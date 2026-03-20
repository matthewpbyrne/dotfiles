# shellcheck shell=sh

export PNPM_HOME="$HOME/.local/share/pnpm"
export WORKSPACE_HOME="$HOME/tmp/workspaces"

# Ensure PATH includes user-local and pnpm binaries in a POSIX-safe way.
# Do not overwrite PATH if it's already set; only prepend missing entries.
if [ -z "${PATH:-}" ]; then
	# Fallback to a minimal, generic PATH if none is set.
	PATH=/usr/local/bin:/usr/bin:/bin
fi

case ":$PATH:" in
	*":$HOME/.local/bin:"*) ;;
	*) PATH="$HOME/.local/bin:$PATH" ;;
esac

case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH
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
