# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Initialization for FDK command line tools.Thu Mar 26 17:36:53 2015
FDK_EXE="/Users/Richard/bin/FDK/Tools/osx"
PATH=${PATH}:"/Users/Richard/bin/FDK/Tools/osx"
export PATH
export FDK_EXE

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# c0 - cc0
export PATH="$PATH:/usr/local/cc0/bin"

export PATH=$PATH:$HOME/bin

# -----------------------------------------------------------------------------

export PROMPT_DIRTRIM=3

export EDITOR='sublime -w'

# bash prompt
export PS1="\[\033[38;5;6m\]赵\[$(tput sgr0)\]\[\033[38;5;15m\] \w \[$(tput sgr0)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\]\[\033[38;5;2m\] \[$(tput sgr0)\]"

# Useful aliases
alias ls='ls -G '               # Colorized ls output
alias coin='rlwrap coin'        # c0 interpreter rlwrap
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias work="cd ~/Documents/agile/cmu-112-plus-plus-m15-staff/"
alias m15-master="sh ~/Documents/agile/cmu-112-plus-plus-m15-staff/scripts/git/m15-master.sh"
alias m15-gh-pages="sh ~/Documents/agile/cmu-112-plus-plus-m15-staff/scripts/git/m15-gh-pages.sh"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"

# Git
alias gitac='git add -A && git commit '

export PATH=/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/Richard/bin/FDK/Tools/osx:/usr/local/cc0/bin:/Users/Richard/bin:/usr/local/mysql/bin
