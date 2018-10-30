alias :e="vim"
alias ls="ls --color"
alias ll="ls -l"
alias lah="ls -lah"
alias please="sudo `fc -n -l -1`"

tvim() {
    konsole -e vim $@ >/dev/null 2>&1 &
}

open() {
    xdg-open "$1" >/dev/null 2>&1
}

mkcd() {
    mkdir "$1" && cd "$1"
}
