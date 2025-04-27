{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "term-banner";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "term-banner";
    rev = "v${version}";
    hash = "sha256-YCIT+6PdHLrOrPzWpF/U8G8qGcYDXkgVMde/IUWRe84=";
  };
  vendorHash = "sha256-i78RKipeirkmteFsYmmmu0gU4cjph01gn/9zl8lcpXM=";

  meta = {
    description = "Show a banner in your terminal.";
    homepage = "https://github.com/nsfisis/term-banner";
    license = lib.licenses.mit;
    mainProgram = "term-banner";
  };
}
