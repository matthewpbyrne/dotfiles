# shellcheck shell=sh

if [ -z "${EDITOR}" ]; then
	if [ -x /snap/bin/nvim ]; then
		EDITOR=/snap/bin/nvim
	elif command -v nvim >/dev/null 2>&1; then
		EDITOR=nvim
	elif command -v vim >/dev/null 2>&1; then
		EDITOR=vim
	else
		EDITOR=vi
	fi
fi
export EDITOR

if [ -z "${VISUAL+x}" ]; then
	VISUAL=$EDITOR
fi
export VISUAL
export PAGER=less

export PNPM_HOME="$HOME/.local/share/pnpm"
export WORKSPACE_HOME="$HOME/tmp/workspaces"

export PATH="$HOME/.local/bin:$PNPM_HOME:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin:/snap/bin${PATH:+:$PATH}"
