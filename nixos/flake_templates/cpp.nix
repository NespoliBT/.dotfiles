{
  description = "C/C++ Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ clang gcc boost catch2 cmake pkg-config ];

          env = {
            CC = "clang";
            CXX = "clang++";
          };

          shellHook = ''
            echo "Compiler: $(clang --version | head -n1)"
            echo "CMake: $(cmake --version | head -n1)"
          '';
        };
      });
}
