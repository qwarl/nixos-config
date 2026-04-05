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
    home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE_PATH}/modules/de-wm/hyprland/settings/waybar/config";

  };
}
