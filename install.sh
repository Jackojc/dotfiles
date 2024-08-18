#!/usr/bin/env bash

. ./lib.sh  # Utilities

# Constants
HOMEDIR=$(getent passwd jack | cut -d: -f6)
export HOME="${HOME:-$HOMEDIR}"

# Install nix package manager
# We can run this even with existing install to update.
log "install nix"
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

# Install minimal shell environment
. "$HOME/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

log "install shell packages"
nix-env -iA \
	nixpkgs.stow \
	nixpkgs.tmux \
	nixpkgs.ripgrep \
	nixpkgs.eza \
	nixpkgs.bat \
	nixpkgs.hexyl \
	nixpkgs.du-dust \
	nixpkgs.gping \
	nixpkgs.renameutils \
	nixpkgs.helix \
	nixpkgs.jq \
	nixpkgs.ncdu \
	nixpkgs.fd \
	nixpkgs.git \
	nixpkgs.delta \
	nixpkgs.difftastic \
	nixpkgs.mdsh

# Make necessery directories if they don't exist
log "mkdir xdg directories"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"
mkdir -p "${XDG_BIN_HOME:-$HOME/.local/bin}"
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"

# Run GNU Stow
log "symlink configs"
stow --no-folding --dotfiles .

# Link all scripts to XDG_BIN_HOME
log "symlink scripts"
find scripts/ -type f | xargs -I{} -- ln -s {} "$XDG_BIN_HOME"
