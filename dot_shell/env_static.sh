# shellcheck shell=sh

if [ -z "${EDITOR}" ]; then
    if command -v nvim >/dev/null 2>&1; then
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
export SCRATCH_HOME="$HOME/tmp"

export PATH="$HOME/.local/bin:$PNPM_HOME:$PATH"
