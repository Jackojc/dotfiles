#!/usr/bin/env sh

# stow the directories in this repo into $HOME.
# it restows and prunes dead links.
# remove: stow --delete --target "$HOME" common shell gui

set -o errexit -o nounset

# cd to repo root.
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1

. ./common/.local/lib/lib-utils

require stow

[ "$#" -gt 0 ] || set -- common shell gui

host="$(uname -n)"

if [ -d "$host" ]; then
	set -- "$@" "$host"

else
	log "unknown host '${host}'!"
fi

LC_ALL=C stow --restow --no-folding --target "$HOME" "$@"
