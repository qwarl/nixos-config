{ pkgs, ... }:
{
  # Bật daemon service cho warp
  services.cloudflare-warp.enable = false;

  # Cài đặt gói cloudflare-warp và jq
  environment.systemPackages = [
    # pkgs.cloudflare-warp
  ];
}
