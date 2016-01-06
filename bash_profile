# For zsh
# export SHELL=/bin/zsh
# exec /bin/zsh -l

# 15-150 path
PATH="${PATH}:/afs/andrew/course/15/150/bin"; export PATH
alias sml="rlwrap sml"

# 15-110
alias setpy3="source '/opt/rh/python33/enable'"
alias 110="cd /afs/cs.cmu.edu/academic/class/15110-s16"

# Set prompt
export PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;3m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;4m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

