#!/bin/bash

# Create a new symlink, replacing existing target if necessary
new_symlink() {
  local path="$1"
  local target="$2"

  # Ensure target path is absolute
  local abs_target="$(readlink -f "$target")"

  if [ -e "$path" ] || [ -L "$path" ]; then
    echo "Removing existing $path"
    rm -rf "$path"
  fi

  echo "Linking $path -> $abs_target"
  ln -s "$abs_target" "$path"
}

# fish config
new_symlink "$HOME/.config/fish" "./.config/fish"

# WSL config
new_symlink "$HOME/.config/.wslconfig" "./.config/.wslconfig"

# Git config
new_symlink "$HOME/.config/.gitconfig" "./.config/.gitconfig"

# Starship config
new_symlink "$HOME/.config/starship.toml" "./.config/starship.toml"

# wezterm config
new_symlink "$HOME/.config/wezterm" "./.config/wezterm"

# lazygit config
new_symlink "$HOME/.config/lazygit/config.yml" "./.config/lazygit/config.yml"

# nvim config
new_symlink "$HOME/.config/nvim" "./.config/nvim"
