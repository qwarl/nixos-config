{ pkgs, config, ... }:
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
            ", Print, exec, hyprshot -m active -m output --clipboard-only" # capture current screen to clipboard
            "$main, V, exec, wezterm start --class clipse clipse && /mnt/common/nixos/modules/de-wm/hyprland/settings/scripts/clipse-autopaste"
          ];
          binds = [
            "Super_L&SHIFT_L, S, exec, hyprshot -m region --clipboard-only"
            "Super_L&SHIFT_R, S, exec, hyprshot -m region -o $save-place -f $time-format" # save region capture

            "Shift_R, Print, exec, hyprshot -m active -m output -o $save-place -f $time-format" # save current screen capture
          ];
        };
      };
    };
  };

  xdg.configFile."hypr/keybinds.conf".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/hypr/keybinds.conf";
  xdg.configFile."hypr/workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/hypr/workspaces.conf";
  xdg.configFile."hypr/general.conf".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/hypr/general.conf";
  xdg.configFile."hypr/startup.conf".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/hypr/startup.conf";
  xdg.configFile."hypr/windowrules.conf".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/de-wm/hyprland/hypr/windowrules.conf";
}
