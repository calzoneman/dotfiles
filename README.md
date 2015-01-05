# dotfiles

This is my collection of personal configuration files, for easy redistribution
on my desktops and servers.

Currently included:

  - bash preferences and PS1
  - vim preferences
      - vimrc
      - pathogen
      - Tabular.vim
      - Several color schemes I like
      - Support for jade and coffeescript

## Installation

Usage: `./install.sh <target> [<target> ...]`

Available targets: `bash vim`

If a destination file or directory exists, you will be prompted whether to
delete it, abort, or move it to `$dest.backup` and overwrite the original.

Configuration is installed as symlinks to the files/directories in the
`dotfiles` folder, so you can easily update them by running `git pull`.
