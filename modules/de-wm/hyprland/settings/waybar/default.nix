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
    home.file.".config/waybar".source = ./config;

  };
}
