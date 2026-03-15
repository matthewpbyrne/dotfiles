#!/bin/sh

profile=${TMUX_PROFILE-}

case "$profile" in
''|*[!A-Za-z0-9_-]*)
	profile=default
	;;
esac

if [ ! -f "$HOME/.config/tmux/profiles/$profile.conf" ]; then
	profile=default
fi


if ! tmux_bin=$(command -v tmux 2>/dev/null); then
	echo "apply_profile.sh: tmux not found in PATH" >&2
	exit 127
fi

tmux_socket=${TMUX_APPLY_SOCKET-}
if [ -z "$tmux_socket" ]; then
	tmux_socket=${TMUX%%,*}
fi

if [ -n "$tmux_socket" ]; then
	"$tmux_bin" -S "$tmux_socket" set -s @tmux_profile "$profile" \; \
		set-environment -g TMUX_PROFILE "$profile" \; \
		source-file "$HOME/.config/tmux/profiles/$profile.conf"
else
	"$tmux_bin" set -s @tmux_profile "$profile" \; \
		set-environment -g TMUX_PROFILE "$profile" \; \
		source-file "$HOME/.config/tmux/profiles/$profile.conf"
fi
