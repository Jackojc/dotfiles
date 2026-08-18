#!/usr/bin/env bash

set -o errexit -o nounset

#
# install void package manifest
#

cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1  # cd to project root

. ./common/.local/bin/lib-utils

# TODO: allow passing a different manifest file?
MANIFEST='xbps-packages'

usage() {
	printf 'usage: %s\n' "$(basename "$0")"
}

case "${1:-}" in
	-h | --help) usage; exit 0 ;;
	'') ;;
	*) usage >&2; exit 1 ;;
esac

[ "$#" -le 1 ] || { usage >&2; exit 1; }

require xbps-install
exists "$MANIFEST"

# shellcheck disable=SC2046
set -- $(packages "$MANIFEST")

[ "$#" -gt 0 ] || die "no packages listed in '$MANIFEST'"

assert_root

log "installing $# packages"
xbps-install --sync --update "$@"
