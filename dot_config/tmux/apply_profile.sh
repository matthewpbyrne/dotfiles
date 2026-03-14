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

tmux set -g @tmux_profile "$profile" \; \
	set-environment -g TMUX_PROFILE "$profile" \; \
	source-file "$HOME/.config/tmux/profiles/$profile.conf"
