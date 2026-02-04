{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "reparojson";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "reparojson";
    rev = "v${version}";
    hash = "sha256-HJfzxNDFzutYluc+VKcsxxzStEaizSfynyvq0U4tEs0=";
  };
  cargoHash = "sha256-sSLjobm/hWpkEaRIvPshjCXNKmLlIHOsSRyBqGTshlQ=";

  meta = {
    description = "A simple command-line tool to repair JSON. It only fixes the syntactic errors and never formats the given input.";
    homepage = "https://github.com/nsfisis/reparojson";
    license = lib.licenses.mit;
    mainProgram = "reparojson";
  };
}
