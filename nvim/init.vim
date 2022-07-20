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
set signcolumn=yes
set termguicolors

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

filetype plugin indent on    " required

syntax enable

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
" Plug 'dracula/vim', {'as':'dracula'}
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" auto completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" git related
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'airblade/vim-gitgutter'

" other plugins
Plug 'ThePrimeagen/harpoon'
Plug 'dewyze/vim-tada'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sbdchd/neoformat'
Plug 'rust-lang/rust.vim'
Plug 'github/copilot.vim'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

call plug#end()

:lua require('lsp-conf')
:lua require('plugin-conf')
:lua require('git-worktree-conf')
" :lua require('cmp-tabnine')

set completeopt=menu,menuone,noselect

" This is how to write lua code in vimscript
" lua << EOF
" require'lspconfig'.tsserver.setup{}
" EOF

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup BRAILOR
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufWritePre *.js Neoformat
    autocmd BufWritePre *.ts Neoformat
    autocmd BufWritePre *.tsx Neoformat
    autocmd BufWritePre *.json Neoformat
augroup END

" colorscheme dracula
colorscheme gruvbox

let g:go_fmt_command = "goimports"
let g:neoformat_try_node_exe = 1
let g:rustfmt_autosave = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
