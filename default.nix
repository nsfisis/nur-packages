{
  pkgs ? import <nixpkgs> { },
}:
{
  claude-code = pkgs.callPackage ./pkgs/claude-code { };
  hgrep = pkgs.callPackage ./pkgs/hgrep { };
  source-han-code-jp = pkgs.callPackage ./pkgs/source-han-code-jp { };
  udev-gothic = pkgs.callPackage ./pkgs/udev-gothic { };

  git-helpers = pkgs.callPackage ./pkgs/git-helpers { };
  reparojson = pkgs.callPackage ./pkgs/reparojson { };
  term-banner = pkgs.callPackage ./pkgs/term-banner { };
  term-clock = pkgs.callPackage ./pkgs/term-clock { };
}
