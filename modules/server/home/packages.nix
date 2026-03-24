{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop-rocm
    dust
    file
    fastfetch
    gcc
    go # for hyprls installs
    jq
    lazygit
    nil
    nixd
    nodejs_25
    nixfmt
    python314
    rustup
    tmux
    tokei
    tree-sitter
    unzip
    wget
    wl-clipboard
    ntfs3g
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
