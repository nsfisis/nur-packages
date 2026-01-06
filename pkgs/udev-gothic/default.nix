{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "udev-gothic";
  version = "2.1.0";

  src = fetchzip {
    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    sha256 = "sha256-9gwBT0GVNPVWoiFIKBUf5sNGkhfJCWhMFRRIGvj5Wto=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp $src/UDEVGothic35-*.ttf $out/share/fonts
  '';

  meta = with lib; {
    description = "UDEV Gothic は、ユニバーサルデザインフォントのBIZ UDゴシックと、 開発者向けフォントの JetBrains Mono を合成した、プログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/udev-gothic";
    license = licenses.ofl;
  };
}
