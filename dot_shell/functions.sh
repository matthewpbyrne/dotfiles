# shellcheck shell=sh

up() {
	cd ..
}

rc() {
	"$EDITOR" -O "$HOME"/.shell/*
}

zprofile_edit() {
	"$EDITOR" "$HOME/.profile"
}

bashrc_edit() {
	"$EDITOR" "$HOME/.bashrc"
}

dotfiles() {
	"$EDITOR" -O \
		"$HOME/.profile" \
		"$HOME/.bashrc" \
		"$HOME/.tmux.conf" \
		"$HOME/.shell/"* \
		"${ZDOTDIR:-$HOME}/.zshrc"
}
