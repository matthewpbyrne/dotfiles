# shellcheck shell=sh

up() {
	cd ..
}

# Internal utils

_open_files() {
	if command -v nvim >/dev/null 2>&1; then
		nvim -O "$@"
	elif command -v vim >/dev/null 2>&1; then
		vim -O "$@"
	elif [ -n "${EDITOR:-}" ]; then
		"$EDITOR" "$@"
	else
		vi "$@"
	fi
}

# Dotfiles

rc() {
	_open_files "$HOME"/.shell/*
}

zprofile_edit() {
	"$EDITOR" "$HOME/.profile"
}

bashrc_edit() {
	"$EDITOR" "$HOME/.bashrc"
}

dotfiles() {
	_open_files \
		"$HOME/.profile" \
		"$HOME/.bashrc" \
		"$HOME/.config/tmux/tmux.conf" \
		"$HOME/.shell/"* \
		"${ZDOTDIR:-$HOME}/.zshrc"
}

# Containers

ctr() {
	if command -v podman >/dev/null 2>&1; then
		podman "$@"
	elif command -v docker >/dev/null 2>&1; then
		docker "$@"
	else
		printf 'ctr: no container CLI found\n' >&2
		return 1
	fi
}

dcupd() {
	if command -v podman-compose >/dev/null 2>&1; then
		podman-compose up -d "$@"
	elif command -v docker >/dev/null 2>&1; then
		docker compose up -d "$@"
	elif command -v docker-compose >/dev/null 2>&1; then
		docker-compose up -d "$@"
	else
		printf 'dcupd: no supported compose tool found\n' >&2
		return 1
	fi
}

# Navigation / fuzzy helpers

_fzf_preview_cmd() {
	if command -v bat >/dev/null 2>&1; then
		printf '%s' 'bat --style=numbers --color=always --line-range=:200 {}'
	elif command -v batcat >/dev/null 2>&1; then
		printf '%s' 'batcat --style=numbers --color=always --line-range=:200 {}'
	else
		printf '%s' 'sed -n "1,200p" {}'
	fi
}

# Fuzzy-find a file and open it in $EDITOR.
ff() {
	command -v fzf >/dev/null 2>&1 || return 1

	if command -v fd >/dev/null 2>&1; then
		selected_file="$(fd --type f --hidden --follow --exclude .git | fzf --preview "$(_fzf_preview_cmd)")"
	else
		selected_file="$(find . -type f 2>/dev/null | fzf --preview "$(_fzf_preview_cmd)")"
	fi

	[ -n "$selected_file" ] || return 0
	"${EDITOR:-vi}" "$selected_file"
}

# Fuzzy-search shell history and print the chosen command.
fh() {
	command -v fzf >/dev/null 2>&1 || return 1

	if [ -n "${ZSH_VERSION:-}" ]; then
		selected_history="$(fc -rl 1 | sed 's/^[[:space:]]*[0-9][0-9]*[[:space:]]*//' | fzf --tac)"
	else
		selected_history="$(history | sed 's/^[[:space:]]*[0-9][0-9]*[[:space:]]*//' | fzf --tac)"
	fi

	[ -n "$selected_history" ] || return 0
	printf '%s\n' "$selected_history"
}

# Fuzzy-select a git branch and switch to it.
fbr() {
	command -v git >/dev/null 2>&1 || return 1
	command -v fzf >/dev/null 2>&1 || return 1

	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1
	selected_branch="$(git for-each-ref --format='%(refname:short)' refs/heads refs/remotes | sed 's#^origin/##' | awk '!seen[$0]++' | fzf)"
	[ -n "$selected_branch" ] || return 0
	git switch "$selected_branch"
}

# Fuzzy-select and attach/switch to an existing tmux session.
tss() {
	command -v tmux >/dev/null 2>&1 || return 1
	command -v fzf >/dev/null 2>&1 || return 1

	selected_session="$(tmux list-sessions -F '#S' 2>/dev/null | fzf)"
	[ -n "$selected_session" ] || return 0

	if [ -n "${TMUX:-}" ]; then
		tmux switch-client -t "$selected_session"
	else
		tmux attach-session -t "$selected_session"
	fi
}

# Jump to a frequently used project directory via zoxide.
zproj() {
	command -v z >/dev/null 2>&1 || return 1
	z code "$@"
}

# Fuzzy-select from zoxide-ranked directories and jump there.
zjump() {
	command -v zoxide >/dev/null 2>&1 || return 1
	command -v fzf >/dev/null 2>&1 || return 1

	selected_dir="$(zoxide query -l | fzf)"
	[ -n "$selected_dir" ] || return 0
	cd "$selected_dir" || return 1
}
