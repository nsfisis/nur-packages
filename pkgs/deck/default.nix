{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "deck";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "k1LoW";
    repo = "deck";
    rev = "v${version}";
    hash = "sha256-vOEk6rnyyoIEHnE/6/oTGkmGG9kkbdeR7yDCWwB37T0=";
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
