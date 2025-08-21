{ lib, config, ... }:{

  options = {
    ezaMod = lib.mkEnableOption "enables ezaMod";
  };

  config = lib.mkIf config.ezaMod {
    programs.eza = {
      enable = true;
      icons = "always";
      colors = "always";
      git = true;
      enableZshIntegration = true;
    };
  };
}
