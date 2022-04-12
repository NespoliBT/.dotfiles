syntax on

set path+=**

set wildmenu

set number

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-lua/completion-nvim'
call plug#end()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

source ~/.config/nvim/plug-config/lsp.lua
source ~/.config/nvim/plug-config/autoformat.vim
source ~/.config/nvim/plug-config/treesitter.lua

