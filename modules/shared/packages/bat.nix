{ lib, config, ... }:{

  options = {
    batMod = lib.mkEnableOption "enables batMod";
  };

  config = lib.mkIf config.batMod {
    programs.bat = {
      enable = true;
      config = {
        paging = "never";
      };
    };
  };
}
