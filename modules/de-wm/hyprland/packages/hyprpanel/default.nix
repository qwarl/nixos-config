{ inputs, pkgs, ... }:
{
  programs.hyprpanel = {
    package = inputs.hyprpanel.packages.${pkgs.system}.default;
    enable = true;
    settings = {
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
        name = "FiraMono Nerd Font";
        size = "16px";
      };
    };
  };
}
