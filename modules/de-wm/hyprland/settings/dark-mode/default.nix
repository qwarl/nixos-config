{ pkgs, ... }:
{
  # GNOME dconf setting for GTK apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Environment variables for GTK and QT apps
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Environment variables for apps that read them directly
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    XDG_DESKTOP_PORTAL = "1";
  };
}
