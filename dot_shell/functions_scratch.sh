# shellcheck shell=bash

: "${SCRATCH_HOME:=$HOME/tmp}"

sp() {
	local dir
	dir="$SCRATCH_HOME/scratchpad-$(date +%Y%m%d)"
	mkdir -p "$dir" && cd "$dir" || return 1
}

scratch_new() {
	local name dir
	name="${1:-scratch-$(date +%Y%m%d-%H%M%S)}"
	dir="$SCRATCH_HOME/$name"
	mkdir -p "$dir" && cd "$dir" || return 1
}

scratch_last_created() {
	find "$SCRATCH_HOME" -maxdepth 1 -type d -name 'scratchpad-*' | sort | tail -n 1
}

scratch_last_modified() {
	find "$SCRATCH_HOME" -maxdepth 3 -type d -name 'scratchpad-*' -print0 2>/dev/null |
		xargs -0 stat -c '%Y %n' 2>/dev/null |
		sort -nr |
		head -n 1 |
		cut -d' ' -f2-
}

spn() {
	local dir
	dir="$(scratch_last_created)" || return 1
	[ -n "$dir" ] && ranger "$dir"
}

spcn() {
	local dir
	dir="$(scratch_last_created)" || return 1
	[ -n "$dir" ] && cd "$dir" || return 1
}

spl() {
	local dir
	dir="$(scratch_last_modified)" || return 1
	[ -n "$dir" ] && ranger "$dir"
}

spcl() {
	local dir
	dir="$(scratch_last_modified)" || return 1
	[ -n "$dir" ] && cd "$dir" || return 1
}

scratch_ls() {
	find "$SCRATCH_HOME" -maxdepth 1 -type d -name 'scratchpad-*' | sort
}
