{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "term-clock";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "term-clock";
    rev = "v${version}";
    hash = "sha256-IB6AFQpbTVfDbEbTnq4sWTxKHAoNQlmw5tvBl13y4yc=";
  };
  vendorHash = "sha256-NLxaPtxhb67uhs01DASlAIfCIWV1lnuiu+uFmJcxN0U=";

  nativeBuildInputs = [
    installShellFiles
  ];

  postFixup = ''
    installShellCompletion --cmd term-clock \
      --bash <($out/bin/term-clock completion bash) \
      --zsh  <($out/bin/term-clock completion zsh) \
      --fish <($out/bin/term-clock completion fish) \
      ;
  '';

  meta = {
    description = "A clock on your terminal";
    homepage = "https://github.com/nsfisis/term-clock";
    license = lib.licenses.mit;
    mainProgram = "term-clock";
  };
}
