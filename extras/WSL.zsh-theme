# ZSH Theme - WSL
# Author: Patrick Wu <wotingwu@live.com>
# Theme based on my theme linuxer-min and mh Theme

# Current Dir Shortener
local current_dir=' %{$fg[magenta]%}%14<...<%~%<<%{$reset_color%} '

# Git info
local git_info='$(git_prompt_info)%'
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=":%{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=":%{$fg[green]%}o"

# NVM info
local nvm_info='$(nvm_prompt_info)'
ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_NVM_PROMPT_SUFFIX="]%{$reset_color%}"

# RVM info
local rvm_info='$(rvm_prompt_info)'
ZSH_THEME_RVM_PROMPT_PREFIX="%[$fg[red]%}["
ZSH_THEME_RVM_PROMPT_SUFFIX="]%{$reset_color%}"


local exit_code="%(?,,[%{$fg[red]%}%B%?%b%{$reset_color%}])"
local build="%{$fg[cyan]%}[`reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" 2>&1 | egrep -o '([0-9]{5})'`]%{$reset_color%}"
#PROMPT="${build}${nvm_info}${rvm_info}${current_dir}%# "
PROMPT="${build}${nvm_info}${rvm_info}${git_info}${current_dir}%# "
RPROMPT="${exit_code}"
