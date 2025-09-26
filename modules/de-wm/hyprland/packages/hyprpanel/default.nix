{ inputs, pkgs, ... }:
{
  programs.hyprpanel = {
    package = inputs.hyprpanel.packages.${pkgs.system}.default;
    enable = true;
    settings = {
      bar = {
        customModules = {
          cava = {
            framerate = 144;
            bars = 26;
            leftClick = "menu:media";
            stereo = true;
          };
          power = {
            leftClick = "menu:power";
          };
          storage = {
            paths = "/";
          };
        };
        layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "cputemp"
              "windowtitle"
            ];
            middle = [
              "cava"
            ];
            right = [
              "volume"
              "network"
              "bluetooth"
              "battery"
              "systray"
              "clock"
              "notifications"
              "power"
            ];
          };
        };
        network = {
          showWifiInfo = true;
        };
        notifications = {
          hideCountWhenZero = true;
          show_total = true;
        };
        volume = {
          scrollUp = "hyprpanel vol +1";
          scrollDown = "hyprpanel vol -1";
        };
        clock = {
          format = "%a %d %b  %H:%M";
        };
        launcher.autoDetectIcon = true;
        workspaces = {
          monitorSpecific = false;
          showWsIcons = true;
          workspaces = 10;
          workspaceIconMap = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };
      };

      menus.clock = {
        dashboard = {
          directories = {
            enabled = true;
          };
          stats = {
            enable_gpu = false;
          };
        };
        media = {
          displayTime = true;
          displayTimeTooltip = true;
        };
        time = {
          hideSeconds = true;
          military = true;
        };
        weather = {
          key = "c6d8153da11645dfb7444934251809";
          location = "71210";
          unit = "metric";
        };
      };

      theme = {
        bar = {
          transparent = true;
        };
        font = {
          name = "FiraMono Nerd Font";
          size = "1rem";
        };
        matugen = true;
        matugen_settings.mode = "dark";
      };

      wallpaper = {
        enable = false;
        image = "/home/hyprland/Downloads/pawel-czerwinski-uBReUvlYvyY-unsplash.jpg";
      };
    };
  };
}
