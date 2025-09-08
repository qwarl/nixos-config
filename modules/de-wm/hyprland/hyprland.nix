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
          ];

          "$mod" = "SUPER";
          "$term" = "wezterm";
          bind = [
            "$mod, Return, exec, $term"
          ];
        };
      };
    };
  };

  xdg.configFile."hypr/keybinds.conf".source = ./hypr/keybinds.conf;
  xdg.configFile."hypr/workspaces.conf".source = ./hypr/workspaces.conf;
}
