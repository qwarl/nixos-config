{lib, pkgs, config, ...}:
{
  options = {
    neovimMod = lib.mkEnableOption "enables neovimMod";
  };

  config = lib.mkIf config.neovimMod {
    home.packages = [ pkgs.neovim ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE_PATH}/modules/shared/home-manager/packages/neovim/config";
  };
}
