# shellcheck shell=sh

# Tool-managed base dirs
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Preferred editor (PATH-dependent)
if command -v nvim >/dev/null 2>&1; then
	EDITOR="$(command -v nvim)"
elif command -v vim >/dev/null 2>&1; then
	EDITOR="$(command -v vim)"
elif command -v vi >/dev/null 2>&1; then
	EDITOR="$(command -v vi)"
else
	EDITOR="vi"
fi
export EDITOR

if [ -z "${VISUAL:-}" ]; then
	VISUAL="$EDITOR"
fi
export VISUAL

# Go-derived environment
if command -v go >/dev/null 2>&1; then
	GOBIN="$(go env GOBIN 2>/dev/null)"
	if [ -z "$GOBIN" ]; then
		GOPATH="$(go env GOPATH 2>/dev/null)"
		[ -n "$GOPATH" ] && GOBIN="${GOPATH%%:*}/bin"
	fi

	if [ -n "${GOBIN:-}" ]; then
		export GOBIN
		add_tool_path "$GOBIN"
	fi
fi

# LuaRocks environment
if command -v luarocks >/dev/null 2>&1; then
	eval "$(luarocks path --shell=sh 2>/dev/null)"
fi

# Terminal capability hints
case "${TERM_PROGRAM:-}" in
  ghostty|iTerm.app|WezTerm|Apple_Terminal)
    : "${COLORTERM:=truecolor}"
    export COLORTERM
    ;;
esac

case "${TERM:-}" in
  alacritty|ghostty|xterm-kitty)
    : "${COLORTERM:=truecolor}"
    export COLORTERM
    ;;
esac

# Kitty shell integration (if installed) improves cwd/shell state tracking.
if [ "${TERM:-}" = "xterm-kitty" ]; then
	kitty_shell=
	kitty_file=
	kitty_integration=

	if [ -n "${BASH_VERSION:-}" ] && [ -n "${BASH:-}" ]; then
		kitty_shell="bash"
		kitty_file="kitty.bash"
	elif [ -n "${ZSH_VERSION:-}" ] && [ "${ZSH_NAME:-}" = "zsh" ]; then
		kitty_shell="zsh"
		kitty_file="kitty.zsh"
	fi

	if [ -n "$kitty_shell" ] && [ -n "$kitty_file" ]; then
		if [ -n "${KITTY_INSTALLATION_DIR:-}" ]; then
			candidate="${KITTY_INSTALLATION_DIR}/shell-integration/${kitty_shell}/${kitty_file}"
			if [ -r "$candidate" ]; then
				kitty_integration="$candidate"
			fi
		fi

		if [ -z "$kitty_integration" ]; then
			candidate="/usr/lib/kitty/shell-integration/${kitty_shell}/${kitty_file}"
			if [ -r "$candidate" ]; then
				kitty_integration="$candidate"
			fi
		fi

		if [ -z "$kitty_integration" ]; then
			for candidate in /opt/homebrew/Cellar/kitty/*/shell-integration/"${kitty_shell}"/"${kitty_file}"; do
				[ -r "$candidate" ] || continue
				kitty_integration="$candidate"
				break
			done
		fi

		if [ -n "$kitty_integration" ] && [ -r "$kitty_integration" ]; then
			# shellcheck source=/dev/null
			. "$kitty_integration"
		fi
	fi

	unset candidate
	unset kitty_shell
	unset kitty_file
	unset kitty_integration
fi

# Keep tmux global PATH in sync so plugins launched in tmux popups
# can find tools installed by asdf, Homebrew, etc.
if [ -n "${TMUX:-}" ]; then
	tmux set-environment -g PATH "$PATH" 2>/dev/null || true
fi
