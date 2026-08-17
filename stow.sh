#!/usr/bin/env sh

set -o errexit -o nounset

#
# stow the directories in this repo into $HOME.
# it restows and prunes dead links.
#

# cd to repo root.
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1

. ./common/.local/bin/lib-utils

PACKAGES='common shell gui'  # directories to stow
HOSTNAME="host-$(uname -n)"

usage() {
	printf '%s' "usage: $(basename "$0") [-n|-D] [package...]
  -n  dry run
  -D  unstow
  -h  help
"
}

action=--restow
dry=''

while getopts ':nDh' opt; do
	case "$opt" in
		n) dry='--simulate --verbose' ;;
		D) action=--delete ;;
		h) usage; exit 0 ;;
		*) usage >&2; exit 1 ;;
	esac
done
shift $(( OPTIND - 1 ))

require stow

# shellcheck disable=SC2086
[ "$#" -gt 0 ] || set -- $PACKAGES

if [ -d "$HOSTNAME" ]; then
	set -- "$@" "$HOSTNAME"

else
	log "unknown host '${HOSTNAME}'!"
fi

# shellcheck disable=SC2086
LC_ALL=C stow "$action" $dry --no-folding --target "$HOME" "$@"
