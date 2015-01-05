#!/bin/bash

function copy_file {
    src="$1"
    dest="$2"

    echo "Copying $(basename $src) to $dest"

    if [[ -f "$dest" ]]; then
        while true; do
            read -p "$dest already exists.  Delete it? [y/N/(b)ackup] " choice
            case $choice in
                [bB]*)
                    echo "  > Copying $(basename $dest) to $(basename $dest).backup"
                    mv "$dest" "$dest.backup";;
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

    ln -s "$src" "$dest"
    if [[ $? == 0 ]]; then
        echo "✓ $(basename $dest)"
    else
        echo "ln returned non-zero exit code"
    fi
}

function copy_dir {
    src="$1"
    dest="$2"

    echo "Copying $(basename $src) to $dest"

    if [[ -d "$dest" ]]; then
        while true; do
            read -p "$dest already exists.  Delete it? [y/N/(b)ackup] " choice
            case $choice in
                [bB]*)
                    echo "  > Copying $(basename $dest) to $(basename $dest).backup"
                    mv "$dest" "$dest.backup";;
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

    ln -s "$src" "$dest"
    if [[ $? == 0 ]]; then
        echo "✓ $(basename $dest)"
    else
        echo "ln returned non-zero exit code"
    fi
}

base="$(dirname $0)"

if [[ $# == 0 ]]; then
    echo "No target specified.  Try \`$0 bash vim\`"
    exit 1
fi

for target in $@; do
    case $target in
        bash)
            copy_file "$base/bashrc" ~/.bashrc
            copy_file "$base/bash_aliases" ~/.bash_aliases;;
        vim)
            copy_file "$base/vimrc" ~/.vimrc
            copy_dir "$base/vim" ~/.vim;;
        *)
            echo "Unknown target $target";;
    esac
done
