{
  description = "I have sinned";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nespoli = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration/system.nix
          ./modules/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # Pass the caelestia-shell input to home-manager
              extraSpecialArgs = {
                inherit (inputs) caelestia-shell zen-browser;
              };
              users.nespoli = import ./configuration/home.nix;
            };
          }
        ];
      };
    };
}
