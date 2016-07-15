# .zshrc
#
# Richard Zhao
#

# oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# custom theme in .oh-my-zsh-custom/themes
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
ZSH_THEME="rz"

plugins=(git rake-fast)
fpath=(~/.oh-my-zsh-custom/completions $fpath)
autoload -Uz compinit && compinit -i

# Paths
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/texlive/2014/bin/x86_64-darwin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/go/bin"

export GOPATH="$HOME/workspace/go"
export PATH="$PATH:$GOPATH/bin"

export NVM_DIR="/Users/rzhao/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(rbenv init -)"


source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

#
# Alias
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias g="git"
alias gs="git status"
alias gac='git add -A && git commit '

alias sml="rlwrap sml"
alias ocaml="rlwrap ocaml"

alias work="cd ~/Documents/workspace"
alias cmu="cd ~/Documents/academics"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"

alias please="sudo"



