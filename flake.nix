{
  inputs = {
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    devenv,
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        (self: super: rec {
          nodejs = super.nodejs_20;
          pnpm = super.nodePackages.pnpm;
        })
      ];
      pkgs = import nixpkgs {inherit overlays system;};
    in {
      devShells.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          ({pkgs, ...}: {
            packages = with pkgs; [
              nodejs
              pnpm
            ];
          })
        ];
      };
    });
}
