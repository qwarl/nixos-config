{ pkgs, ... }:
{
  # set default shell for system using zsh
  programs.zsh = {
    enable = true;
  };
  # Set zsh for specific user
  # users.users.kde.shell = pkgs.zsh;
  # Enable zsh default shell for all users
  users.defaultUserShell = pkgs.zsh;
}
