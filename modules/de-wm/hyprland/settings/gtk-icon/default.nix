{ pkgs, ... }:
{
  # add icon for hyprpanel
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita"; # Or "Papirus" for more coverage
      package = pkgs.adwaita-icon-theme; # Adjust as needed
    };
  };
}
