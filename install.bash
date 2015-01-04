#!/bin/bash

cd "$(dirname $0)"

for file in ~/.vimrc ~/.bashrc ~/.bash_aliases; do
    if [[ -f "$file" ]]; then
        while true; do
            read -p "$file already exists.  [a]bort, [d]elete, [m]ove? " choice
            case $choice in
                [aA])
                    exit 1;;
                [dD]*)
                    rm "$file"
                    echo "Deleted $file"
                    break;;
                [mM]*)
                    mv "$file" "$file.backup"
                    echo "Moved $file to $file.backup"
                    break;;
                *)
                    echo "Invalid choice '$choice'";;
            esac
        done
    fi
done

for dir in ~/.vim; do
    if [[ -d "$dir" ]]; then
        while true; do
            read -p "$dir already exists.  [a]bort, [d]elete, [m]ove? " choice
            case $choice in
                [aA])
                    exit 1;;
                [dD]*)
                    find "$dir" -delete
                    echo "Deleted $dir"
                    break;;
                [mM]*)
                    mv "$dir" "$dir.backup"
                    echo "Moved $dir to $dir.backup"
                    break;;
                *)
                    echo "Invalid choice '$choice'";;
            esac
        done
    fi
done

base=`pwd`
ln -s "$base/bashrc" ~/.bashrc
echo "✓ Copied .bashrc"
ln -s "$base/bash_aliases" ~/.bash_aliases
echo "✓ Copied .bash_aliases"
ln -s "$base/vimrc" ~/.vimrc
echo "✓ Copied .vimrc"
ln -s "$base/vim" ~/.vim
echo "✓ Copied .vim/"

source ~/.bashrc
read -p "Edit ~/.localrc now? [y/N] " choice
case $choice in
    [yY]*)
        $EDITOR ~/.localrc;;
    *)
        ;;
esac

echo "Basic setup complete"
