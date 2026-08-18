#!/usr/bin/env bash

#
# install void package manifest
#

set -o errexit -o nounset
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1  # cd to project root
. ./common/.local/bin/lib-utils

# TODO: allow passing a different manifest file?
MANIFEST='xbps-packages'

usage() {
	printf 'usage: %s\n' "$(basename "$0")"
}

no_args "$@"
require xbps-install

# shellcheck disable=SC2046
set -- $(packages "$MANIFEST")

[ "$#" -gt 0 ] || die "no packages listed in '$MANIFEST'"

assert_root

log "installing $# packages"
xbps-install --sync --update "$@"
