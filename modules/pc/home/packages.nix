{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    corepack
    dust
    file
    fastfetch
    ffmpeg
    floorp-bin
    gcc
    go  # for hyprls installs
    lazygit
    microsoft-edge
    nil
    nodejs
    nixfmt-rfc-style
    python314
    qbittorrent
    rustup
    telegram-desktop
    tmux
    tree-sitter
    unzip
    vscode
    wget
    wl-clipboard
    yazi
    yt-dlp
  ];
}
