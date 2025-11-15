{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdtree
      emmet-vim
      gitgutter
      commentary
      vim-be-good
    ];

    extraConfig = ''
      set number
      set ignorecase
    '';
  };
}
