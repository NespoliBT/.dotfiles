{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdtree
      emmet-vim
      vim-gitgutter
      vim-commentary
      vim-be-good
    ];

    extraConfig = ''
      set number
      set ignorecase
    '';
  };
}
