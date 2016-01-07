" Visual
set cursorline
syntax enable
if !has('gui_running')
  " Compatibility for Terminal
  let g:solarized_termtrans=1
  " Make Solarized use 16 colors for Terminal support
  let g:solarized_termcolors=16
endif
set background=light
colorscheme solarized

" NERDTree
let g:NERDTreeWinSize = 22
let NERDTreeIgnore = ['\.pyc$']

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab

" whitespace
nmap <F5> :StripWhitespace <CR>

set nocompatible
filetype plugin indent on
syntax on

" System clipboard
set clipboard=unnamed
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

" Mappings
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
imap jk <Esc>
nnoremap <C-_> :NERDTreeToggle<CR>
nnoremap ; :

" Easier split switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Highlights lines over 80 columns in red
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

