#!/usr/bin/env nix-shell
#!nix-shell --pure -i bash --packages nodejs nix-update git

# https://github.com/NixOS/nixpkgs/blob/7df7ff7d8e00218376575f0acdcc5d66741351ee/pkgs/by-name/cl/claude-code/update.sh

set -euo pipefail

version=$(npm view @anthropic-ai/claude-code version)

# Update version and hashes
AUTHORIZED=1 NIXPKGS_ALLOW_UNFREE=1 nix-update claude-code --version="$version" --generate-lockfile
# nix-update vscode-extensions.anthropic.claude-code --use-update-script --version "$version"
