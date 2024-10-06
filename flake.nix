{
  description = "SDDM Theme";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.${system}.default = pkgs.stdenv.mkDerivation {
        name = "shell";
        buildInputs = with pkgs; [
          libsForQt5.qt5.qtgraphicaleffects
          libsForQt5.qt5.qtquickcontrols2

          # Necessary for playing video
          libsForQt5.qt5.qtmultimedia
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good

          # Necessary to run `sddm-greeter --test-mode --theme .` on wayland 
          libsForQt5.qt5.qtwayland
        ];
      };
    };
}
