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
    rofi
    slurp
    wf-recorder
    xdg-user-dirs
    xdg-utils

    swaynotificationcenter
    pavucontrol
    nvd
    libnotify

    # battery stat for laptop. just in case forget its name
    # powerstat
    # tlp
  ];

  # hyprpanelMod = true;
  waybarMod = true;
}
