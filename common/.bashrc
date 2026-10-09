#!/usr/bin/env bash

. "${HOME}/.local/lib/lib-env"

case $- in *i*) ;; *) return ;; esac  # early return for non interactive shell

GPG_TTY=$(tty)
export GPG_TTY

# XDG directories
mkdir --parents "${XDG_DATA_HOME}/bash/" && touch "${XDG_DATA_HOME}/bash/history"
mkdir --parents "${XDG_STATE_HOME}/python" "${XDG_STATE_HOME}/node"

export HISTFILE="${XDG_DATA_HOME}/bash/history"
export LESSHISTFILE="-"

export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

. "tool-git-prompt"

PS1='\[\e[0;33m\]\u@\h\[\e[m\] \[\e[0;36m\]\w\[\e[0;31m\]$(__git_ps1 " %s")\[\e[m\] \$ '
PS2='\[\e[0;36m\]↪ \[\e[m\]'

PROMPT_DIRTRIM=3

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:l:ll:la:lt:goto:fe:bg:fg:history:clear:c"
HISTTIMEFORMAT='%F %T '

stty -ixon

shopt -s globstar      # Recursive globbing
shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell

set -o noclobber  # dont overwrite files on redirection

bind Space:magic-space

# Aliases
alias fe="tool-find-edit"

alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# Sane flags
alias mkdir="mkdir --parents --verbose"
alias cp="cp --interactive --verbose --archive --dereference"
alias mv="mv --interactive --verbose"
alias rm="rm --verbose -I"
alias qmv="qmv -fdo"
alias ip="ip -c"
alias tmux="tmux -u2"
alias fd="fd --unrestricted"
alias rsync="rsync -avzPu"

# Alternatives.
alias ls="eza --group-directories-first --dereference --classify=auto"
alias l="ls"
alias ll="ls --long --git"
alias la="ls --all"
alias lt="ls --tree --level=2"
alias cat="bat"
alias hexdump="hexyl"
alias df="duf"
alias ncdu="dua i"

alias dud="dua"          # disk usage
alias pg="gping"         # visual ping
alias dft="difft"        # structural diff

# # Shortened
alias c="clear"
alias e="hx"
alias chux="chmod u+x"

alias calc="tool-calc"
alias pash="tool-pash"

alias mss="meson setup build/"
alias msc="meson compile -C build/"
alias mst="meson test --print-errorlogs -C build/"

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

cm() { mkdir --parents "$1" && cd "$1" || return; }
goto() { cd "$(fd --hidden --type d | fzf --query "$*")" 2> /dev/null || return; }

alias ssh="mosh -p 60000:60010"

__osc7() { printf '\e]7;file://%s%s\a' "$HOSTNAME" "$PWD"; }
PROMPT_COMMAND='__osc7; history -a'

# shellcheck source=/dev/null
{
	. /usr/share/bash-completion/bash_completion
	[ -r "$CARGO_HOME/env" ] && . "$CARGO_HOME/env"
}
