set nocompatible

execute pathogen#infect()

set encoding=utf-8
" always show statusline
set laststatus=2

set nu
set ts=4 sts=4 sw=4 autoindent expandtab smartindent
set list listchars=tab:»\ 

" change tab completion mode to be more like bash
set wildmenu wildmode=longest,list

set colorcolumn=80

if !has("gui_running")
  let g:gruvbox_italic=0
else
  set guioptions=-t
  set guifont=Liberation\ Mono\ 9
endif

colorscheme gruvbox
set background=dark

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

" settings specific to certain filetypes
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufReadPost *.rkt,*.rktl set filetype=scheme
autocmd FileType jade setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
" Recognize *.md as Markdown
autocmd BufReadPost *.md set filetype=markdown
" Auto hardwrap Markdown at 80 chars
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

" shortcut Mappings
" \l => clear extra whitespace
nmap <Leader>l :call Preserve("%s/\\s\\+$//e")<CR>
" \n => unhighlight
nmap <Leader>n :noh<CR>
" \p => toggle paste mode (and toggle line numbers for easier copying from terminals)
nmap <Leader>p :set nu!<CR>:set paste!<CR>
