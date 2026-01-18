commit-upgrade PKG VERSION:
    git commit -m 'feat({{PKG}}): upgrade to {{VERSION}}'

update-claude-code:
    #!/usr/bin/env bash
    set -eu

    export NIXPKGS_ALLOW_UNFREE=1
    LATEST_VERSION=$(npm view @anthropic-ai/claude-code version)

    sed -i 's|version = ".*"|version = "'"$LATEST_VERSION"'"|' pkgs/claude-code/default.nix
    sed -i 's|hash = ".*"|hash = ""|' pkgs/claude-code/default.nix
    sed -i 's|npmDepsHash = ".*"|npmDepsHash = ""|' pkgs/claude-code/default.nix

    sed -i '1,10s|"version": ".*"|"version": "'"$LATEST_VERSION"'"|' pkgs/claude-code/package-lock.json

    HASH="$(nix build --impure ".#claude-code" 2>&1 | grep "got:" | awk '{ print $2 }')"
    sed -i 's|hash = ""|hash = "'"$HASH"'"|' pkgs/claude-code/default.nix

    NPM_DEPS_HASH="$(nix build --impure ".#claude-code" 2>&1 | grep "got:" | awk '{ print $2 }')"
    sed -i 's|npmDepsHash = ""|npmDepsHash = "'"$NPM_DEPS_HASH"'"|' pkgs/claude-code/default.nix

    nix build --impure ".#claude-code"
