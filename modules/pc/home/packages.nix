{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop-rocm
    dust
    file
    fastfetch
    ffmpeg
    floorp-bin
    gamescope
    gcc
    gemini-cli
    go # for hyprls installs
    jq
    lazygit
    lutris
    microsoft-edge
    nil
    nixd
    nodejs_25
    nixfmt
    python314
    qbittorrent
    qwen-code
    rustup
    telegram-desktop
    tokei
    tree-sitter
    unzip
    wget
    wl-clipboard
    yt-dlp
    oversteer
    deluge
    steam
    # llama-cpp-rocm
    lm_sensors
    mediainfo
    exiftool
    poppler
    resvg
    rustdesk
    imagemagick
    libreoffice
    trash-cli
    tldr
  ];
}
