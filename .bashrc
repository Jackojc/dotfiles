#!/usr/bin/env bash

[[ $- != *i* ]] && return

export TERM="screen-256color"
export LC_ALL="C"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export PATH="${XDG_BIN_HOME}:${PATH}"
export GPG_TTY=$(tty)

# eval "$(ssh-agent -s)"

# Use XDG directories for configs
mkdir -p "${XDG_DATA_HOME}/bash/" && touch "${XDG_DATA_HOME}/bash/history"

export HISTFILE="${XDG_DATA_HOME}/bash/history"
export LESSHISTFILE="-"

export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

export MANROFFOPT='-c'
export PAGER='less'
export MANPAGER="tool-batpager"

# Program directories
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GOPATH="${XDG_DATA_HOME}/go"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Colours
if tput setaf 1 &> /dev/null; then
	tput sgr0

	MAGENTA=$(tput setaf 5)
	ORANGE=$(tput setaf 4)
	GREEN=$(tput setaf 2)
	PURPLE=$(tput setaf 1)

	BOLD=$(tput bold)
	RESET=$(tput sgr0)

else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"

	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE

export BOLD
export RESET

# Prompt
. "tool-git-prompt"  # System-local configs

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_STATESEPARATOR=''

export PS1="\[$BOLD\]\[$MAGENTA\]\u@\h\[$RESET\] \[$GREEN\]\w\[$PURPLE\]\$(__git_ps1 ' %s')\[$RESET\] $\[$RESET\] "
export PS2="\[$ORANGE\]→ \[$RESET\]"

# Settings
PROMPT_DIRTRIM=3
CDPATH="."

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:l:la:ll:lal:lt:l.:jump:goto:z:s:bg:fg:history:clear:c"
HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND='history -a; '

stty -ixon

shopt -s checkwinsize   # Update window size
shopt -s globstar   # Recursive globbing
shopt -s nocaseglob
shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s expand_aliases

set -o noclobber  # Don't overwrite files on redirection

bind Space:magic-space

bind "set completion-map-case on"    # Treat hyphens and underscore as equivalent
bind "set completion-ignore-case on"    # Case insensitive path completion
bind "set show-all-if-ambiguous on"   # Display matches on first tab press
bind "set mark-symlinked-directories on"  # Add trailing slash when completing symlinks to directories
bind "set visible-stats on"   # Add symbol to denote file type in completion
bind "set colored-stats on"  # Colour completions based on file type
bind "set page-completions off"   # Disable builtin pager

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Source env vars for nix.
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"

# Helpers
function has() {  # Check if program exists
    _cmd=$(command -v "$1") 2> /dev/null || return 1
    [ -x "$_cmd" ] || return 1
}

function cm() {  # Make directory and cd into it.
	mkdir "$1" 2> /dev/null && \
		cd "$1" 2> /dev/null
}

function goto() {
	cd "$(tool-goto-dir)"
}

function fe() {
	tool-find-edit
}

# Aliases
alias ~='cd $HOME'
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# Sane flags
alias mkdir="mkdir -pv"
alias cp="cp -ivaL"
alias mv="mv -iv"
alias rm="rm -vI"
alias qmv="qmv -fdo"
alias ip="ip -c"

# Alternatives
alias ls="eza --group-directories-first --dereference --classify"
alias cat="bat"
alias hexdump="hexyl"
alias du="dust"
alias du="duf"
alias ping="gping"

# # Shortened
alias c="clear"
alias e="hx"
alias chux="chmod u+x"

# Git aliases
alias gc="git commit"
alias gca="git commit --amend"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gl="git log"

. "${HOME}/.bashrc-local"  # System-local configs
