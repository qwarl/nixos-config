{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "/mnt/common/nixos/modules/de-wm/hyprland/wallpapers/daniil-silantev-ou_9KZ6BJ-0-unsplash.jpg";
          fit_mode = "cover";
        }
      ];
    };
  };
}
