# xonsh trial config (chezmoi-managed)

from pathlib import Path

# Keep zsh as the default shell; use xonsh only when explicitly launched.
$EDITOR = @.env.get("EDITOR", "nvim")
$XONSH_HISTORY_SIZE = (20000, "commands")
$HISTCONTROL = "ignoredups"

local_bin = str(Path.home() / ".local" / "bin")
if local_bin not in $PATH:
    $PATH.insert(0, local_bin)

aliases["ll"] = "ls -alF"
aliases["g"] = "git"
aliases["v"] = "nvim"

# Extend later: xontribs, custom prompt, and project-specific helpers.
