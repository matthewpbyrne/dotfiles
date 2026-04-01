#!/usr/bin/env bash
set -euo pipefail

_broot_marker="${XDG_CONFIG_HOME:-$HOME/.config}/broot/launcher/installed-v4"

if [ -f "$_broot_marker" ]; then
	exit 0
fi

if command -v broot >/dev/null 2>&1; then
	echo "Installing broot br launcher..."
	broot --install
else
	echo "broot not found; skipping br launcher installation. Rerun 'chezmoi apply' after installing broot."
fi
