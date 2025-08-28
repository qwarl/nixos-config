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
        noto-fonts-cjk-sans
        noto-fonts-cjk-sans-static
        noto-fonts-cjk-serif
        noto-fonts-cjk-serif-static
      ];
    };

    fonts = {
      fontconfig = {
        enable = true;
      };
    };
  };
}
