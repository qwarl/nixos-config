{lib, config, pkgs, ...}:
{
  options = {
    dolphinMod = lib.mkEnableOption "enables dolphin configuration";
  };

  config = lib.mkIf config.dolphinMod {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
    # https://github.com/NixOS/nixpkgs/issues/409986#issuecomment-3931363516
    xdg.configFile."menus/applications.menu".source = ./config/dolphin.menu;
  };
}
