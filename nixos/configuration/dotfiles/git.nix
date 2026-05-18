{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "NespoliBT";
      user.email = "nespoli.bt@gmail.com";
    };
  };
}
