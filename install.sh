#!/usr/bin/env bash

. ./lib.sh  # Utilities

# Constants
HOMEDIR=$(getent passwd jack | cut -d: -f6)
export HOME="${HOME:-$HOMEDIR}"

# Install nix package manager
logcmd sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Install minimal shell environment
nix-env -iA \
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
logcmd mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
logcmd mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
logcmd mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"
logcmd mkdir -p "${XDG_BIN_HOME:-$HOME/.local/bin}"
logcmd mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"

# Run GNU Stow
logcmd stow --no-folding --dotfiles .

# Link all scripts to XDG_BIN_HOME
logcmd find scripts/ -type f | xargs -I{} -- ln -s {} "$XDG_BIN_HOME"
