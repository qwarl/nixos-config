{ lib, config, ... }:{

  options = {
    mpvMod = lib.mkEnableOption "enables mpvMod";
  };

  config = lib.mkIf config.mpvMod {
    programs.mpv = {
      enable = true;
    };
  home.file.".config/mpv".source = ./config;
  };
}
