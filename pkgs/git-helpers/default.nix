{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "git-helpers";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nsfisis";
    repo = "git-helpers";
    rev = "v${version}";
    hash = "sha256-iK3P91PwKgQz4WIQBJVGjDP65dZSB0LL/NGItMj/wzQ=";
  };
  vendorHash = null;

  meta = {
    description = "My git helpers";
    homepage = "https://github.com/nsfisis/git-helpers";
    license = lib.licenses.mit;
  };
}
