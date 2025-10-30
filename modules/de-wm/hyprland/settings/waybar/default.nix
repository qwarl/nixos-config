{
  lib,
  config,
  ...
}:
{
  options = {
    waybarMod = lib.mkEnableOption "enables waybarMod";
  };

  config = lib.mkIf config.waybarMod {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
    };
    home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/settings/waybar/config";

  };
}
