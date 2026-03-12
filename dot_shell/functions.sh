# shellcheck shell=sh

up() {
	cd ..
}

rc() {
	"$EDITOR" "$HOME"/.shell/* -O
}

zprofile_edit() {
	"$EDITOR" "$HOME/.profile"
}

bashrc_edit() {
	"$EDITOR" "$HOME/.bashrc"
}

dotfiles() {
	"$EDITOR" \
		"$HOME/.profile" \
		"$HOME/.bashrc" \
		"$HOME/.tmux.conf" \
		"$HOME/.shell/"* \
		"${ZDOTDIR:-$HOME}/.zshrc" -O
}
