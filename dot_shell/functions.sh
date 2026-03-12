# tmux profile helpers
#
# These helpers launch tmux servers with separate sockets per profile so profile
# config stays server-scoped and does not clash.

_tmux_profile_name() {
  local profile
  profile=${1:-default}

  case "$profile" in
    (*[!A-Za-z0-9_-]*|'')
      printf '%s\n' "invalid tmux profile '$profile' (allowed: A-Za-z0-9_-); using default" >&2
      printf '%s' default
      return
      ;;
  esac

  printf '%s' "$profile"
}

tmux_profiles() {
  if [ -d "$HOME/.config/tmux/profiles" ]; then
    find "$HOME/.config/tmux/profiles" -maxdepth 1 -type f -name '*.conf' -print \
      | sed 's#^.*/##' \
      | sed 's/\.conf$//' \
      | sort
  else
    printf '%s\n' default
  fi
}

tmuxp() {
  if ! command -v tmux >/dev/null 2>&1; then
    printf '%s\n' 'tmux is not installed or not on PATH' >&2
    return 127
  fi

  local profile socket
  profile=$(_tmux_profile_name "$1")
  socket="profile-${profile}"

  shift $(( $# > 0 ? 1 : 0 ))

  if [ "$#" -gt 0 ]; then
    TMUX_PROFILE="$profile" tmux -L "$socket" "$@"
    return
  fi

  # Default UX: attach to existing server or create a new session on this profile socket.
  TMUX_PROFILE="$profile" tmux -L "$socket" new-session -A -s main
}
