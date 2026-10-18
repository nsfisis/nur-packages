{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "term-clock";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "term-clock";
    rev = "v${version}";
    hash = "sha256-1A6Nb9kCPGiw1hzfHIbzvHnB+1YWUwdlhNilN9u6YxI=";
  };
  vendorHash = "sha256-6c10id1CCJNeicLY+V6DAF9z5i3cs0EK3nUzR0k4ddU=";

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
