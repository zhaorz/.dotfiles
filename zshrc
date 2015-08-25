# .zshrc
#
# Richard Zhao
#

# oh-my-zsh installation
export ZSH=/Users/Richard/.oh-my-zsh

# custom theme in .oh-my-zsh/themes
ZSH_THEME="rz"

plugins=(git)

export PATH="/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/Richard/bin/FDK/Tools/osx:/usr/local/cc0/bin:/Users/Richard/bin:/usr/local/mysql/bin"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='sublime -w'
fi

#
# Alias
#
alias g="git"
alias gac='git add -A && git commit '

alias work="cd ~/Documents/cmu112++/cmu-112-plus-plus-m15-staff/"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"

