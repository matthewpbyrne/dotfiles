#!/bin/sh

profile=${TMUX_PROFILE-}

case "$profile" in
'' | *[!A-Za-z0-9_-]*)
	profile=default
	;;
esac

if [ ! -f "$HOME/.config/tmux/profiles/$profile.conf" ]; then
	profile=default
fi


tmux_socket=${TMUX%%,*}
tmux_socket_args=
if [ -n "$tmux_socket" ]; then
	tmux_socket_args="-S $tmux_socket"
fi

# shellcheck disable=SC2086 # intentional word splitting for optional socket args
tmux $tmux_socket_args set -g @tmux_profile "$profile" \; \
	set-environment -g TMUX_PROFILE "$profile" \; \
	source-file "$HOME/.config/tmux/profiles/$profile.conf"
