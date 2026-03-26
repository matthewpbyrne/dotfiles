#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

alacritty_file="${repo_root}/dot_config/alacritty/private_alacritty.toml"
kitty_file="${repo_root}/dot_config/kitty/kitty.conf"
ghostty_file="${repo_root}/dot_config/ghostty/config"

assert_line() {
  local file="$1"
  local pattern="$2"
  local description="$3"
  if ! grep -Eq "$pattern" "$file"; then
    echo "Missing or mismatched ${description} in ${file}" >&2
    return 1
  fi
}

echo "Checking shared terminal defaults..."

# Shell/login behavior
assert_line "$alacritty_file" '^[[:space:]]*program = "/bin/zsh"$' "alacritty shell program"
assert_line "$alacritty_file" '^[[:space:]]*args = \["--login"\]$' "alacritty login arg"
assert_line "$kitty_file" '^shell /bin/zsh --login$' "kitty shell command"
assert_line "$ghostty_file" '^command = /bin/zsh --login$' "ghostty shell command"

# Font size baseline
assert_line "$alacritty_file" '^[[:space:]]*size = 12$' "alacritty font size"
assert_line "$kitty_file" '^font_size 12\.0$' "kitty font size"
assert_line "$ghostty_file" '^font-size = 12$' "ghostty font size"

# Padding baseline
assert_line "$alacritty_file" '^[[:space:]]*x = 2$' "alacritty window padding x"
assert_line "$alacritty_file" '^[[:space:]]*y = 2$' "alacritty window padding y"
assert_line "$kitty_file" '^window_padding_width 2$' "kitty window padding"
assert_line "$ghostty_file" '^window-padding-x = 2$' "ghostty window padding x"
assert_line "$ghostty_file" '^window-padding-y = 2$' "ghostty window padding y"

# Opacity baseline
assert_line "$alacritty_file" '^[[:space:]]*opacity = 0\.9$' "alacritty opacity"
assert_line "$kitty_file" '^background_opacity 0\.9$' "kitty opacity"
assert_line "$ghostty_file" '^background-opacity = 0\.9$' "ghostty opacity"

echo "Terminal default checks passed."
