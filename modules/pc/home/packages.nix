{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    corepack
    file
    fastfetch
    floorp
    gcc
    microsoft-edge
    nil
    nodejs
    nixfmt-rfc-style
    python314
    rustup
    tmux
    tree-sitter
    unzip
    vscode
    wget
    wl-clipboard
    yazi
  ];
}
