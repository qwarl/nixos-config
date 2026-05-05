{
  imports = [
    ./aliases.nix
    ./docker.nix
    ./fail2ban.nix
    ./firewall.nix
    ./flake.nix
    ./nix-ld.nix
    ./wireguard.nix
    ./shell.nix
    # ./tailscale.nix
    ./warp.nix
    ./cachix.nix
  ];
}
