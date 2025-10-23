{ lib, config, ... }:
{
  options = {
    gitMod = lib.mkEnableOption "enables gitMod";
  };

  config = lib.mkIf config.gitMod {
    programs.git = {
      enable = true;
      settings = {
        user.email = "quannngoc98@gmail.com";
        user.name = "qwarl";
        safe.directory = "/mnt/common/nixos";
      };
    };
    programs.delta={
      enable = true;
      enableGitIntegration = true;
    };
  };
}
