{ pkgs,... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        settings = {
          exec-once = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          source = [
            "keybinds.conf"
            "workspaces.conf"
            "general.conf"
            "startup.conf"
            "windowrules.conf"
          ];

          "$main" = "SUPER";
          "$fileManager" = "dolphin";
          "$time-format" = "$(date +%d-%m-%Y_%H-%M-%S).png";
          "$save-place" = "~/Pictures/Screenshots/";

          bind = [
            "$main SHIFT CTRL ALT, Q, exec, hyprctl dispatch exit"
            "$main, E, exec, $fileManager"
            "Alt, Space, exec, rofi -show drun"
            ", Print, exec, hyprshot -m active -m output --clipboard-only -o $save-place -f $time-format"
          ];
          binds = [
            "Super_L&SHIFT_L, S, exec, hyprshot -m region --clipboard-only -o $save-place -f $time-format"
            "Super_L&SHIFT_R, S, exec, hyprshot -m region -o $save-place -f $time-format" # save region capture

            "Shift_R, Print, exec, hyprshot -m active -m output -o $save-place -f $time-format" # save screenshot capture
          ];
        };
      };
    };
  };

  xdg.configFile."hypr/keybinds.conf".source = ./hypr/keybinds.conf;
  xdg.configFile."hypr/workspaces.conf".source = ./hypr/workspaces.conf;
  xdg.configFile."hypr/general.conf".source = ./hypr/general.conf;
  xdg.configFile."hypr/startup.conf".source = ./hypr/startup.conf;
  xdg.configFile."hypr/windowrules.conf".source = ./hypr/windowrules.conf;
}
