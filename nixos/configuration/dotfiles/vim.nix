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
    ];

    extraConfig = ''
      set number
      set ignorecase
      set smartcase

      nnoremap <C-n> :NERDTreeToggle<CR>

      nnoremap <C-p> :Telescope find_files<CR>
      nnoremap <C-f> :Telescope live_grep<CR>
    '';
  };
}
