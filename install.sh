#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link_file() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        echo "[SKIP] Source does not exist: $src"
        return
    fi

    # Ensure parent destination directory exists
    mkdir -p "$(dirname "$dest")"

    # Check if target already points to the correct destination
    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
        echo "[OK] Already linked: $dest"
        return
    fi

    # Backup existing non-matching target
    if [[ -e "$dest" || -L "$dest" ]]; then
        echo "[BACKUP] Moving existing $dest to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "[LINK] $dest -> $src"
    ln -sfn "$src" "$dest"
}

echo "Linking dotfiles from $DOTFILES_DIR..."

link_file "bash/.bashrc" "$HOME/.bashrc"
link_file "bash/.bash_aliases" "$HOME/.bash_aliases"
link_file "git/.gitconfig" "$HOME/.gitconfig"
link_file "nvim" "$HOME/.config/nvim"
link_file "wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

echo "Symlinking complete."
