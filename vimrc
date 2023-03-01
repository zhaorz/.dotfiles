" vimrc
" ------------------------------------------------------------------------------
" Richard Zhao
" <richard@rzhao.io>


" ------------------------------------------------------------------------------
" Plugins

call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug '~/.fzf'

call plug#end()

" ------------------------------------------------------------------------------
" General

set nocompatible
filetype plugin indent on
syntax on
syntax enable

" System clipboard
if $TMUX == ''
  set clipboard=unnamed
endif

set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F10>
set ttyfast

let g:indentLine_char = '│'

" ------------------------------------------------------------------------------
" Mappings

let mapleader=" "

nnoremap <Leader>r :source ~/.vimrc<CR>:echo "Reloaded vimrc."<CR>

imap jk <Esc>
nnoremap ; :
nnoremap Y y$

" Strip trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Easier split switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vmap <Leader>a= :Tabularize /=
vmap <Leader>a: :Tabularize /:

" fzf
nnoremap <Leader>e :Files<CR>
nnoremap <Leader>f :Buffers<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>; :Commands<CR>

" ------------------------------------------------------------------------------
" Visual

colorscheme gruvbox

set cursorline
set fillchars=vert:│

" Enable transparent background (let's terminal colors take precedence)
hi Normal guibg=NONE ctermbg=NONE

augroup BlendVertSplit
  autocmd!
  autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE guibg=NONE
augroup END

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" ------------------------------------------------------------------------------
" Editing

" TODO: Use editorconfig
set expandtab

set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftwidth=2

" C++ options
set cino+=N-s
set cino+=g0
set cino+=l1  " Switch statements

autocmd FileType vhdl setlocal commentstring=--\ %s
autocmd FileType cpp setlocal commentstring=//\ %s

" ------------------------------------------------------------------------------
" Statusline

function! ReadOnlyFlag() abort
  if &readonly
    return ''
  else
    return ''
  endif
endfunction

set statusline=\ %f\                 " File path
set statusline+=\ %m                  " Modified flag
set statusline+=\ %{ReadOnlyFlag()}   " Read-only flag

set statusline+=%=                    " LHR/RHS delimeter

set statusline+=%y                    " File type
set statusline+=\ \ %{&fileencoding} " File encoding
set statusline+=\ \ %3p%%            " Percentage through file
set statusline+=\                    " Make sure you have powerline glyphs
set statusline+=\ \ %5l\ :\ %-3c     " Line : column

highlight StatusLine   ctermfg=239 ctermbg=246
highlight StatusLineNC ctermfg=238 ctermbg=244
