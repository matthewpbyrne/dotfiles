#!/usr/bin/env bash
set -euo pipefail

if command -v fdfind >/dev/null 2>&1; then
	mkdir -p "$HOME/.local/bin"

	if ! command -v fd >/dev/null 2>&1; then
		ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
	fi
fi
