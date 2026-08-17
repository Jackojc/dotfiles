#!/usr/bin/env sh

set -o nounset

[ "$#" -eq 0 ] || { printf 'usage: %s\n' "$(basename "$0")" >&2; exit 1; }

# cd to repo root according to argv[0].
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1

# find scripts by searching for files with shebang.
# - prints filenames of matches
# - excludes binaries
# - excludes git dir
find_scripts() {
	grep --recursive --binary-files=without-match --files-with-matches \
		--extended-regexp '^#!.*(bash|/bin/sh|env sh)' \
		--exclude-dir=.git . 2> /dev/null
}

# shellcheck disable=SC2046
set -- $(find_scripts)
shellcheck --format=gcc "$@"
