# { pkgs, ... }:
# {
#   home.packages = with pkgs.kdePackages; [
#     # plasma-desktop
#     # plasma-workspace
#     #   kwin
#   ];

#   programs.plasma = {
#     enable = true;
#     krunner = {
#       historyBehavior = "enableAutoComplete";
#       position = "top";
#       shortcuts.launch = "Alt+Space";
#     };
#   };
# }

{pkgs, ...}:{
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
    khelpcenter
    konsole
  ];
}