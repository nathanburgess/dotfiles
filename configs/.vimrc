set nocompatible
set mouse=a
set laststatus=2
set number
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab

let &t_SI = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
silent !echo -ne "\033]12;red\007"
autocmd VimLeave * silent !echo -ne "\033]112\007"

call plug#begin('~/.vim/plugged')
Plug 'crusoexia/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
call plug#end()
