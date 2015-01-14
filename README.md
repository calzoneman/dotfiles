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
      - Support for F#
  - base `.xinitrc`
  - i3 settings
  - tmux settings

## Installation

Usage: `./install.sh <target> [<target> ...]`

Available targets: `bash vim tmux i3`

Run `git submodule init` after cloning to fetch vim plugins.
