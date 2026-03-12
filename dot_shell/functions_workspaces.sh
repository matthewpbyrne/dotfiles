# shellcheck shell=bash

: "${WORKSPACE_HOME:=$HOME/workspaces}"

_ws_require_dir() {
	mkdir -p "$1"
}

_ws_slug() {
	# spaces -> dashes, lowercase, strip awkward chars
	printf '%s' "$*" |
		tr '[:upper:]' '[:lower:]' |
		sed -E 's/[^a-z0-9._-]+/-/g; s/^-+//; s/-+$//; s/-+/-/g'
}

_ws_timestamp() {
	date +%Y%m%d-%H%M%S
}

_ws_realpath() {
	if command -v realpath >/dev/null 2>&1; then
		if realpath -m / >/dev/null 2>&1; then
			realpath -m "$1"
			return
		fi
	fi

	if command -v python3 >/dev/null 2>&1; then
		python3 -c 'import os, sys; print(os.path.abspath(sys.argv[1]))' "$1"
		return
	fi

	printf '%s\n' "$1"
}

ws() {
	# Usage:
	#   ws                    -> cd WORKSPACE_HOME
	#   ws scratch            -> cd ~/workspaces/scratch
	#   ws scratch my spike   -> cd ~/workspaces/scratch/my-spike
	#   ws dev api refactor   -> cd ~/workspaces/dev/api-refactor

	local area dir name
	area="${1:-}"

	if [ -z "$area" ]; then
		_ws_require_dir "$WORKSPACE_HOME" || return
		cd "$WORKSPACE_HOME" || return
		return
	fi

	shift || return

	if [ "$#" -gt 0 ]; then
		name="$(_ws_slug "$@")"
		dir="$WORKSPACE_HOME/$area/$name"
	else
		dir="$WORKSPACE_HOME/$area"
	fi

	_ws_require_dir "$dir" || return
	cd "$dir" || return
}

wsn() {
	# New timestamped workspace
	# Usage:
	#   wsn scratch
	#   wsn scratch graphql spike
	#   wsn notes architecture ideas

	local area dir label ts
	area="${1:-scratch}"
	ts="$(_ws_timestamp)"

	if [ "$#" -gt 0 ]; then
		shift || return
	fi

	if [ "$#" -gt 0 ]; then
		label="$(_ws_slug "$@")"
		dir="$WORKSPACE_HOME/$area/$ts-$label"
	else
		dir="$WORKSPACE_HOME/$area/$ts"
	fi

	_ws_require_dir "$dir" || return
	cd "$dir" || return
}

wsl() {
	# List workspaces
	# Usage:
	#   wsl
	#   wsl scratch

	local dir
	dir="${WORKSPACE_HOME}${1:+/$1}"
	[ -d "$dir" ] || return 1
	find "$dir" -mindepth 1 -maxdepth 2 -type d | sort
}

wso() {
	# Open workspace dir in editor
	ws "$@" || return
	"$EDITOR" .
}

wsr() {
	# Open workspace dir in ranger
	ws "$@" || return
	ranger .
}

wslast() {
	# Jump to most recently modified workspace beneath a category
	# Usage:
	#   wslast scratch
	#   wslast dev

	local area base dir
	area="${1:-scratch}"
	base="$WORKSPACE_HOME/$area"
	[ -d "$base" ] || return 1

	dir="$(
		find "$base" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' 2>/dev/null |
			sort -nr |
			head -n1 |
			cut -d' ' -f2-
	)"

	[ -n "$dir" ] || return 1
	cd "$dir" || return
}

wslasto() {
	wslast "${1:-scratch}" || return
	"$EDITOR" .
}

wslastr() {
	wslast "${1:-scratch}" || return
	ranger .
}

wsgit() {
	# New git workspace
	# Usage:
	#   wsgit dev shell cleanup
	#   wsgit dev graphql schema spike

	local area
	area="${1:-dev}"

	if [ "$#" -gt 0 ]; then
		shift || return
	fi

	wsn "$area" "$@" || return
	git init >/dev/null 2>&1 || return
}

wspy() {
	# New Python workspace with venv + gitignore
	# Usage:
	#   wspy scratch test pydantic
	#   wspy scratch graphql schema spike

	local area
	area="${1:-scratch}"

	if [ "$#" -gt 0 ]; then
		shift || return
	fi

	wsn "$area" "$@" || return
	python3 -m venv .venv || return

	cat >.gitignore <<'EOF'
.venv/
__pycache__/
.pytest_cache/
.mypy_cache/
EOF
}

wsnode() {
	# New Node workspace
	# Usage:
	#   wsnode scratch relay spike
	#   wsnode dev nx plugin experiment

	local area
	area="${1:-scratch}"

	if [ "$#" -gt 0 ]; then
		shift || return
	fi

	wsn "$area" "$@" || return
	npm init -y >/dev/null 2>&1 || return
}

wsrm() {
	# Remove a workspace by absolute path or relative to WORKSPACE_HOME
	# Usage:
	#   wsrm scratch/foo
	#   wsrm /full/path/to/workspace

	local workspace_root target requested
	requested="$1"

	[ -n "$requested" ] || return 1

	workspace_root="$(_ws_realpath "$WORKSPACE_HOME")" || return 1

	case "$requested" in
	/*) target="$requested" ;;
	*) target="$WORKSPACE_HOME/$requested" ;;
	esac

	target="$(_ws_realpath "$target")" || return 1

	case "$target" in
	"$workspace_root" | "${workspace_root}/")
		printf 'wsrm: refusing to remove WORKSPACE_HOME itself: %s\n' "$target" >&2
		return 1
		;;
	"$workspace_root"/*) ;;

	*)
		printf 'wsrm: refusing to remove path outside WORKSPACE_HOME: %s\n' "$target" >&2
		return 1
		;;
	esac

	[ -d "$target" ] || return 1
	rm -rf -- "$target"
}
