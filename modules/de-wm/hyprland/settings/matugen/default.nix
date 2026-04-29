{ config, ... }:
{
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    reload_apps = true
    reload_waybar = true

    [templates.waybar]
    input_path = '${config.home.homeDirectory}/.config/waybar/colors.css.template'
    output_path = '${config.home.homeDirectory}/.config/waybar/colors.css'
  '';
}
