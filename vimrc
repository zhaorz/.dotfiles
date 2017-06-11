" Visual
set cursorline
syntax enable
colorscheme gruvbox

" Pretty vertical split
set fillchars=vert:│    " that's a vertical box-drawing character
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE guibg=NONE

" Pathogen
call pathogen#infect()
call pathogen#helptags()
Helptags

" airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab

" Disable tmuxline
let g:airline#extensions#tmuxline#enabled = 0

" whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

set nocompatible
filetype plugin indent on
syntax on

" System clipboard
if $TMUX == ''
  set clipboard=unnamed
endif
set hidden
set wildmenu
set showcmd
set hlsearch

" Usability options
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

" Indentation options
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftwidth=2

" Mappings
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
imap jk <Esc>
nnoremap ; :
nnoremap <F6> :CtrlPClearCache<CR>

" Easier split switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Highlights lines over 80 columns in red
" highlight ColorColumn ctermbg=red
" call matchadd('ColorColumn', '\%81v', 100)

" Enable transparent background (let's terminal colors take precedence)
hi Normal guibg=NONE ctermbg=NONE

