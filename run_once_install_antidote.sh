#!/usr/bin/env bash
set -euo pipefail

ANTIDOTE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"

if [ ! -d "$ANTIDOTE_DIR" ]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
fi
