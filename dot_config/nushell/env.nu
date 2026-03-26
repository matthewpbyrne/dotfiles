# Nushell trial environment file (chezmoi-managed)
# Keep this lightweight; prefer config.nu for interactive behavior.

$env.EDITOR = ($env.EDITOR? | default "nvim")
