syntax on

set path+=**
set wildmenu
set number
set encoding=UTF-8

let g:blamer_enabled = 1

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-lua/completion-nvim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'APZelos/blamer.nvim'
	Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
	Plug 'romgrk/barbar.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

source ~/.config/nvim/plug-config/lsp.lua
source ~/.config/nvim/plug-config/autoformat.vim
source ~/.config/nvim/plug-config/treesitter.lua
