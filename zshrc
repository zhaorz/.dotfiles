# .zshrc
#
# Richard Zhao
#

# oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# custom theme in .oh-my-zsh-custom/themes
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
ZSH_THEME="rz"

plugins=(git zsh-syntax-highlighting)
fpath=(~/.oh-my-zsh-custom/completions $fpath)
autoload -Uz compinit && compinit -i

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/texlive/2014/bin/x86_64-darwin"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

source $ZSH/oh-my-zsh.sh

export PYTHONSTARTUP=~/.pystartup

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

if [ -n "$VIRTUAL_ENV" ]; then
  . "$VIRTUAL_ENV/bin/activate"
fi

# eval "$(rbenv init -)"

#
# Alias
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias g="git"
alias gs="git status"
alias gbv="git branch -vv"

alias mk="make -j4"
alias mc="make clean"

alias sml="rlwrap sml"
alias ocaml="rlwrap ocaml"

alias work="cd ~/Documents/workspace"
alias cmu="cd ~/Documents/academics"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"
alias csa="cd ~/src/academy"

alias please="sudo"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
