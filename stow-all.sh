#!/usr/bin/env bash

. ./lib.sh

# Install minimal shell environment
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

stow --no-folding common
stow --no-folding shell
stow --no-folding gui
