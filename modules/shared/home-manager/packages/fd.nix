{ lib, config, ... }:{

  options = {
    fdMod = lib.mkEnableOption "enables fdMod";
  };

  config = lib.mkIf config.fdMod {
    programs.fd = {
      enable = true;
      ignores = [
        ".git/"
      ];
      hidden = true;
    };
  };
}
