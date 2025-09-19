{ inputs, ... }:
{
  programs.hyprpanel = {
    # Configure and theme almost all options from the GUI.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    enable = true;
    settings = {

      # Configure bar layouts for monitors.
      # See 'https://hyprpanel.com/configuration/panel.html'.
      # Default: null
      layout = {
        bar = {
          layouts = {
            "0" = {
              left = [
                "dashboard"
                "workspaces"
              ];
              middle = [ "media" ];
              right = [
                "volume"
                "systray"
                "notifications"
              ];
            };
          };
        };
      };

      bar = {
        volume = {
          scrollUp = "hyprpanel vol +1";
          scrollDown = "hyprpanel vol -1";
        };
        network = {
          showWifiInfo = true;
        };
        notifications = {
          show_total = true;
          hideCountWhenZero = true;
        };
        clock = {
          format = "%a %d %b  %H:%M";
        };
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
      };

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather = {
          unit = "metric";
          location = "71210";
          key = "c6d8153da11645dfb7444934251809";
        };
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
