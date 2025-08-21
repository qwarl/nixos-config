{ lib, config, ... }:{

  options = {
    ripgrepMod = lib.mkEnableOption "enables ripgrepMod";
  };

  config = lib.mkIf config.ripgrepMod {
    programs.ripgrep = {
      enable = true;
    };
  };
}
