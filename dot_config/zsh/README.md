# Rule of thumb

If it uses zsh-specific features, it belongs in the zsh profile directory.
If it is shared shell code intended for both bash and zsh (and may rely on bashisms or common GNU utilities), it belongs under `~/.shell/`.
