#!/usr/bin/env bash

set -o errexit -o nounset

cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1
. ./common/.local/lib/lib-utils

profile="${HOME}/.mozilla/firefox/default"

require firefox
require pgrep

if [ -d "$profile" ]; then
	log "default profile already exists"
	exit 0
fi

[ -f "${profile%/*}/profiles.ini" ] &&
	die "firefox profile needs migration"

pgrep --exact firefox >/dev/null && die 'firefox is running'

firefox --CreateProfile "default ${profile}" >/dev/null 2>&1 ||
	die 'firefox --CreateProfile failed'
