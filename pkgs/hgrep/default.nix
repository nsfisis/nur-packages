{
  fetchFromGitHub,
  installShellFiles,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "hgrep";
  version = "0.3.8";

  src = fetchFromGitHub {
    owner = "rhysd";
    repo = "hgrep";
    rev = "v${version}";
    hash = "sha256-GcV6tZLhAtBE0/husOqZ3Gib9nXXg7kcxrNp9IK0eTo=";
  };
  cargoHash = "sha256-NxfWY9OoMNASlWE48njuAdTI11JAV+rzjD0OU2cHLsc=";

  nativeBuildInputs = [
    installShellFiles
  ];

  # Disable bat-printer because I won't use it.
  # https://github.com/rhysd/hgrep/blob/v0.3.8/Cargo.toml#L44-L48
  buildNoDefaultFeatures = true;
  buildFeatures = [
    "ripgrep"
    # "bat-printer"
    "syntect-printer"
  ];

  checkFlags = [
    # Disable snapshot tests.
    "--skip=tests::arg_matches"
  ];

  postFixup = ''
    $out/bin/hgrep --generate-man-page > hgrep.1
    installManPage hgrep.1

    installShellCompletion --cmd hgrep \
      --bash <($out/bin/hgrep --generate-completion-script bash) \
      --zsh  <($out/bin/hgrep --generate-completion-script zsh) \
      --fish <($out/bin/hgrep --generate-completion-script fish) \
      ;
  '';

  meta = {
    description = "hgrep is a grep tool with human-friendly search output. This is similar to `-C` option of `grep` command, but its output is enhanced with syntax highlighting focusing on human readable outputs.";
    homepage = "https://github.com/rhysd/hgrep";
    changelog = "https://github.com/rhysd/hgrep/raw/v${version}/CHANGELOG.md";
    license = [lib.licenses.mit];
    mainProgram = "hgrep";
  };
}
