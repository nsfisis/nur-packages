{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "deck";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "k1LoW";
    repo = "deck";
    rev = "v${version}";
    hash = "sha256-dH19BREXUid4euMhK5D2bLFq5rONmZeyUrCQG+8uQf4=";
  };
  vendorHash = "sha256-eXW91aWBfVAkPSyqhrHIS4vLJwQqCSGNwr5BdY24KS4=";

  nativeBuildInputs = [
    installShellFiles
  ];

  postFixup = ''
    installShellCompletion --cmd deck \
      --bash <($out/bin/deck completion bash) \
      --zsh  <($out/bin/deck completion zsh) \
      --fish <($out/bin/deck completion fish) \
      ;
  '';

  doCheck = false;

  meta = {
    description = "A tool for creating deck using Markdown and Google Slides.";
    homepage = "https://github.com/k1LoW/deck";
    license = lib.licenses.mit;
    mainProgram = "deck";
  };
}
