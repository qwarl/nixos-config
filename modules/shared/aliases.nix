{
  environment = {
    shellAliases = {
      cls = "clear";
      reboot = "sudo reboot now";
      neofetch = "fastfetch";
      checkbuild = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      collect_garbage = "sudo nix-collect-garbage -d";
      lg = "lazygit";
    };
  };
}
