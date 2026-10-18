commit-upgrade PKG VERSION:
    git commit -m 'feat({{PKG}}): upgrade to {{VERSION}}'

update-claude-code:
    pkgs/claude-code/update.sh
    NIXPKGS_ALLOW_UNFREE=1 nix build --impure ".#claude-code"
    git add pkgs/claude-code
    just commit-upgrade claude-code $(nix eval --json ".#claude-code.version" | jq -r)

update-term-clock:
    nix run nixpkgs#nix-update -- --flake term-clock
    nix build ".#term-clock"
    git add pkgs/term-clock
    just commit-upgrade term-clock $(nix eval --json ".#term-clock.version" | jq -r)
