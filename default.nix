{
  pkgs ? import <nixpkgs> { },
}:
{
  claude-code = pkgs.callPackage ./pkgs/claude-code { };
  hgrep = pkgs.callPackage ./pkgs/hgrep { };

  git-helpers = pkgs.callPackage ./pkgs/git-helpers { };
  nvim-setcellwidths-table-for-udev-gothic =
    pkgs.callPackage ./pkgs/nvim-setcellwidths-table-for-udev-gothic
      { };
  reparojson = pkgs.callPackage ./pkgs/reparojson { };
  term-banner = pkgs.callPackage ./pkgs/term-banner { };
  term-clock = pkgs.callPackage ./pkgs/term-clock { };
}
