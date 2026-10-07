#!/usr/bin/env bash

#
# void packages
#

set -o errexit -o nounset

cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1  # cd to project root
. ./common/.local/lib/lib-utils

# TODO: allow passing a different manifest file?
MANIFEST='xbps-packages'

require xbps-install

# shellcheck disable=SC2046
set -- $(packages "$MANIFEST")

[ "$#" -gt 0 ] || die "no packages listed in '$MANIFEST'"

is_root || die "must be root"

log "installing $# packages"
xbps-install --sync --update "$@"
