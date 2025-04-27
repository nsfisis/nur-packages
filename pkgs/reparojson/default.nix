{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "reparojson";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "reparojson";
    rev = "v${version}";
    hash = "sha256-kex4LNS7yT8BbaNE/uZrGED8Rx2QmPgCgPwBnIO2za8=";
  };
  cargoHash = "sha256-nFv22XP5bhS++li21VsB4aMJ3q5veH6zsK9cCNTVz0k=";

  meta = {
    description = "A simple command-line tool to repair JSON. It only fixes the syntactic errors and never formats the given input.";
    homepage = "https://github.com/nsfisis/reparojson";
    license = [ lib.licenses.mit ];
    mainProgram = "reparojson";
  };
}
