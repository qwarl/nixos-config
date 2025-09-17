{ pkgs, ... }:
{
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
    khelpcenter
    konsole
    okular
  ];
}