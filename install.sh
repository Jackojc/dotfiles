#!/usr/bin/env sh

. ./lib.sh  # Utilities

# Install nix package manager
curl -L https://nixos.org/nix/install | sh

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

# copy bashrc first and then source so we have all settings we need


# update xdg-user-dirs config
# move existing xdg dirs to preferred names

# Make necessery directories if they don't exist
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_BIN_HOME"

# Link all scripts to XDG_BIN_HOME
find scripts/ -type f | xargs -I{} -- ln -s {} "$XDG_BIN_HOME"
