#!/usr/bin/env bash

. ./lib.sh  # Utilities

# Constants
HOMEDIR=$(getent passwd jack | cut -d: -f6)
export HOME="${HOME:-$HOMEDIR}"

# Install nix package manager
has "nix-env" || ( log "installing nix" && \
logcmd curl -L https://nixos.org/nix/install | sh )

# Install minimal shell environment
logcmd nix-env -iA \
	nixpkgs.stow \
	nixpkgs.tmux \
	nixpkgs.ripgrep \
	nixpkgs.exa \
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
log "creating XDG directories"
logcmd mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
logcmd mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
logcmd mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"
logcmd mkdir -p "${XDG_BIN_HOME:-$HOME/.local/bin}"
logcmd mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"

# Run GNU Stow
log "create symlinks to config files"
stow --no-folding --dotfiles .

# Link all scripts to XDG_BIN_HOME
log "create symlinks to scripts"
find scripts/ -type f | xargs -I{} -- ln -s {} "$XDG_BIN_HOME"
