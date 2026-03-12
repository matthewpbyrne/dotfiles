# Copilot instructions

This repository uses **AGENTS.md in the repository root as the canonical
instruction file for AI agents**.

Copilot should follow the guidance in `AGENTS.md`.

## Key reminders

- This repository is a **chezmoi source-state repo** rooted at `~/.local/share/chezmoi`.
- Edit **source-state files in this repo** (e.g. `dot_profile`, `dot_bashrc`, `dot_shell/*.sh`), not the applied files in `$HOME`.
- **Do not commit secrets.**
- Use **Conventional Commits**.
- Prefer **minimal diffs** and preserve working shell startup behaviour.
