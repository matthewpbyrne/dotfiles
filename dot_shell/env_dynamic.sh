# shellcheck shell=sh

# Force asdf shims/bin to the front
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Prepend asdf shims and bin to PATH (bash won't see zsh-only path_order.zsh)
asdf_shims="$ASDF_DATA_DIR/shims"
asdf_bin="$ASDF_DATA_DIR/bin"
for asdf_dir in "$asdf_shims" "$asdf_bin"; do
	case ":$PATH:" in
		*":$asdf_dir:"*) ;;
		*) PATH="$asdf_dir:$PATH" ;;
	esac
done
export PATH
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

if luarocks --version >/dev/null 2>&1; then
	eval "$(luarocks path)"
fi

# Keep tmux global PATH in sync so plugins (e.g. extrakto) launched in popups
# can find tools installed by asdf, brew, etc.
if [ -n "${TMUX:-}" ]; then
	tmux set-environment -g PATH "$PATH" 2>/dev/null || true
fi
