{ pkgs, ... }:
{
  # Enables improved Linux module drivers for Logitech driving wheels
  services.udev.packages = [ pkgs.oversteer ];
  hardware.new-lg4ff.enable = true;
}
