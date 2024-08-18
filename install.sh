#!/usr/bin/env bash

. ./lib.sh  # Utilities

# Constants
HOMEDIR=$(getent passwd jack | cut -d: -f6)
export HOME="${HOME:-$HOMEDIR}"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"


# Install nix package manager
# We can run this even with existing install to update.
log "install nix"
sleep 2
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

# Install minimal shell environment
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

log "install shell packages"
sleep 2
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
sleep 2
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_BIN_HOME}"
mkdir -p "${XDG_STATE_HOME}"

# Run GNU Stow
log "symlink configs"
sleep 2
stow --no-folding --dotfiles .

# Link all scripts to XDG_BIN_HOME
log "symlink scripts"
sleep 2
find scripts/ -type f | xargs -I{} -- ln -sf "${PWD}/"{} "${XDG_BIN_HOME}/"

# Link .bashrc and .profile so login shell uses config
log "symlink .profile"
sleep 2
ln -sf "${HOME}/.bashrc" "${HOME}/.profile"

log "you should log out and back in to use updated bashrc"
