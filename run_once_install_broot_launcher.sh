#!/usr/bin/env bash
set -euo pipefail

if command -v broot >/dev/null 2>&1; then
	echo "Installing broot br launcher..."
	broot --install
else
	echo "broot not found; skipping br launcher installation."
fi
