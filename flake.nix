
{
  description = "A Nix flake for the dingo Go module";

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
        default = self.packages.${pkgs.system}.dingo;
      });
    };
}
