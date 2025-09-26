{ lib, config, ... }:{

  options = {
    ghMod = lib.mkEnableOption "enables ghMod";
  };

  config = lib.mkIf config.ghMod {
    programs.gh = {
      enable = true;
    };
  };
}
