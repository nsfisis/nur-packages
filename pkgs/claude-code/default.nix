# https://github.com/NixOS/nixpkgs/blob/3016b4b15d13f3089db8a41ef937b13a9e33a8df/pkgs/by-name/cl/claude-code/package.nix

{
  lib,
  buildNpmPackage,
  fetchzip,
  nodejs_20,
}:

buildNpmPackage rec {
  pname = "claude-code";
  version = "1.0.51";

  nodejs = nodejs_20; # required for sandboxed Nix builds on Darwin

  src = fetchzip {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "sha256-sAILRsi8ZViMfcpqykfnFQzHTJHRwRSZz45otMqa4U0=";
  };

  npmDepsHash = "sha256-r/Na3lU7YQ8W5PUuL5EfPu1a/Rz6hBLw/9XmSrKHD1o=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  AUTHORIZED = "1";

  # `claude-code` tries to auto-update by default, this disables that functionality.
  # https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview#environment-variables
  postInstall = ''
    wrapProgram $out/bin/claude \
      --set DISABLE_AUTOUPDATER 1
  '';

  passthru.updateScript = ./update.sh;

  meta = {
    description = "Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://github.com/anthropics/claude-code";
    downloadPage = "https://www.npmjs.com/package/@anthropic-ai/claude-code";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      malo
      omarjatoi
    ];
    mainProgram = "claude";
  };
}
