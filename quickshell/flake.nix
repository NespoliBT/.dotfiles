{
  description = "Quickshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, quickshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ quickshell.packages.${system}.default ];
          shellHook = "";
        };

        packages.default = pkgs.writeShellApplication {
          name = "quickshell-run";
          runtimeInputs = [ quickshell.packages.${system}.default ];
          text = ''
            quickshell --path "$PWD"
          '';
        };
      });
}
