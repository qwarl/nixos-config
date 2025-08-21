{ pkgs, ... }:
{
  # Enable the KDE SDDM.
  # services.displayManager.sddm = {
  #   enable = true;
  #   enableHidpi = true;
  #   wayland.enable = true;
  #   autoNumlock = true;
  # };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    plasma-systemmonitor
    okular
    elisa
  ];
}
