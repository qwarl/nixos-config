{pkgs, ...}:{
  programs.plasma = {
    enable = true;
    krunner = {
      historyBehavior = "enableAutoComplete";
      position = "center";
    };
    hotkeys.commands = {
      launch-wezterm = {
        name = "Launch Wezterm";
        key = "Meta+Return";
        command = "wezterm";
      };
    };
  };
}