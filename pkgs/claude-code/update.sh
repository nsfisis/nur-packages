#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nodePackages.npm nix-update

# https://github.com/NixOS/nixpkgs/blob/3016b4b15d13f3089db8a41ef937b13a9e33a8df/pkgs/by-name/cl/claude-code/update.sh

set -euo pipefail

version=$(npm view @anthropic-ai/claude-code version)

# Generate updated lock file
cd "$(dirname "${BASH_SOURCE[0]}")"
npm i --package-lock-only @anthropic-ai/claude-code@"$version"
rm -f package.json

# Update version and hashes
cd -
nix-update claude-code --version "$version"
