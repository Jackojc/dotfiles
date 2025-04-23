#!/usr/bin/env bash

. ./lib.sh

# Install minimal shell environment
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

stow --no-folding dots-common
stow --no-folding dots-shell
stow --no-folding dots-gui
