{ lib, config, ... }:
{

  options = {
    vscodeMod = lib.mkEnableOption "enables vscodeMod";
  };

  config = lib.mkIf config.vscodeMod {
    programs.vscode = {
      enable = true;
    };
    xdg.configFile."Code/User/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE_PATH}/modules/shared/home-manager/packages/vscode/config/settings.json";
  };
}
