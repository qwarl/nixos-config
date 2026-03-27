{ pkgs, ... }: {
  home.packages = with pkgs; [
    anydesk
    btop-rocm
    dust
    file
    fastfetch
    ffmpeg
    floorp-bin
    gamescope
    gcc
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
    rustup
    telegram-desktop
    tokei
    tree-sitter
    unzip
    vscode
    wget
    wl-clipboard
    yt-dlp

    ntfs3g
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
