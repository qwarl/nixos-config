{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    hyprshot
    kdePackages.dolphin
    rofi
    slurp
    wf-recorder
    xdg-user-dirs
    xdg-utils

    kdePackages.polkit-kde-agent-1
    clipse
    # xdg-launch
    # xdgmenumaker
    # xdg-terminal-exec
    # xdg-desktop-portal
    dragon-drop
    swaynotificationcenter
    pavucontrol
    pulseaudio
    nvd
    libnotify

    # battery stat for laptop. just in case forget its name
    # powerstat
    # tlp
  ];

  # hyprpanelMod = true;
  waybarMod = true;
}
