{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    fontsMod = lib.mkEnableOption "enables fontsMod";
  };

  config = lib.mkIf config.fontsMod {
    home = {
      packages = with pkgs; [
        nerd-fonts.caskaydia-mono
        nerd-fonts.fira-code
        noto-fonts
        noto-fonts-color-emoji
      ];
    };

    fonts = {
      fontconfig = {
        enable = true;
      };
    };
  };
}
