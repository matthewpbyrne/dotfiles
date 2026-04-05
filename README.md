## Introduction

This repository manages my dotfiles using [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

To bootstrap a new machine, install `chezmoi` and apply this repo:

Run this command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" \
  && PATH="$HOME/.local/bin:$PATH" \
  && chezmoi init --apply matthewpbyrne
```

After that, chezmoi manages all configuration and bootstrap scripts.

## External editor (Neovim + qutebrowser)

A small wrapper script is installed at `~/.local/bin/editor` (source file: `dot_local/bin/executable_editor`).

- In a terminal, it runs `nvim` directly.
- Outside a terminal, it launches `nvim` in `kitty` when available, with fallback to `x-terminal-emulator`.
- All arguments are passed through unchanged.

qutebrowser is configured with:

- `c.editor.command = ["editor", "{file}"]`

So browser textarea editing (for example `Ctrl+e`) opens in Neovim and writes back when you save and quit.

Quick test:

1. Run `editor /tmp/editor-test.txt` from a shell.
2. In qutebrowser, focus a textarea and trigger edit (`Ctrl+e` by default).
3. Save and quit Neovim (`:wq`) and confirm text is written back into the page.
