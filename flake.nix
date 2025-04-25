{
  description = "MaaJR dev with nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
          unstable = import inputs.nixpkgs-unstable { inherit system; };
        in
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              gcc14Stdenv.cc.cc
              python311Packages.tkinter
            ];
            buildInputs = with pkgs; [
              expect
            ];

            shellHook = ''
              export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.gcc14Stdenv.cc.cc.lib}/lib
            '';
          };
        });
}
