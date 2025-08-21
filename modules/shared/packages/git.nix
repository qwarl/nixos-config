{ lib, config, ... }:
{
  options = {
    gitMod = lib.mkEnableOption "enables gitMod";
  };

  config = lib.mkIf config.gitMod {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
      };
      userEmail = "quannngoc98@gmail.com";
      userName = "qwarl";
    };
  };
}
