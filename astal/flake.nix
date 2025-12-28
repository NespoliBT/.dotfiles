{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ags.url = "github:aylur/ags";
  };

  outputs = { self, nixpkgs, ags }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      agsPkgs = ags.packages.${system};
    in {
      packages.${system}.default = ags.lib.bundle {
        inherit pkgs;
        src = ./.;
        name = "my-shell"; # name of executable
        entry = "app.ts";
        gtk4 = false;

        # additional libraries and executables to add to gjs' runtime
        extraPackages = [
          agsPkgs.astal3
          agsPkgs.io
          agsPkgs.battery
          agsPkgs.wireplumber
          agsPkgs.network
          agsPkgs.bluetooth
          agsPkgs.hyprland
          agsPkgs.notifd
          agsPkgs.apps
          agsPkgs.battery
          # pkgs.fzf
        ];
      };
    };
}
