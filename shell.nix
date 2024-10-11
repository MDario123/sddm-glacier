{ pkgs }:

let
  sddm = pkgs.plasma5Packages.sddm.override ({
    extraPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtmultimedia
    ];
  });
  runCommand = pkgs.writeShellScriptBin "run" ''
    sddm-greeter --test-mode --theme .
  '';
in
pkgs.stdenvNoCC.mkDerivation {
  name = "shell";

  buildInputs = with pkgs; [
    sddm
    # Necessary GStreamer plugins for playing video
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-libav
    # Util
    runCommand
  ];
}
