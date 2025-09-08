{
  imports = [
    # ../../modules/pc/home/packages.nix
    ../de-wm/hyprland
  ];
  home = {
    homeDirectory = "/home/hyprland";
    stateVersion = "25.05";
    username = "hyprland";
  };

}
