set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set hidden
set incsearch
set scrolloff=12
set backspace=indent,eol,start  " more powerful backspacing
set background=dark
set signcolumn=yes
set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

filetype off                  " required
syntax enable

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'valloric/youcompleteme'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'git://git.wincent.com/command-t.git'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', {'as':'dracula'}

call plug#end()

" key mappings example
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl <Plug>(coc-openlink)g
" " there's way more, see `:help coc-key-mappings@en'
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree | wincmd p
:set number
let g:ale_fixers = {
	 \ 'javascript': ['eslint']
 \ }

" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup BRAILOR
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
colorscheme dracula
