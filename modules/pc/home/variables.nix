{ info,... }:
{
  home = {
    sessionVariables = {
      FLAKE_PATH = (builtins.elemAt info.configPaths 0).path;
    };
  };
}
