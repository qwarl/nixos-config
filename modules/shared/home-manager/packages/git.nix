{ lib, config, info, ... }:
{
  options = {
    gitMod = lib.mkEnableOption "enables gitMod";
  };

  config = lib.mkIf config.gitMod {
    programs.git = {
      enable = true;
      settings = {
        user.email = "${info.email}";
        user.name = "${(builtins.elemAt info.users 2).name}";
        safe.directory = [
          "${(builtins.elemAt info.configPaths 0).path}"
        ];
      };
    };
    programs.delta={
      enable = true;
      enableGitIntegration = true;
    };
  };
}
