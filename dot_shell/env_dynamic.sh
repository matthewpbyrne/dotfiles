# shellcheck shell=sh

# Tool-managed base dirs
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

# Preferred editor (PATH-dependent)
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
  if [ -z "${GOBIN:-}" ]; then
    GOBIN="$(go env GOBIN 2> /dev/null)"
    if [ -z "$GOBIN" ]; then
      go_gopath="$(go env GOPATH 2> /dev/null)"
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
  ghostty | iTerm.app | WezTerm | Apple_Terminal)
    colorterm_hint=1
    ;;
esac

if [ -z "$colorterm_hint" ]; then
  case "${TERM:-}" in
    alacritty | ghostty | xterm-kitty)
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
    if [ -n "${KITTY_INSTALLATION_DIR:-}" ]; then
      kitty_candidate="${KITTY_INSTALLATION_DIR}/shell-integration/${kitty_shell}/${kitty_file}"
      if [ -r "$kitty_candidate" ]; then
        kitty_integration="$kitty_candidate"
      fi
    fi

    if [ -z "$kitty_integration" ]; then
      kitty_candidate="/usr/lib/kitty/shell-integration/${kitty_shell}/${kitty_file}"
      if [ -r "$kitty_candidate" ]; then
        kitty_integration="$kitty_candidate"
      fi
    fi

    if [ -z "$kitty_integration" ]; then
      for kitty_prefix in /opt/homebrew/opt/kitty /home/linuxbrew/.linuxbrew/opt/kitty; do
        kitty_candidate="${kitty_prefix}/shell-integration/${kitty_shell}/${kitty_file}"
        if [ -r "$kitty_candidate" ]; then
          kitty_integration="$kitty_candidate"
          break
        fi
      done
    fi

    if [ -z "$kitty_integration" ]; then
      kitty_sort_mode=
      if command -v gsort > /dev/null 2>&1 && gsort -V < /dev/null > /dev/null 2>&1; then
        kitty_sort_mode="gsort"
      elif sort -V < /dev/null > /dev/null 2>&1; then
        kitty_sort_mode="sort"
      else
        kitty_sort_mode="lex"
      fi

      for kitty_cellar in /opt/homebrew/Cellar/kitty /home/linuxbrew/.linuxbrew/Cellar/kitty; do
        [ -d "$kitty_cellar" ] || continue
        if [ "$kitty_sort_mode" = "gsort" ]; then
          kitty_version_dir="$(find "$kitty_cellar" -mindepth 1 -maxdepth 1 -type d 2> /dev/null | gsort -V | tail -n 1)"
        elif [ "$kitty_sort_mode" = "sort" ]; then
          kitty_version_dir="$(find "$kitty_cellar" -mindepth 1 -maxdepth 1 -type d 2> /dev/null | sort -V | tail -n 1)"
        else
          kitty_version_dir="$(find "$kitty_cellar" -mindepth 1 -maxdepth 1 -type d 2> /dev/null | sort | tail -n 1)"
        fi
        [ -n "$kitty_version_dir" ] || continue
        kitty_candidate="${kitty_version_dir}/shell-integration/${kitty_shell}/${kitty_file}"
        if [ -r "$kitty_candidate" ]; then
          kitty_integration="$kitty_candidate"
          break
        fi
      done
    fi

    if [ -n "$kitty_integration" ] && [ -r "$kitty_integration" ]; then
      # shellcheck source=/dev/null
      . "$kitty_integration"
    fi
  fi

  unset kitty_candidate
  unset kitty_prefix
  unset kitty_cellar
  unset kitty_version_dir
  unset kitty_sort_mode
  unset kitty_shell
  unset kitty_file
  unset kitty_integration
fi

# Keep tmux global PATH in sync so plugins launched in tmux popups
# can find tools installed by asdf, Homebrew, etc.
if [ -n "${TMUX:-}" ] && command -v tmux > /dev/null 2>&1; then
  tmux set-environment -g PATH "$PATH" 2> /dev/null || true
fi
