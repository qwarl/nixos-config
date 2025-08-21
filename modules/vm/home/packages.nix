{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    fastfetch
    nixfmt-rfc-style
    firefox
    nil
    wl-clipboard
    yazi
    corepack
    file
    nodejs
    python314
    btop
    tmux
    gcc
    tree-sitter
  ];
}
