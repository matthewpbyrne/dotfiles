#!/bin/sh

profile=${TMUX_PROFILE-}

case "$profile" in
'' | *[!A-Za-z0-9_-]*)
	exit 1
	;;
esac

if [ ! -f "$HOME/.config/tmux/profiles/$profile.conf" ]; then
	exit 1
fi

tmux set -g @tmux_profile "$profile" \; \
	set-environment -g TMUX_PROFILE "$profile" \; \
	source-file "$HOME/.config/tmux/profiles/$profile.conf"
