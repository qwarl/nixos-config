{ lib, config, ... }:{

  options = {
    yaziMod = lib.mkEnableOption "enables yaziMod";
  };

  config = lib.mkIf config.yaziMod {
    programs.yazi = {
      enable = true;
    };
  home.file.".config/yazi".source = ./config;
  };
}
