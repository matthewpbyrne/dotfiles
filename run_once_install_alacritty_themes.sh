#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/alacritty/themes"

if [ ! -d "$THEME_DIR/.git" ]; then
  echo "Installing Alacritty themes..."
  git clone https://github.com/alacritty/alacritty-theme "$THEME_DIR"
else
  echo "Updating Alacritty themes..."
  git -C "$THEME_DIR" pull --ff-only || true
fi
