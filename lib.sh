#!/usr/bin/env sh

# Constants
HOMEDIR=$(getent passwd jack | cut -d: -f6)
export HOME="${HOME:-$HOMEDIR}"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Utilities
die() {
    printf 'error: %s.\n' "$1" >&2
    exit 1
}

log() {
    printf 'log: %s.\n' "$1" >&2
}

logcmd() {
    printf "$(date '+%Y-%m-%d %H:%M:%S') %s\n" "$*"
    "$@"
}

# This is just a simple wrapper around 'command -v' to avoid
# spamming '>/dev/null' throughout this function. This also guards
# against aliases and functions.
has() {
    _cmd=$(command -v "$1") 2>/dev/null || return 1
    [ -x "$_cmd" ] || return 1
}

glob() {
    # This is a simple wrapper around a case statement to allow
    # for simple string comparisons against globs.
    #
    # Example: if glob "Hello World" '* World'; then
    #
    # Disable this warning as it is the intended behavior.
    # shellcheck disable=2254
    case $1 in $2) return 0; esac; return 1
}

yn() {
    printf '%s [y/n]: ' "$1"

    # Enable raw input to allow for a single byte to be read from
    # stdin without needing to wait for the user to press Return.
    stty -icanon

    # Read a single byte from stdin using 'dd'. POSIX 'read' has
    # no support for single/'N' byte based input from the user.
    answer=$(dd ibs=1 count=1 2>/dev/null)

    # Disable raw input, leaving the terminal how we *should*
    # have found it.
    stty icanon

    printf '\n'

    # Handle the answer here directly, enabling this function's
    # return status to be used in place of checking for '[yY]'
    # throughout this program.
    glob "$answer" '[yY]'
}

exists() {
    [ -f "$1" ] || die 'file does not exist'
}

packages() {
    exists "$1"
    <"$1" sed 's/#.*//' | tr '\n' ' ' | sed 's/ \+/ /gp'
}
