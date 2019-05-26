#!/bin/bash

set -e

copy_file() {
    src="$1"
    dest="$2"

    echo "Copying $(basename $src) to $dest"

    if [[ -f "$dest" || -h "$dest" ]]; then
        while true; do
            read -p "$dest already exists.  Delete it? [y/N/(b)ackup] " choice
            case $choice in
                [bB]*)
                    echo "  > Copying $(basename $dest) to $(basename $dest).backup"
                    mv "$dest" "$dest.backup"
                    break;;
                [yY]*)
                    echo "  > Deleting $(basename $dest)"
                    rm "$dest"
                    break;;
                [nN]*)
                    echo "  > File copy aborted"
                    return 1;;
                *)
                    echo "Invalid choice '$choice'";;
            esac
        done
    fi

    cp "$src" "$dest"
    if [[ $? == 0 ]]; then
        echo "✓ $(basename $dest)"
    fi
}

copy_dir() {
    src="$1"
    dest="$2"

    echo "Copying $(basename $src) to $dest"

    if [[ -d "$dest" || -h "$dest" ]]; then
        while true; do
            read -p "$dest already exists.  Delete it? [y/N/(b)ackup] " choice
            case $choice in
                [bB]*)
                    echo "  > Copying $(basename $dest) to $(basename $dest).backup"
                    mv "$dest" "$dest.backup"
                    break;;
                [yY]*)
                    echo "  > Deleting $(basename $dest)"
                    find "$dest" -delete
                    break;;
                [nN]*)
                    echo "  > File copy aborted"
                    return 1;;
                *)
                    echo "Invalid choice '$choice'";;
            esac
        done
    fi

    cp -r "$src" "$dest"
    if [[ $? == 0 ]]; then
        echo "✓ $(basename $dest)"
    fi
}

base="$(dirname $(readlink -e $0))"

if [[ $# == 0 ]]; then
    echo "No target specified."
    echo "Available targets: bash fontconfig konsole mpv tmux vim X"
    exit 1
fi

for target in $@; do
    case $target in
        alacritty)
            mkdir -p ~/.config/alacritty
            copy_file "$base/config/alacritty/alacritty.yml" ~/.config/alacritty/alacritty.yml
        bash)
            copy_file "$base/bashrc" ~/.bashrc
            copy_file "$base/bash_aliases" ~/.bash_aliases;;
        fontconfig)
            mkdir -p ~/.config/fontconfig
            copy_dir "$base/fontconfig" ~/.config/fontconfig;;
        konsole)
            mkdir -p ~/.config/
            copy_file "$base/konsolerc" ~/.config/konsolerc;;
        mpv)
            mkdir -p ~/.config/mpv
            copy_file "$base/mpv/mpv.conf" ~/.config/mpv/mpv.conf;;
        tmux)
            copy_file "$base/tmux.conf" ~/.tmux.conf;;
        vim)
            copy_file "$base/vimrc" ~/.vimrc
            copy_dir "$base/vim" ~/.vim;;
        X)
            copy_file "$base/Xmodmap" ~/.Xmodmap
            copy_file "$base/Xresources" ~/.Xresources;;
        *)
            echo "Unknown target $target";;
    esac
done
