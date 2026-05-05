# firewall.nix
{ lib, config, ... }:

let
  cfg = config.userCustom.modules.firewall;
in
{
  options.userCustom.modules.firewall = {
    enable = lib.mkEnableOption "Enable Firewall with custom port support";

    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [];
      description = "List of TCP ports to allow";
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [];
      description = "List of UDP ports to allow";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = cfg.allowedTCPPorts;
      allowedUDPPorts = cfg.allowedUDPPorts;
    };
  };
}
