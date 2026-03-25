{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "/mnt/common/nixos/modules/de-wm/hyprland/wallpapers/daniil-silantev-3pW91fGAKiE-unsplash.jpg";
          fit_mode = "cover";
        }
      ];
    };
  };
}
