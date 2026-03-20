# shellcheck shell=sh

# Tool-managed base dirs
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Go-derived environment
if command -v go >/dev/null 2>&1; then
	GOBIN="$(go env GOBIN 2>/dev/null)"
	if [ -z "$GOBIN" ]; then
		GOPATH="$(go env GOPATH 2>/dev/null)"
		[ -n "$GOPATH" ] && GOBIN="${GOPATH%%:*}/bin"
	fi
	[ -n "${GOBIN:-}" ] && export GOBIN
fi

# LuaRocks environment
if command -v luarocks >/dev/null 2>&1; then
	eval "$(luarocks path --shell=sh 2>/dev/null)"
fi

# Keep tmux global PATH in sync so plugins launched in tmux popups
# can find tools installed by asdf, Homebrew, etc.
if [ -n "${TMUX:-}" ]; then
	tmux set-environment -g PATH "$PATH" 2>/dev/null || true
fi
