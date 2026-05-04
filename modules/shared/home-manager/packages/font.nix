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
        nerd-fonts.fira-mono
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-sans-static
        noto-fonts-cjk-serif
        noto-fonts-cjk-serif-static
        unicode-emoji
      ];
    };

    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "CaskaydiaMono Nerd Font"
            "FiraMono Nerd Font"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "Noto Sans"
            "Noto Color Emoji"
          ];
          serif = [
            "Noto Serif"
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
