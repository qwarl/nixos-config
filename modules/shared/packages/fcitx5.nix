{ pkgs, lib, config, ... }:{

  options = {
    fcitx5Mod = lib.mkEnableOption "enables fcitx5Mod";
  };

  config = lib.mkIf config.fcitx5Mod {
    i18n.inputMethod = {
      enable = true;
      fcitx5.addons = with pkgs; [
      fcitx5-bamboo
      fcitx5-gtk
      fcitx5-mozc
      fcitx5-chinese-addons
    ];
    type = "fcitx5";
    };
  };
}