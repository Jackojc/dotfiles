#!/usr/bin/env bash

[[ $- != *i* ]] && return

# CAREFUL! These can fuck up tmux
# export TERM="screen-256color"
# export LC_ALL="C.UTF-8"
# 
# eval "$(ssh-agent -s)"

# Environment vars
. "${HOME}/.bashrc-env"

export GPG_TTY=$(tty)

# Use XDG directories for configs
mkdir -p "${XDG_DATA_HOME}/bash/" && touch "${XDG_DATA_HOME}/bash/history"

export HISTFILE="${XDG_DATA_HOME}/bash/history"
export LESSHISTFILE="-"

export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

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
export PROMPT_DIRTRIM=3
export CDPATH="."

export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:l:la:ll:lal:lt:l.:jump:goto:z:s:bg:fg:history:clear:c"
export HISTTIMEFORMAT='%F %T '

# Setting OSC0 and OSC7 for terminal title and PWD
# Taken from vte.sh
__urlencode() (
  # This is important to make sure string manipulation is handled
  # byte-by-byte.
  LC_ALL=C
  str="$1"
  while [ -n "$str" ]; do
    safe="${str%%[!a-zA-Z0-9/:_\.\-\!\'\(\)~]*}"
    printf "%s" "$safe"
    str="${str#"$safe"}"
    if [ -n "$str" ]; then
      printf "%%%02X" "'$str"
      str="${str#?}"
    fi
  done
)

__osc7 () {
  printf "\033]7;file://%s%s\a" "${HOSTNAME:-}" "$(__urlencode "${PWD}")"
}

__osc_prompt_command() {
  local pwd='~'
  [ "$PWD" != "$HOME" ] && pwd=${PWD/#$HOME\//\~\/}
  printf "\033]0;%s@%s:%s\007%s" "${USER}" "${HOSTNAME%%.*}" "${pwd}" "$(__osc7)"
}

export PROMPT_COMMAND='__osc_prompt_command ; history -a; '

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
alias tmux="tmux -u2"
alias fd="fd --unrestricted"

# Alternatives
alias ls="eza --group-directories-first --dereference --classify"
alias cat="bat"
alias hexdump="hexyl"
alias du="dua"
alias df="duf"
alias ping="gping"
alias ncdu="dua"

# # Shortened
alias c="clear"
alias e="hx"
alias chux="chmod u+x"

alias mss="meson setup build/"
alias msc="meson compile -C build/"
alias mst="meson test -C build/"

# Git aliases
alias gc="git commit"
alias gca="git commit --amend"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gl="git log"
alias gp="git pull"
alias gr="git rebase"

alias gls="eza --long --git --git-ignore"
alias gtree="eza --tree --git --git-ignore --long --no-user -a"

. "${HOME}/.bashrc-local"  # System-local configs
