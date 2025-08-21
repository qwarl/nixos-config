{
  environment = {
    shellAliases = {
      cls = "clear";
      # update = "sudo nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#nixos";
      reboot = "sudo reboot now";
      neofetch = "fastfetch";
    };
  };
}
