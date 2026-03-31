{ info, ... }:
{
  home = {
    sessionVariables = {
      FLAKE_PATH = (builtins.elemAt info.configPaths 1).path;
    };
  };
}
