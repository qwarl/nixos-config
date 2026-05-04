{ pkgs, ... }:
{
  home.packages = with pkgs; [
    matugen
    clipse
    dragon-drop
    grim
    hyprshot
    kdePackages.ark
    kdePackages.polkit-kde-agent-1
    kdePackages.qtsvg
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
    pulseaudio
    pavucontrol
    rofi
    slurp
    wf-recorder
    xdg-user-dirs
    xdg-utils

    swaynotificationcenter
    hyprpaper
    hyprlock
    nvd
    libnotify
  ];

  dolphinMod = true;
  # hyprpanelMod = true;
}
