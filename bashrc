#!/bin/bash

# early exit if non-interactive shell (e.g. scp)
if [[ $- != *i* ]]; then
    return
fi

defaults=(\
    /etc/bashrc \
    ~/.bash_aliases \
    ~/.localrc \
)

for file in ${defaults[@]}; do
    [[ -f $file ]] && source $file
done

###
# Bash settings
###

# Refresh terminal size on window resize
shopt -s checkwinsize
# Append to history file instead of overwriting
shopt -s histappend
# Ignore duplicate commands in history
export HISTCONTROL="ignoreboth"
export EDITOR="vim"

###
# Prompt customization
###

if test -f /usr/share/git/git-prompt.sh; then
    source /usr/share/git/git-prompt.sh

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="verbose"
    git_prompt='$(__git_ps1 " (%s)")'
else
    git_prompt=''
fi

color_red='\[\e[01;31m\]'
color_black='\[\e[01;30m\]'
color_reset='\[\e[00m\]'

if [[ -z "$prompt_color_root" ]]; then
    prompt_color_root="$color_red"
fi

if [[ -z "$prompt_color_nonroot" ]]; then
    # TODO: look into choosing a color by hostname
    prompt_color_nonroot="$color_black"
fi

if [[ $EUID == 0 ]]; then
    prompt_char='#'
    prompt_color="$prompt_color_root"
else
    prompt_char='$'
    prompt_color="$prompt_color_nonroot"
fi

prompt_date='$(date +"%H:%M:%S")'
prompt_window_title='\[\e]0;\u@\h:\w\a\]'
export PS1="$prompt_window_title[$prompt_date] $prompt_color\u@\h$color_reset \w$git_prompt\n$prompt_color$prompt_char$color_reset "

###
# PATH customizations
###
export PATH=$PATH:~/bin
[[ -z "$GOPATH" ]] && export GOPATH=$HOME/go
