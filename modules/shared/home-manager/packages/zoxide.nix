{ lib, config, ... }:{

  options = {
    zoxideMod = lib.mkEnableOption "enables zoxideMod";
  };

  config = lib.mkIf config.zoxideMod {
    programs.zoxide = {
      enable = true;
    };
  };
}
