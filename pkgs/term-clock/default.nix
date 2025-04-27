{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "term-clock";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "term-clock";
    rev = "v${version}";
    hash = "sha256-OUM4TyfqJJBpTFHnD1rwkk7W20SK1T7lxc5i2nL4TbY=";
  };
  vendorHash = "sha256-NLxaPtxhb67uhs01DASlAIfCIWV1lnuiu+uFmJcxN0U=";

  meta = {
    description = "A clock on your terminal";
    homepage = "https://github.com/nsfisis/term-clock";
    license = lib.licenses.mit;
    mainProgram = "term-clock";
  };
}
