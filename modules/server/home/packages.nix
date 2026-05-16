{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop-rocm
    dust
    file
    fastfetch
    gcc
    gemini-cli
    go # for hyprls installs
    jq
    lazygit
    nil
    nixd
    nodejs_25
    nixfmt
    python314
    qbittorrent-nox
    rustup
    tokei
    tree-sitter
    unzip
    wget
    wl-clipboard
    lm_sensors
    mediainfo
    exiftool
    poppler
    resvg
    imagemagick
    trash-cli
    tldr
  ];
}
