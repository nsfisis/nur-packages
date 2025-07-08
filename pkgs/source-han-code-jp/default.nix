{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "source-han-code-jp";
  version = "2.012R";

  src = fetchurl {
    url = "https://github.com/adobe-fonts/source-han-code-jp/releases/download/${version}/SourceHanCodeJP.ttc";
    sha256 = "sha256-9DCTixBW55/2DPQih247u9NI9XjTj/ZDB04taZLNlfU=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp $src $out/share/fonts/SourceHanCodeJP.ttc
  '';

  meta = with lib; {
    description = "A derivative of Source Han Sans for coding";
    homepage = "https://github.com/adobe-fonts/source-han-code-jp";
    license = licenses.ofl;
  };
}
