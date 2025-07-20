#!/usr/bin/env bash

. ./lib.sh

# Install minimal shell environment
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"  # Source env vars for nix

LC_ALL=C stow --no-folding common
LC_ALL=C stow --no-folding gui
