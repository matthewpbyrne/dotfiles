# shellcheck shell=sh

# General shortcuts
# ls
alias ls_='/usr/bin/ls'
if command -v eza >/dev/null 2>&1; then
	alias ls='eza --long --header --icons --git'
elif command -v exa >/dev/null 2>&1; then
	alias ls='exa --long --header --icons --git'
fi

alias rr='ranger'
alias lg='lazygit'
alias xo='xdg-open'
alias notes='nvim ~/.wipnotes'

# Oh My Zsh helpers
alias opi='omz plugin info'
alias opl='omz plugin list'

# Tools
alias plantuml='java -jar ~/.local/lib/plantuml.jar'

# Ruby tool version pinning
alias ripper-tags='ASDF_RUBY_VERSION=3.0.2 ripper-tags'
alias starscope='ASDF_RUBY_VERSION=3.1.1 starscope'

# Editors
alias e='$EDITOR'
alias ec='emacsclient'

# Neovim / Vim configs
alias vimrc='$EDITOR $HOME/.config/nvim/init.lua'

# Shell / dotfiles
alias conf_aliases='$EDITOR ~/.shell/aliases.sh'
alias conf_functions='$EDITOR ~/.shell/functions.sh'
alias conf_tmux='$EDITOR ~/.config/tmux/tmux.conf'
alias zshrc='$EDITOR ${ZDOTDIR:-$HOME}/.zshrc'
