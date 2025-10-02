{ lib, config, ... }:{

  options = {
    nameMod = lib.mkEnableOption "enables nameMod";
  };

  config = lib.mkIf config.nameMod {

  };
}
