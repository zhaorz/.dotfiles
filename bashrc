#!/usr/bin/env bash

# Add user bin
export PATH="$HOME/bin:$PATH"

# Set prompt
export PS1="\[$(tput setaf 6)\]\h \[$(tput setaf 3)\]\w \[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"

# Alias
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias ls="ls -G"

alias g="git"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias glg="git log --graph --decorate"
alias gbv="git branch -v"
alias ggp="git push origin"
alias gco="git checkout"
alias gc!="git commit --amend -v"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export TERM=xterm-256color
