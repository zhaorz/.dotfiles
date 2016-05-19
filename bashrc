# .bashrc

# Add user bin
export PATH="$HOME/bin:$PATH"

# Set prompt
export PS1="$(tput setaf 6)\h $(tput setaf 3)\w $(tput setaf 4)\\$ $(tput sgr0)"

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

alias work="cd ~/Documents/cmu112++/cmu-112-plus-plus-m15-staff/"
alias cmu="cd ~/Documents/academics"
alias web="cd ~/Documents/web/zhaorz.github.io/"
alias cpp="cd ~/Documents/c++/"

alias please="sudo"
