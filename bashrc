#!/usr/bin/env bash

# Add user bin
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"

eval "$(rbenv init -)"

# LaTeX bin
export PATH="$PATH:/usr/local/texlive/2014/bin/x86_64-darwin"

# rvm
# source "$HOME/.rvm/scripts/rvm"

# Set prompt
export PS1="\[$(tput setaf 6)\]\h \[$(tput setaf 3)\]\w \[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"

#
# Alias
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias ls="ls -G"

alias g="git"
alias gac='git add -A && git commit '

alias xkinit="kinit richardz@ANDREW.CMU.EDU"

alias sml="rlwrap sml"
alias ocaml="rlwrap ocaml"

alias work="cd ~/Documents/workspace/"
alias cmu="cd ~/Documents/academics"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"

alias please="sudo"

export NVM_DIR="/Users/rzhao/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
