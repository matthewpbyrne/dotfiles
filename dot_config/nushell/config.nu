# Nushell trial config (chezmoi-managed)
# Loaded for interactive Nu sessions.

$env.config = ($env.config
    | upsert show_banner false
    | upsert edit_mode emacs
    | upsert history {
        max_size: 20_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: true
    }
)

$env.EDITOR = ($env.EDITOR? | default "nvim")

let local_bin = ($"($env.HOME)/.local/bin" | path expand)
if ($local_bin not-in $env.PATH) {
    $env.PATH = ($env.PATH | prepend $local_bin)
}

alias ll = ls -la
alias g = git
alias v = nvim

def --env mkcd [dir: path] {
    mkdir $dir
    cd $dir
}

# Extend later: prompt command, Nu modules, and custom completions.
