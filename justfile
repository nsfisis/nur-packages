commit-upgrade PKG VERSION:
    git commit -m 'feat({{PKG}}): upgrade to {{VERSION}}'

update-claude-code:
    pkgs/claude-code/update.sh
    NIXPKGS_ALLOW_UNFREE=1 nix build --impure ".#claude-code"
    git add pkgs/claude-code
    just commit-upgrade claude-code $(nix eval --json ".#claude-code.version" | jq -r)

update-reparojson:
    nix run nixpkgs#nix-update -- --flake reparojson
    nix build ".#reparojson"
    git add pkgs/reparojson
    just commit-upgrade reparojson $(nix eval --json ".#reparojson.version" | jq -r)

update-mo:
    nix run nixpkgs#nix-update -- --flake mo
    nix build ".#mo"
    git add pkgs/mo
    just commit-upgrade mo $(nix eval --json ".#mo.version" | jq -r)
