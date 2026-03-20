# PATH ordering policy for zsh
typeset -U path

path=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	"$HOME/.cabal/bin"
	"$HOME/.ghcup/bin"
	"$HOME/.luarocks/bin"
	"${PNPM_HOME:-$HOME/.local/share/pnpm}"
	"${GOBIN:-}"
	"${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
	"${ASDF_DATA_DIR:-$HOME/.asdf}/bin"
	"/home/linuxbrew/.linuxbrew/bin"
	"/usr/local/bin"
	"/usr/bin"
	"/bin"
	"/snap/bin"
	$path
)

path=(${path:#""})
export PATH
