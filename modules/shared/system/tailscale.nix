{ lib, config, ... }:
{

  options = {
    tailscaleMod = lib.mkEnableOption "enables tailscaleMod";
  };

  config = lib.mkIf config.tailscaleMod {
    services.tailscale.enable = true;
  };
}
