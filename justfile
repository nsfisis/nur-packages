commit-upgrade PKG VERSION:
    git commit -m 'feat({{PKG}}): upgrade to {{VERSION}}'

update-claude-code:
    pkgs/claude-code/update.sh
    NIXPKGS_ALLOW_UNFREE=1 nix build --impure ".#claude-code"

update-reparojson:
    nix run nixpkgs#nix-update -- --flake reparojson
    nix build ".#reparojson"
