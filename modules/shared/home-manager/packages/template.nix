{ lib, config, ... }:{

  options = {
    packageMod = lib.mkEnableOption "enables packageMod";
  };

  config = lib.mkIf config.packageMod {
    programs.package = {
      enable = true;
    };
  };
}
