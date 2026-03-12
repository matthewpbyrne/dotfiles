# shellcheck shell=sh

if command -v go >/dev/null 2>&1; then
	GOBIN="$(go env GOPATH)/bin"
	export GOBIN

	GOROOT="$(go env GOROOT)"
	export GOROOT
fi

[ -n "${GOBIN:-}" ] && export PATH="$GOBIN:$PATH"

command -v luarocks >/dev/null 2>&1 && eval "$(luarocks path)"
