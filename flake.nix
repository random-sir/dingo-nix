
{
  description = "A Nix flake for the dingo language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f pkgsFor.${system});
      pkgsFor = nixpkgs.lib.genAttrs supportedSystems (system: import nixpkgs {
        inherit system;
      });
    in
    {
      packages = forAllSystems (pkgs: {
        dingo = pkgs.callPackage ./default.nix { };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.dingo;
      });

      apps = forAllSystems (pkgs: {
        dingo = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.dingo}/bin/dingo";
        };
        dingo-lsp = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.dingo}/bin/dingo-lsp";
        };
        default = self.apps.${pkgs.stdenv.hostPlatform.system}.dingo;
      });
    };
}
