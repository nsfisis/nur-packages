commit-upgrade PKG VERSION:
    git commit -m 'feat({{PKG}}): upgrade to {{VERSION}}'

update-claude-code:
    pkgs/claude-code/update.sh
    NIXPKGS_ALLOW_UNFREE=1 nix build --impure ".#claude-code"
    git add pkgs/claude-code
    just commit-upgrade claude-code $(nix eval --json ".#claude-code.version" | jq -r)
