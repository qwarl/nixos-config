{
  imports = [
    ./fcitx5.nix
    ./hardware-accelerated.nix
    ./nix-ld.nix
    ./hyprland.nix
    ./auto-mount.nix
    ./documentation.nix
    ./polkit.nix
    ./flake.nix

    # below don't use module so just import make them work
    ./driver.nix
    ./external-drive.nix
  ];
}
