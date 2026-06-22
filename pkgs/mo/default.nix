{
  lib,
  stdenvNoCC,
  buildGoModule,
  fetchFromGitHub,
  fetchPnpmDeps,
  jq,
  nodejs_22,
  pnpm_10,
  pnpmConfigHook,
}:

let
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "k1LoW";
    repo = "mo";
    rev = "v${version}";
    hash = "sha256-/PiMYllj0l3XwIkqT/sc7U/vGXdNmTD8RowZWe9ZDR8=";
  };

  frontend = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "mo-frontend";
    inherit version src;
    sourceRoot = "${src.name}/internal/frontend";

    nativeBuildInputs = [
      jq
      nodejs_22
      pnpm_10
      pnpmConfigHook
    ];

    # Remove .pnpm.executionEnv to prevent pnpm from downloading Node.js binary.
    # Drop pnpm's executionEnv.nodeVersion pin. With it set, pnpm insists on
    # managing its own Node.js and downloads it from nodejs.org at build time
    # (which fails offline) -- it does this even when the pinned version equals
    # the Node.js already on PATH, so matching the version does not help. Remove
    # the pin instead and let pnpm use the nixpkgs Node.js from nativeBuildInputs.
    postPatch = ''
      jq 'del(.pnpm.executionEnv)' package.json > package.json.tmp
      mv package.json.tmp package.json

      chmod -R u+w ../static
    '';

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs)
        pname
        version
        src
        sourceRoot
        ;
      pnpm = pnpm_10;
      fetcherVersion = 3;
      hash = "sha256-473ftja7cEzU/FrMN2xti/ChZ/j2KGhb8Gk+TIa+Pv8=";
    };

    buildPhase = ''
      runHook preBuild
      pnpm run build
      runHook postBuild
    '';

    # vite emits to ../static/dist.
    installPhase = ''
      runHook preInstall
      cp -r ../static/dist $out
      runHook postInstall
    '';
  });
in
buildGoModule {
  pname = "mo";
  inherit version src;

  vendorHash = "sha256-rmtJswO3DWWxpb2uk91aIatc7ugNmsqzwlEeKdX7ITE=";

  preBuild = ''
    cp -r ${frontend} internal/static/dist
  '';

  ldflags = [
    "-s"
    "-w"
    "-X github.com/k1LoW/mo/version.Revision=v${version}"
  ];

  meta = {
    description = "Markdown viewer that opens .md files in a browser";
    homepage = "https://github.com/k1LoW/mo";
    changelog = "https://github.com/k1LoW/mo/raw/v${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "mo";
  };
}
