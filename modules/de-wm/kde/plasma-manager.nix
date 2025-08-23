{pkgs, ...}:{
  programs.plasma = {
    enable = true;

    hotkeys.commands = {
      launch-wezterm = {
        name = "Launch Wezterm";
        key = "Meta+Return";
        command = "wezterm";
      };
    };
  };
}