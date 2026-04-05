# Managed by chezmoi
# ruff: noqa: F821

import os

config.load_autoconfig()

c.editor.command = [os.path.expanduser("~/.local/bin/editor"), "{file}"]
