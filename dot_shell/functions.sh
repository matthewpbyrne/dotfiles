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
		printf '%s' 'bat --style=numbers --color=always --line-range=:200 -- {}'
	elif command -v batcat >/dev/null 2>&1; then
		printf '%s' 'batcat --style=numbers --color=always --line-range=:200 -- {}'
	else
		printf '%s' 'sh -c '"'"'sed -n "1,200p" < "$1"'"'"' sh {}'
	fi
}

_fzf_dir_preview_cmd() {
	if command -v eza >/dev/null 2>&1; then
		printf '%s' 'eza --long --all {}'
	else
		printf '%s' 'ls -la {}'
	fi
}

# Fuzzy-find a file and open it in $EDITOR.
ff() {
	command -v fzf >/dev/null 2>&1 || return 1

	if command -v fd >/dev/null 2>&1; then
		_ff_selected_file="$(fd --type f --hidden --exclude .git --exclude .direnv --exclude node_modules | fzf --preview "$(_fzf_preview_cmd)")"
	else
		_ff_selected_file="$(find . \
			-type d \( -name .git -o -name .direnv -o -name node_modules \) -prune -o \
			-type f -print 2>/dev/null | fzf --preview "$(_fzf_preview_cmd)")"
	fi

	if [ -z "$_ff_selected_file" ]; then
		unset _ff_selected_file
		return 0
	fi

	"${EDITOR:-vi}" "$_ff_selected_file"
	unset _ff_selected_file
}

# Fuzzy-search shell history and print the chosen command.
fh() {
	command -v fzf >/dev/null 2>&1 || return 1

	if [ -n "${ZSH_VERSION:-}" ]; then
		_fh_selected_history="$(fc -rl 1 | sed 's/^[[:space:]]*[0-9][0-9]*[[:space:]]*//' | fzf --tac)"
	else
		_fh_selected_history="$(history | sed 's/^[[:space:]]*[0-9][0-9]*[[:space:]]*//' | fzf --tac)"
	fi

	if [ -z "$_fh_selected_history" ]; then
		unset _fh_selected_history
		return 0
	fi

	printf '%s\n' "$_fh_selected_history"
	unset _fh_selected_history
}

# Fuzzy-select a git branch and switch to it.
fbr() {
	command -v git >/dev/null 2>&1 || return 1
	command -v fzf >/dev/null 2>&1 || return 1

	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1
	_fbr_selected_branch="$(git for-each-ref --format='%(refname:short)' refs/heads refs/remotes \
		| grep -v '/HEAD$' \
		| awk '!seen[$0]++' \
		| fzf)"
	if [ -z "$_fbr_selected_branch" ]; then
		unset _fbr_selected_branch
		return 0
	fi
	if git show-ref --verify --quiet "refs/heads/$_fbr_selected_branch"; then
		# Selected name matches a local branch; switch to it directly.
		git switch "$_fbr_selected_branch"
	elif git show-ref --verify --quiet "refs/remotes/$_fbr_selected_branch"; then
		# Selected name matches a remote-tracking branch.
		_fbr_local_branch="${_fbr_selected_branch#*/}"
		if git show-ref --verify --quiet "refs/heads/$_fbr_local_branch"; then
			# Local branch already exists; switch to it.
			git switch "$_fbr_local_branch"
		else
			# Create a local branch that tracks the selected remote branch.
			git switch -c "$_fbr_local_branch" --track "$_fbr_selected_branch"
		fi
		unset _fbr_local_branch
	else
		# Fallback for non-standard selections.
		git switch "$_fbr_selected_branch"
	fi
	unset _fbr_selected_branch
}

# Fuzzy-select and attach/switch to an existing tmux session.
tss() {
	command -v tmux >/dev/null 2>&1 || return 1
	command -v fzf >/dev/null 2>&1 || return 1

	_tss_selected_session="$(tmux list-sessions -F '#S' 2>/dev/null | fzf)"
	if [ -z "$_tss_selected_session" ]; then
		unset _tss_selected_session
		return 0
	fi

	if [ -n "${TMUX:-}" ]; then
		tmux switch-client -t "$_tss_selected_session"
	else
		tmux attach-session -t "$_tss_selected_session"
	fi

	unset _tss_selected_session
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

	_zjump_selected_dir="$(zoxide query -l | fzf)"
	if [ -z "$_zjump_selected_dir" ]; then
		unset _zjump_selected_dir
		return 0
	fi
	cd "$_zjump_selected_dir" || {
		unset _zjump_selected_dir
		return 1
	}
	unset _zjump_selected_dir
}
