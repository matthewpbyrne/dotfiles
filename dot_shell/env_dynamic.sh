# shellcheck shell=sh

# Ensure Homebrew is on PATH if available
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
	export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Force asdf shims/bin to the front
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

if command -v go >/dev/null 2>&1; then
	GOBIN="$(go env GOBIN 2>/dev/null)"
	if [ -z "$GOBIN" ]; then
		GOPATH="$(go env GOPATH 2>/dev/null)"
		GOBIN="${GOPATH%%:*}/bin"
	fi
	export GOBIN

	GOROOT="$(go env GOROOT)"
	export GOROOT
fi

[ -n "${GOBIN:-}" ] && export PATH="$GOBIN:$PATH"

command -v luarocks >/dev/null 2>&1 && eval "$(luarocks path)"

# Keep tmux global PATH in sync so plugins (e.g. extrakto) launched in popups
# can find tools installed by asdf, brew, etc.
if [ -n "${TMUX:-}" ]; then
	tmux set-environment -g PATH "$PATH" 2>/dev/null || true
fi
