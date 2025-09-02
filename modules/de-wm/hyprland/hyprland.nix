{
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
        package = null;
        portalPackage = null;
        settings = {
          "$mod" = "SUPER";

          bind = [
            "$mode, RETURN, exec, wezterm"
          ];
        };
      };
    };
  };
}
