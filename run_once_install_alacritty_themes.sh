#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/alacritty/themes"

if [ ! -d "$THEME_DIR/.git" ]; then
  if [ -d "$THEME_DIR" ] && [ -n "$(ls -A "$THEME_DIR" 2>/dev/null || true)" ]; then
    echo "Alacritty themes directory '$THEME_DIR' already exists and is not a git repository."
    echo "Please move or remove it before running this installer again."
    exit 1
  fi
  mkdir -p "$(dirname "$THEME_DIR")"
  echo "Installing Alacritty themes..."
  git clone https://github.com/alacritty/alacritty-theme "$THEME_DIR"
else
  echo "Updating Alacritty themes..."
  git -C "$THEME_DIR" pull --ff-only
fi
