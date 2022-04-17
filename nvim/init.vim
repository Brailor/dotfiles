set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

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

Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

:lua require('lsp-conf')
" :lua require('plugin-conf')

" lua << EOF
" require'lspconfig'.tsserver.setup{}
" EOF

let mapleader = " "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" " there's way more, see `:help coc-key-mappings@en'
filetype plugin indent on    " required
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
