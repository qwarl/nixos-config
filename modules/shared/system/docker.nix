# docker.nix
{ lib, config, ... }:

let
  cfg = config.userCustom.modules.docker;
in
{
  options.userCustom.modules.docker = {
    enable = lib.mkEnableOption "Enable Docker with user group support";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of usernames to add to the 'docker' group";
      example = [ "hyprland" "kde" ];
    };
  };

  config = lib.mkIf cfg.enable {
    # Bật Docker system-wide
    virtualisation.docker.enable = true;

    # Tự động thêm các user vào group docker (merge an toàn)
    users.users = lib.genAttrs cfg.users (username: {
      extraGroups = [ "docker" ];
    });
  };
}
