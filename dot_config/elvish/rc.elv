# Elvish trial config (chezmoi-managed)
# Keep this intentionally small for quick test drives.

if (not (has-env EDITOR)) {
  set-env EDITOR nvim
}

set-env PATH $E:HOME/.local/bin:$E:PATH

edit:abbr ll = 'ls -alF'
edit:abbr g = git
edit:abbr v = nvim

fn mkcd {|dir|
  mkdir -p $dir
  cd $dir
}

# Extend later: prompt styling and custom arg completers.
