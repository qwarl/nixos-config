{ lib, config, ... }:{

  options = {
    polkitModule = lib.mkEnableOption "enables Polkit for dolphin on Hyprland to open sudo required folders";
  };

  config = lib.mkIf config.polkitModule {
    # config for dolphin on hyprland can open sudo requires folder
    security.polkit.enable = true;
  };
}
