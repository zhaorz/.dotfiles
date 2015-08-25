# rz.zsh-theme
#
# Minimal shell prompts.
#
# Main                                      Right
# [hostname] [path] [prompt_string] ...     [dirty] [branch]  ([12hr time])
#
# Branch icon requires powerline-patched fonts.


#
# Git setup
#

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%} %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}* %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# oh-my-zsh $(git_prompt_info) puts 'dirty' behind branch
git_custom_prompt() {
  # branch name (.oh-my-zsh/plugins/git/git.plugin.zsh)
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    # parse_git_dirty echoes PROMPT_DIRTY or PROMPT_CLEAN (.oh-my-zsh/lib/git.zsh)
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}


#
# Main prompt
#

local host_name="%{$fg[cyan]%}赵"
local path_string="%{$fg[yellow]%}%~"
local prompt_string="»"

# Make prompt_string red if the previous command failed.
local return_status="%(?:%{$fg[blue]%}$prompt_string:%{$fg[red]%}$prompt_string)"

PROMPT='${host_name} ${path_string} ${return_status} %{$reset_color%}'


#
# Right Prompt
#

local time="%{$fg[magenta]%}(%*)%{$reset_color%}"

RPROMPT='$(git_custom_prompt) ${time}'

