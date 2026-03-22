{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clipse
    dragon-drop
    grim
    hyprshot
    kdePackages.dolphin
    kdePackages.polkit-kde-agent-1
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

  # hyprpanelMod = true;
}
