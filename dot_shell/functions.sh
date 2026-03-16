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
	if type -P podman >/dev/null 2>&1; then
		podman "$@"
	elif type -P docker >/dev/null 2>&1; then
		docker "$@"
	else
		printf 'ctr: no container CLI found\n' >&2
		return 1
	fi
}

dcupd() {
	if type -P podman-compose >/dev/null 2>&1; then
		podman-compose up -d "$@"
	elif type -P docker >/dev/null 2>&1; then
		docker compose up -d "$@"
	elif type -P docker-compose >/dev/null 2>&1; then
		docker-compose up -d "$@"
	else
		printf 'dcupd: no supported compose tool found\n' >&2
		return 1
	fi
}
