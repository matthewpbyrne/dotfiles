# Alternative shell trial kit (without replacing zsh)

This repository now includes **trial-use configs** for:

- xonsh
- Nushell
- elvish
- oil (OSH/YSH)
- ion

Your default shell remains zsh. Use these for side-by-side experiments.

## Shell styles at a glance

- **POSIX-like shells**: sh/bash/zsh/osh. Great for existing shell scripts and Unix compatibility.
- **Structured-data shells**: Nushell. Pipelines pass typed tables/records instead of raw text.
- **Pythonic shells**: xonsh. Mix shell commands and Python in one interactive environment.

Cross-shell tools worth considering while experimenting:

- **starship**: one prompt engine reused across many shells.
- **carapace**: cross-shell completion generator.

---

## xonsh

- **What it is**: a Python-powered shell with shell+Python syntax.
- **Why try it**: handy if you like writing quick automation directly in the shell.
- **How it differs from zsh**: Python objects and expressions are first-class in interactive use.
- **Repo config**: `dot_config/xonsh/rc.xsh` -> `~/.config/xonsh/rc.xsh`.

Install examples:

```bash
# pipx route
pipx install xonsh

# distro package route (if available)
sudo apt install xonsh
```

Launch temporarily:

```bash
xonsh
```

---

## Nushell

- **What it is**: a modern shell centered around structured data.
- **Why try it**: strong for inspecting JSON/CSV/tables and composing data-heavy commands.
- **How it differs from zsh**: pipeline values are typed structures, not just text streams.
- **Repo config**:
  - `dot_config/nushell/config.nu` -> `~/.config/nushell/config.nu`
  - `dot_config/nushell/env.nu` -> `~/.config/nushell/env.nu`

Install examples:

```bash
sudo apt install nushell
# or use your distro / release binary / cargo workflow
```

Launch temporarily:

```bash
nu
```

---

## elvish

- **What it is**: a programmable shell with a dedicated language and strong interactive editor.
- **Why try it**: good interactive UX and concise scripting for shell-native workflows.
- **How it differs from zsh**: different language model and editor primitives (not sh-compatible).
- **Repo config**: `dot_config/elvish/rc.elv` -> `~/.config/elvish/rc.elv`.

Install examples:

```bash
sudo apt install elvish
```

Launch temporarily:

```bash
elvish
```

---

## oil (OSH / YSH)

- **What it is**: an evolving shell project; OSH emphasizes safer bash-like behavior and YSH adds newer language features.
- **Why try it**: useful if you want a path from bash-like syntax to stricter shell programming.
- **How it differs from zsh**: closer to bash semantics (OSH) with newer language direction in YSH.
- **Repo config**:
  - `dot_config/oil/oshrc` -> `~/.config/oil/oshrc`
  - `dot_config/oil/yshrc` -> `~/.config/oil/yshrc`

Install examples:

```bash
# package names vary by distro; look for oil / osh / ysh
```

Launch temporarily:

```bash
osh
# or
ysh
```

---

## ion

- **What it is**: a Rust shell project with a lightweight scripting model.
- **Why try it**: useful as a quick comparison point when testing alternative interactive shells.
- **How it differs from zsh**: different syntax and ecosystem; currently less common in daily setups.
- **Repo config**: `dot_config/ion/initrc` -> `~/.config/ion/initrc`.

Install examples:

```bash
# availability can vary a lot by distro/release
# use distro package if available, otherwise build from source
```

Launch temporarily:

```bash
ion
```

---

## tmux + terminal notes

- Keep tmux launched from your normal zsh session.
- Inside tmux, start trial shells in a pane/window (`nu`, `xonsh`, `elvish`, `osh`, `ion`).
- This avoids changing your login shell while still letting you test keybindings, prompt behavior, and history.

## Non-goals and cleanup

- No login-shell switch is performed here.
- No replacement of existing zsh/tmux workflows.
- No plugin frameworks were added.

To remove this trial kit later, delete the shell-specific directories under `dot_config/` and this doc page.

## Quick evaluation checklist

After `chezmoi apply`, run these commands from your existing zsh session:

```bash
# Verify binaries are present
command -v xonsh nu elvish osh ion

# Launch each shell manually (exit after a quick test)
xonsh
nu
elvish
osh
ion

# Optional: run inside tmux panes
# (from tmux) prefix + c, then launch one shell per pane/window
```

What to test in each shell:

1. Prompt readability and startup latency.
2. History behavior (`Ctrl-r`, persistence across sessions).
3. PATH pickup (`command -v nvim`, `command -v git`).
4. Alias/function basics (`ll`, `mkcd /tmp/test-shell`).
5. tmux behavior (copy mode, key passthrough, colors).
