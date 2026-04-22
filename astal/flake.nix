{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal?ref=5baeb660214bcafc9ae0b733a1bc84f5fa6078f4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags?ref=a6a7a0adb17740f4c34a59902701870d46fbb6a4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, astal, ags }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation rec {
        name = "my-shell";
        src = ./.;
        gtk4 = false;

        nativeBuildInputs = [
          ags.packages.${system}.default
          pkgs.wrapGAppsHook
          pkgs.gobject-introspection
        ];

        buildInputs = with astal.packages.${system}; [
          astal3
          io
          battery
          wireplumber
          network
          hyprland
          notifd
          apps
          bluetooth
        ];

        installPhase = ''
          mkdir -p $out/bin
          ags bundle app.ts $out/bin/${name}
          chmod +x $out/bin/${name}
        '';
      };
    };
}
