#!/usr/bin/env bash
set -euo pipefail

ANTIDOTE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"

# Ensure parent directory exists before cloning.
ANTIDOTE_PARENT_DIR="$(dirname "$ANTIDOTE_DIR")"
mkdir -p "$ANTIDOTE_PARENT_DIR"

# Ensure git is available before attempting to clone.
if ! command -v git >/dev/null 2>&1; then
    printf '%s\n' "Error: git is not installed or not on PATH; cannot install antidote." >&2
    exit 1
fi
if [ ! -d "$ANTIDOTE_DIR" ]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
fi
