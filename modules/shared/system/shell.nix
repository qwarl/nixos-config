{ pkgs, ... }:
{
  # Set zsh default shell for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
