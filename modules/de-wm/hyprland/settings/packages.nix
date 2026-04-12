{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
    nvd
    libnotify
  ];

  dolphinMod = true;
  # hyprpanelMod = true;
}
