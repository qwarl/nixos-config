{
  lib,
  config,
  inputs,
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
    home.file.".config/nvim".source = inputs.neovim-config;
  };
}
