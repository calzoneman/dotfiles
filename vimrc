set nocompatible

execute pathogen#infect()

set encoding=utf-8
" always show statusline
set laststatus=2
" always allow backspace
set backspace=2

set nu
set ts=4 sts=4 sw=4 autoindent expandtab smartindent
set list listchars=tab:>-
set nomodeline

" change tab completion mode to be more like bash
set wildmenu wildmode=longest,list

set colorcolumn=80

if !has("gui_running")
  let g:gruvbox_italic=0
  set termguicolors
else
  set guioptions=-t
  set guifont=-xos4-terminus-medium-r-normal--0-0-72-72-c-0-iso10646-1
endif

set background=light
colorscheme intellij

" don't exit visual mode when shifting left/right
vnoremap < <gv
vnoremap > >gv

" Allow scrolling up/down in softwrapped lines
noremap j gj
noremap k gk

syntax on
filetype plugin indent on

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=red
highlight ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" indentation customizations
autocmd FileType elixir setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType pug setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" filetype customizations
autocmd BufReadPost *.md set filetype=markdown
autocmd BufReadPost *.rkt,*.rktl set filetype=scheme

" text width customizations
autocmd FileType elixir setlocal colorcolumn=100
autocmd FileType markdown setlocal textwidth=80

" call a function and restore the cursor state afterwards
function! Preserve(command)
  let _s=@/
  let l = line(".")
  let c = col(".")
  execute a:command
  let @/=_s
  call cursor(l, c)
endfunction

function! ChangeTheme(bg, theme)
  exec 'set background=' . a:bg
  exec 'colorscheme ' . a:theme
  syntax sync fromstart
endfunction

" shortcuts
nmap <Leader>cg :call ChangeTheme("dark", "gruvbox")<CR>
nmap <Leader>ci :call ChangeTheme("light", "intellij")<CR>
nmap <Leader>cj :call ChangeTheme("dark", "jellybeans")<CR>
" \l => clear extra whitespace
nmap <Leader>l :call Preserve("%s/\\s\\+$//e")<CR>
" \n => unhighlight
nmap <Leader>n :noh<CR>
" \p => toggle paste mode (and toggle line numbers for easier copying from terminals)
nmap <Leader>p :set nu!<CR>:set paste!<CR>

" language-specific shortcuts
" \m => !mix format
autocmd FileType elixir nmap <Leader>m :w<CR>:!mix format %<CR>:e<CR>
" \b => :GoBuild
autocmd FileType go nmap <Leader>b :GoBuild<CR>
" \t => :GoTest
autocmd FileType go nmap <Leader>t :GoTest<CR>
