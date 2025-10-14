#!/usr/bin/env bash

. ./lib.sh

# Install nix package manager
# We can run this even with existing install to update.
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

# Install minimal shell environment
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

nix-env -iA \
	nixpkgs.stow \
	nixpkgs.rsync \
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
	nixpkgs.dua \
	nixpkgs.dtrx \
	nixpkgs.duf \
	nixpkgs.fd \
	nixpkgs.git \
	nixpkgs.delta \
	nixpkgs.difftastic \
	nixpkgs.broot \
	nixpkgs.mergiraf

nix-channel --update    # Update repos
nix-env -u '*'          # Update packages
