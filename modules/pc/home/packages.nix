{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop-rocm
    corepack
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
    nodejs
    nixfmt-rfc-style
    python314
    qbittorrent
    rustup
    telegram-desktop
    tmux
    tokei
    tree-sitter
    unzip
    vscode
    wget
    wl-clipboard
    yazi
    yt-dlp

    ntfs3g
  ];
}
