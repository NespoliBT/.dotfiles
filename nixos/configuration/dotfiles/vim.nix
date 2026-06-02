{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      nerdtree
      vim-devicons
      telescope-nvim
      barbar-nvim
      nvim-web-devicons
    ];

    extraConfig = ''
	set number
	set ignorecase
	set smartcase



	nnoremap <C-b> :NERDTreeToggle<CR>

	nnoremap <C-p> :Telescope find_files<CR>
	nnoremap <C-f> :Telescope live_grep<CR>
	nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>


	set t_Co=16
	hi clear

	if exists("syntax_on")
		syntax reset
	endif

	let g:colors_name = "ansi16"

	" Editor defaults
	hi Normal       ctermfg=7  ctermbg=0
	hi CursorLine   cterm=NONE ctermbg=0
	hi CursorColumn cterm=NONE ctermbg=0
	hi Visual       cterm=NONE ctermbg=4
	hi LineNr       ctermfg=8  ctermbg=0
	hi StatusLine   ctermfg=0  ctermbg=7
	hi StatusLineNC ctermfg=8  ctermbg=0

	" Syntax
	hi Comment      ctermfg=8  cterm=italic
	hi Constant     ctermfg=6
	hi String       ctermfg=2
	hi Character    ctermfg=2
	hi Number       ctermfg=6
	hi Boolean      ctermfg=6
	hi Identifier   ctermfg=4
	hi Function     ctermfg=4 cterm=bold
	hi Statement    ctermfg=1 cterm=bold
	hi Conditional  ctermfg=1
	hi Repeat       ctermfg=1
	hi Label        ctermfg=5
	hi Operator     ctermfg=7
	hi Keyword      ctermfg=1
	hi Exception    ctermfg=1

	" Types
	hi Type         ctermfg=3
	hi StorageClass ctermfg=3
	hi Structure    ctermfg=3
	hi Typedef      ctermfg=3

	" Special
	hi PreProc      ctermfg=5
	hi Include      ctermfg=5
	hi Special      ctermfg=5
	hi Error        ctermfg=15 ctermbg=1
	hi Todo         ctermfg=0  ctermbg=3

	" Diff
	hi DiffAdd      ctermfg=2  ctermbg=0
	hi DiffChange   ctermfg=3  ctermbg=0
	hi DiffDelete   ctermfg=1  ctermbg=0
	hi DiffText     ctermfg=4  ctermbg=0

	" Search
	hi Search       ctermfg=0  ctermbg=3
	hi IncSearch    ctermfg=0  ctermbg=3

	" MatchParen
	hi MatchParen   cterm=bold ctermfg=0 ctermbg=6

	" Cursor and selection
	hi Cursor       cterm=reverse
	hi TermCursor   cterm=reverse

	" Fold
	hi Folded       ctermfg=8  ctermbg=0
	hi FoldColumn   ctermfg=8  ctermbg=0

	" Spell
	hi SpellBad     cterm=underline ctermfg=1
	hi SpellCap     cterm=underline ctermfg=3
	hi SpellRare    cterm=underline ctermfg=5

	" LSP / Diagnostics (if available)
	hi LspError     ctermfg=1 cterm=bold
	hi LspWarning   ctermfg=3 cterm=bold
	hi LspInfo      ctermfg=4 cterm=bold
	hi LspHint      ctermfg=6 cterm=bold

	highlight Normal guibg=none
	highlight NonText guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
    '';
  };
}
