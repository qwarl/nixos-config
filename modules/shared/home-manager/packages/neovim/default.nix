{
  lib,
  config,
  ...
}:
{
  options = {
    neovimMod = lib.mkEnableOption "enables neovimMod";
  };

  config = lib.mkIf config.neovimMod {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
      xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE_PATH}/modules/shared/home-manager/packages/neovim/config";

  };
}
