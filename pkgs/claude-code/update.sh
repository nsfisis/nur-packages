#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages nodejs nix-update git cacert

# https://github.com/NixOS/nixpkgs/blob/4061fac1353e86e502f8c59e179d6d948e329a00/pkgs/by-name/cl/claude-code/update.sh

set -euo pipefail

version=$(npm view @anthropic-ai/claude-code version)

# Update version and hashes
AUTHORIZED=1 NIXPKGS_ALLOW_UNFREE=1 nix-update claude-code --version="$version" --generate-lockfile
# nix-update vscode-extensions.anthropic.claude-code --use-update-script --version "$version"
