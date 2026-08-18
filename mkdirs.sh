#!/usr/bin/env bash

#
# create standard directories
#

set -o errexit -o nounset
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1
. ./common/.local/bin/lib-utils

usage() {
	printf 'usage: %s\n' "$(basename "$0")"
}

no_args "$@"

make_directory() {
	for dir in "$@"; do
		case "$dir" in '' | "$HOME" | /dev/null) continue ;; esac
		[ -d "$dir" ] || { mkdir --parents "$dir" && printf 'created %s\n' "$dir"; }
	done
}

make_directory \
	"${XDG_CACHE_HOME}" \
	"${XDG_CONFIG_HOME}" \
	"${XDG_DATA_HOME}" \
	"${XDG_BIN_HOME}" \
	"${XDG_STATE_HOME}"

make_directory \
	"${XDG_PUBLICSHARE_DIR}" \
	"${XDG_TEMPLATES_DIR}" \
	"${XDG_DESKTOP_DIR}" \
	"${XDG_DOCUMENTS_DIR}" \
	"${XDG_DOWNLOAD_DIR}" \
	"${XDG_MUSIC_DIR}" \
	"${XDG_PICTURES_DIR}" \
	"${XDG_VIDEOS_DIR}"

make_directory \
	"${DIR_MEDIA}" \
	"${DIR_MUSIC}" \
	"${DIR_WALLPAPERS}" \
	"${DIR_NOTES}" \
	"${DIR_STICKERS}"
