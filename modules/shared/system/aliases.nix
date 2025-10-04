{
  environment = {
    shellAliases = {
      cls = "clear";
      reboot = "systemctl reboot";
      neofetch = "fastfetch";
      checkbuild = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      collect_garbage = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      zed = "zeditor";
    };
  };
}
