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
mkdir -p $HOME/.config

# fish config
mkdir -p $HOME/.config/fish
new_symlink "$HOME/.config/fish" "./.config/fish"

# WSL config
new_symlink "$HOME/.config/.wslconfig" "./.config/.wslconfig"

# Git config
new_symlink "$HOME/.config/.gitconfig" "./.config/.gitconfig"

# Starship config
new_symlink "$HOME/.config/starship.toml" "./.config/starship.toml"

# wezterm config
mkdir -p $HOME/.config/wezterm
new_symlink "$HOME/.config/wezterm" "./.config/wezterm"

# lazygit config
mkdir -p $HOME/.config/lazygit
new_symlink "$HOME/.config/lazygit/config.yml" "./.config/lazygit/config.yml"

# nvim config
mkdir -p $HOME/.config/nvim
new_symlink "$HOME/.config/nvim" "./.config/nvim"
