# Elvish trial config (chezmoi-managed)
# Keep this intentionally small for quick test drives.

if (not (has-env EDITOR)) {
  set-env EDITOR nvim
}

if (not (has-value $paths $E:HOME/.local/bin)) {
  set paths = [$E:HOME/.local/bin $@paths]
}

edit:abbr ll = 'ls -alF'
edit:abbr g = git
edit:abbr v = nvim

fn mkcd {|dir|
  mkdir -p $dir
  cd $dir
}

# Extend later: prompt styling and custom arg completers.
