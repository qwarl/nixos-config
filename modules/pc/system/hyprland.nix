{ pkgs, lib, config, inputs, ... }:{

  options = {
    hyprlandModule = lib.mkEnableOption "enables Hyprland with cachix optimization";
  };

  config = lib.mkIf config.hyprlandModule {
    # Enable hyprland
    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
      config.common.default = [ "gtk" ];
      config.hyprland.default = [ "gtk" "hyprland" ];
    };
  };
}