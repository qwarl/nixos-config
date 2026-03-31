{ info, ... }:
{
  home = {
    sessionVariables = {
      USERS = builtins.concatStringsSep " " (map (u: u.name) info.users);
    };
  };
}
