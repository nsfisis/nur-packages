{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "reparojson";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "reparojson";
    rev = "v${version}";
    hash = "sha256-dJzOR0J63sDb/gfm+H5KwdcAdqcFCHXuCtj6C6sMQK4=";
    fetchSubmodules = true;
  };
  cargoHash = "sha256-Coj64lPl7o8RjKI/6CqmwiIfNnegGeG9D6/yP/zuyh0=";

  meta = {
    description = "A simple command-line tool to repair JSON. It only fixes the syntactic errors and never formats the given input.";
    homepage = "https://github.com/nsfisis/reparojson";
    license = lib.licenses.mit;
    mainProgram = "reparojson";
  };
}
