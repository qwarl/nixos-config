{ lib, config, ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        settings = {
          source = [
            "keybinds.conf"
            "workspaces.conf"
            "general.conf"
            "startup.conf"
          ];

          "$main" = "SUPER";
          "$fileManager" = "dolphin";
          bind = [
            "$main SHIFT CTRL ALT, Q, exec, hyprctl dispatch exit"
            "$main, E, exec, $fileManager"
          ];
        };
      };
    };
  };

  xdg.configFile."hypr/keybinds.conf".source = ./hypr/keybinds.conf;
  xdg.configFile."hypr/workspaces.conf".source = ./hypr/workspaces.conf;
  xdg.configFile."hypr/general.conf".source = ./hypr/general.conf;
  xdg.configFile."hypr/startup.conf".source = ./hypr/startup.conf;
}
