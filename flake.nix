{
  description = "SDDM Theme";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsForSystem = system:
        import nixpkgs {
          inherit system;
        };
    in
    {
      packages = forAllSystems (system: (pkgsForSystem system).callPackage ./default.nix { });
      devShell = forAllSystems (system: (pkgsForSystem system).callPackage ./shell.nix { });
    };
}
