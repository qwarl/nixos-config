{ lib, config, ... }:{

  options = {
    yaziMod = lib.mkEnableOption "enables yaziMod";
  };

  config = lib.mkIf config.yaziMod {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  home.file.".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "/mnt/common/nixos/modules/shared/home-manager/packages/yazi/config";
  };
}
