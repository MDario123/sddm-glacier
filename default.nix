{ pkgs, lib, stdenvNoCC, themeConfig ? null }:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-glacier";
  version = "1.0";

  src = ./.;

  dontWrapQtApps = true;

  buildInputs = with pkgs.libsForQt5.qt5; [
    qtgraphicaleffects
  ];

  installPhase =
    let
      iniFormat = pkgs.formats.ini { };
      configFile = iniFormat.generate "" { General = themeConfig; };

      basePath = "$out/share/sddm/themes/glacier";
    in
    ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}
    '' + lib.optionalString (themeConfig != null) ''
      ln -sf ${configFile} ${basePath}/theme.conf.user
    '';

  meta = {
    description = "Minimalistic with sharp and clean aesthetics!";
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
