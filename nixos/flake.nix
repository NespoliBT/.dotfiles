{
  description = "I have sinned";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.nespoli = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration/system.nix
          ./modules/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nespoli = import ./configuration/home.nix;
          }
        ];
      };
    };
}
