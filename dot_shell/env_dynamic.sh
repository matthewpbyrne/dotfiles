# shellcheck shell=sh

# Tool-managed base dirs
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Preferred editor (PATH-dependent)
# Keep host/user-provided EDITOR if present.
# To always prefer local detection (nvim/vim/vi), remove this guard.
if [ -z "${EDITOR:-}" ]; then
  if command -v nvim > /dev/null 2>&1; then
    EDITOR="$(command -v nvim)"
  elif command -v vim > /dev/null 2>&1; then
    EDITOR="$(command -v vim)"
  elif command -v vi > /dev/null 2>&1; then
    EDITOR="$(command -v vi)"
  else
    EDITOR="vi"
  fi
fi
export EDITOR

if [ -z "${VISUAL:-}" ]; then
  VISUAL="$EDITOR"
fi
export VISUAL

# Go-derived environment
if command -v go > /dev/null 2>&1; then
  # Keep host/user-provided GOBIN if present.
  # To always recompute and override GOBIN, remove this guard.
  if [ -z "${GOBIN:-}" ]; then
    GOBIN="$(go env GOBIN 2> /dev/null)"
    if [ -z "$GOBIN" ]; then
      go_gopath="${GOPATH:-}"
      if [ -z "$go_gopath" ]; then
        go_gopath="$(go env GOPATH 2> /dev/null)"
      fi
      [ -n "$go_gopath" ] && GOBIN="${go_gopath%%:*}/bin"
      unset go_gopath
    fi
  fi

  if [ -n "${GOBIN:-}" ]; then
    export GOBIN
    if command -v add_tool_path > /dev/null 2>&1; then
      add_tool_path "$GOBIN"
    fi
  fi
fi

# LuaRocks environment
if command -v luarocks > /dev/null 2>&1; then
  luarocks_env="$(luarocks path --shell=sh 2> /dev/null)"
  if [ -n "$luarocks_env" ]; then
    eval "$luarocks_env"
  fi
  unset luarocks_env
fi

# Terminal capability hints
colorterm_hint=
case "${TERM_PROGRAM:-}" in
  ghostty | iTerm.app | WezTerm | Apple_Terminal | Alacritty)
    colorterm_hint=1
    ;;
esac

if [ -z "$colorterm_hint" ]; then
  case "${TERM:-}" in
    ghostty | xterm-ghostty | xterm-kitty)
      colorterm_hint=1
      ;;
  esac
fi

if [ -n "$colorterm_hint" ]; then
  : "${COLORTERM:=truecolor}"
  export COLORTERM
fi
unset colorterm_hint

# Kitty shell integration (if installed) improves cwd/shell state tracking.
if [ "${TERM:-}" = "xterm-kitty" ]; then
  kitty_shell=
  kitty_file=
  kitty_candidate=
  kitty_integration=

  if [ -n "${BASH_VERSION:-}" ] && [ -n "${BASH:-}" ]; then
    kitty_shell="bash"
    kitty_file="kitty.bash"
  elif [ -n "${ZSH_VERSION:-}" ] && [ "${ZSH_NAME:-}" = "zsh" ]; then
    kitty_shell="zsh"
    kitty_file="kitty.zsh"
  fi

  if [ -n "$kitty_shell" ] && [ -n "$kitty_file" ]; then
    for kitty_base in "${KITTY_INSTALLATION_DIR:-}" /usr/lib/kitty /opt/homebrew/opt/kitty /home/linuxbrew/.linuxbrew/opt/kitty; do
      [ -n "$kitty_base" ] || continue
      kitty_candidate="${kitty_base}/shell-integration/${kitty_shell}/${kitty_file}"
      if [ -r "$kitty_candidate" ]; then
        kitty_integration="$kitty_candidate"
        break
      fi
    done

    if [ -n "$kitty_integration" ] && [ -r "$kitty_integration" ]; then
      # shellcheck source=/dev/null
      . "$kitty_integration"
    fi
  fi

  unset kitty_candidate
  unset kitty_base
  unset kitty_shell
  unset kitty_file
  unset kitty_integration
fi

# Keep tmux global PATH in sync so plugins launched in tmux popups
# can find tools installed by asdf, Homebrew, etc.
if [ -n "${TMUX:-}" ] && command -v tmux > /dev/null 2>&1; then
  tmux set-environment -g PATH "$PATH" 2> /dev/null || true
fi
