{
  lib,
  stdenv,
  python3,
  udev-gothic,
}:

stdenv.mkDerivation {
  pname = "nvim-setcellwidths-table-for-udev-gothic";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [
    (python3.withPackages (ps: [ ps.fonttools ]))
  ];

  buildPhase = ''
    python main.py ${udev-gothic}/share/fonts/udev-gothic/UDEVGothic35-Regular.ttf > setcellwidths.lua
  '';

  installPhase = ''
    mkdir -p $out
    cp setcellwidths.lua $out
  '';

  meta = with lib; {
    description = "Generate setcellwidths() table for udev-gothic font";
    license = licenses.ofl;
  };
}
