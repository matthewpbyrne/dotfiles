#!/bin/sh

# Launch extrakto from common install locations.
for candidate in \
	"$HOME/.tmux/plugins/extrakto/scripts/open.sh" \
	"$HOME/.tmux/plugins/extrakto/extrakto.sh" \
	"$HOME/.tmux/plugins/extrakto/scripts/extrakto.sh"
do
	if [ -x "$candidate" ]; then
		exec "$candidate"
	fi
done

# Fall back to a visible tmux hint if plugin scripts are unavailable.
if command -v tmux >/dev/null 2>&1; then
	tmux display-message 'extrakto script not found; run prefix+I'
fi

exit 1
