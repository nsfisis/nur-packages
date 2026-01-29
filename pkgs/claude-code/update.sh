#!/usr/bin/env nix
#!nix shell --ignore-environment nixpkgs#cacert nixpkgs#curl nixpkgs#bash --command bash
#
# https://github.com/NixOS/nixpkgs/blob/4bf6c8d6f2d10c7924c08c7d51e02d6702484960/pkgs/by-name/cl/claude-code-bin/update.sh

set -euo pipefail

BASE_URL="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"

VERSION=$(curl -fsSL "$BASE_URL/latest")

curl -fsSL "$BASE_URL/$VERSION/manifest.json" --output pkgs/claude-code/manifest.json
