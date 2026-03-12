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
		"$HOME/.tmux.conf" \
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

# tmux profile helpers
#
# These helpers launch tmux servers with separate sockets per profile so profile
# config stays server-scoped and does not clash.

_tmux_profile_name() {
	profile=${1:-default}

	case "$profile" in
	*[!A-Za-z0-9_-]* | '')
		printf '%s\n' "invalid tmux profile '$profile' (allowed: A-Za-z0-9_-); using default" >&2
		printf '%s' default
		return
		;;
	esac

	printf '%s' "$profile"
}

tmux_profiles() {
	if [ -d "$HOME/.config/tmux/profiles" ]; then
		find "$HOME/.config/tmux/profiles" -maxdepth 1 -type f -name '*.conf' -print |
			sed 's#^.*/##' |
			sed 's/\.conf$//' |
			sort
	else
		printf '%s\n' default
	fi
}

tmuxp() {
	if ! command -v tmux >/dev/null 2>&1; then
		printf '%s\n' 'tmux is not installed or not on PATH' >&2
		return 127
	fi

	profile=$(_tmux_profile_name "$1")
	socket="profile-${profile}"

	if [ "$#" -gt 0 ]; then
		shift
	fi

	if [ "$#" -gt 0 ]; then
		TMUX_PROFILE="$profile" tmux -L "$socket" "$@"
		unset profile socket
		return
	fi

	# Default UX: attach to existing server or create a new session on this profile socket.
	TMUX_PROFILE="$profile" tmux -L "$socket" new-session -A -s main
	unset profile socket
}
