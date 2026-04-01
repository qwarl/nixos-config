{ config, pkgs, ... }: {
  home.packages = [ pkgs.sops ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets={
      ssh_github_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_github_sops";
      };
      ssh_server_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_server_sops";
      };
    };
  };
}
