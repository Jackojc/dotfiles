#!/usr/bin/env bash

[[ $- != *i* ]] && return

export LC_ALL="C"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export PATH="${XDG_BIN_HOME}:${PATH}"
export GPG_TTY=$(tty)

# Use XDG directories for configs
mkdir -p "${XDG_DATA_HOME}/bash/" && touch "${XDG_DATA_HOME}/bash/history"

export HISTFILE="${XDG_DATA_HOME}/bash/history"
export LESSHISTFILE="-"

export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# Program directories
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GOPATH="${XDG_DATA_HOME}/go"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Colours
RESET="$(tput sgr0)"

COLOUR_BLACK="$(tput setaf 0)" 
COLOUR_RED="$(tput setaf 1)" 
COLOUR_GREEN="$(tput setaf 2)" 
COLOUR_YELLOW="$(tput setaf 3)" 
COLOUR_BLUE="$(tput setaf 4)" 
COLOUR_MAGENTA="$(tput setaf 5)" 
COLOUR_CYAN="$(tput setaf 6)" 
COLOUR_WHITE="$(tput setaf 7)" 


# Prompt
function branch() {  # Print current git branch if inside a git repo
	git branch 2> /dev/null | rg -o '\* (.+)' --replace '$1 '
}

if [ "$EUID" -ne 0 ]; then  # User
	export PS1='\[${COLOUR_MAGENTA}\]\W\[${COLOUR_YELLOW}\] $(branch)\[${RESET}\]$ '
else  # Root
	export PS1='\[${COLOUR_RED}\]\W\[${COLOUR_YELLOW}\] $(branch)\[${RESET}\]# '
fi

export PS2='| \[${COLOUR_CYAN}\]=>\[${RESET}\] '


# Settings
PROMPT_DIRTRIM=3
CDPATH="."

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:l:la:ll:lal:lt:l.:jump:goto:z:s:bg:fg:history:clear:c"

PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

stty -ixon

shopt -s checkwinsize
shopt -s globstar
shopt -s nocaseglob
shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s cdable_vars
shopt -s expand_aliases

bind Space:magic-space

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

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
alias cp="cp -iva"
alias mv="mv -iv"
alias rm="rm -vI"
alias qmv="qmv -fdo"
alias ip="ip -c"


# Alternatives
alias ls="eza --group-directories-first"
alias cat="bat"
alias hexdump="hexyl"
alias du="dust"
alias du="duf"
alias ping="gping"


# # Shortened
alias c="clear"
alias e="hx"


# Git aliases
alias gc="git commit"
alias gca="git commit --amend"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gl="git log"
