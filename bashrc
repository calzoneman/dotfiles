#!/bin/bash

[[ -f /etc/bashrc ]] &&            source /etc/bashrc
[[ -f ~/.git-completion.bash ]] && source ~/.git-completion.bash
[[ -f ~/.bash_aliases ]] &&        source ~/.bash_aliases
[[ -f ~/.localrc ]] &&             source ~/.localrc

function ssh_shortcut {
    dest=${ssh_shortcuts[$2]}
    if [[ ! -z "$dest" ]]; then
        $1 "$dest"
    else
        $@
    fi
}

function ssh {
    ssh_shortcut /usr/bin/ssh $@
}

function sftp {
    ssh_shortcut /usr/bin/ssh $@
}

function tvim {
    roxterm -e vim $@ >/dev/null 2>&1 &
}

function open {
    xdg-open "$1" >/dev/null 2>&1
}

shopt -s checkwinsize
shopt -s histappend

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="verbose"

if hash __git_ps1 2>/dev/null; then
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
    prompt_color_nonroot="$color_black"
fi

if [[ $EUID == 0 ]]; then
    prompt_char='#'
    prompt_color="$prompt_color_root"
else
    prompt_char='»'
    prompt_color="$prompt_color_nonroot"
fi

prompt_window_title='\[\e]0;\u@\h:\w\a\]'
export PS1="$prompt_window_title[\j] $prompt_color\u@\h$color_reset \w$git_prompt\n$color_black$prompt_char$color_reset "

export EDITOR="vim"
export HISTCONTROl="ignoreboth"
export PATH=$PATH:~/bin
