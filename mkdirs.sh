#!/usr/bin/env bash

#
# create standard directories
#

set -o errexit -o nounset

cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)" || exit 1

. ./common/.local/lib/lib-utils
. ./common/.local/lib/lib-env

mkdir --parents --verbose -- \
	"${XDG_CACHE_HOME}" \
	"${XDG_CONFIG_HOME}" \
	"${XDG_DATA_HOME}" \
	"${XDG_BIN_HOME}" \
	"${XDG_STATE_HOME}"

mkdir --parents --verbose -- \
	"${XDG_PUBLICSHARE_DIR}" \
	"${XDG_TEMPLATES_DIR}" \
	"${XDG_DESKTOP_DIR}" \
	"${XDG_DOCUMENTS_DIR}" \
	"${XDG_DOWNLOAD_DIR}" \
	"${XDG_MUSIC_DIR}" \
	"${XDG_PICTURES_DIR}" \
	"${XDG_VIDEOS_DIR}"

mkdir --parents --verbose -- \
	"${DIR_MEDIA}" \
	"${DIR_MUSIC}" \
	"${DIR_WALLPAPERS}" \
	"${DIR_NOTES}" \
	"${DIR_STICKERS}"
