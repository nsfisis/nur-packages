{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "git-helpers";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "git-helpers";
    rev = "v${version}";
    hash = "sha256-6aRPjED6yarVobMGAfCNC5pWkNHoz7Il0DUt9Wwja/0=";
  };
  vendorHash = null;

  meta = {
    description = "My git helpers";
    homepage = "https://github.com/nsfisis/git-helpers";
    license = lib.licenses.mit;
  };
}
