{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    wezterm-config = {
      url = "github:qwarl/wezterm-config";
      flake = false;
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-lotus = {
      url = "github:LotusInputMethod/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      info = {
        users = [
          { name = "hyprland"; }
          { name = "kde"; }
          { name = "qwarl"; }
          { name = "quan"; }
          { name = "server"; }
        ];
        stateVersion = "26.05";
        configPaths = [
          { path = "/mnt/common/nixos"; }
          { path = "/home/server/nixos-config"; }
        ];
        email = "quannngoc98@gmail.com";
      };
    in
    {
      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/vm/configuration.nix
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              home-manager.users.quan = import ./modules/users/quan.nix;
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs info; };

          modules = [
            ./hosts/pc/configuration.nix

            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops

                {
                  imports = [
                    ./modules/pc/home
                    ./modules/shared/home-manager
                  ];

                  batMod = true;
                  ezaMod = true;
                  fdMod = true;
                  fontsMod = true;
                  fzfMod = true;
                  ghMod = true;
                  gitMod = true;
                  mpvMod = true;
                  neovimMod = true;
                  ripgrepMod = true;
                  tmuxMod = true;
                  vscodeMod = true;
                  weztermMod = true;
                  yaziMod = true;
                  zedMod = true;
                  zoxideMod = true;
                  zshMod = true;
                }
              ];
              home-manager.users."kde" = {
                imports = [
                  ./modules/users/kde.nix
                  #   inputs.plasma-manager.homeModules.plasma-manager
                ];
              };
              home-manager.users."hyprland" = import ./modules/users/hyprland.nix;
              home-manager.extraSpecialArgs = { inherit inputs info; };
            }
          ];
        };
        server = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs info; };

          modules = [
            ./hosts/server/configuration.nix
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops

                {
                  imports = [
                    ./modules/server/home
                    ./modules/shared/home-manager
                  ];

                  batMod = true;
                  ezaMod = true;
                  fdMod = true;
                  fzfMod = true;
                  ghMod = true;
                  gitMod = true;
                  neovimMod = true;
                  ripgrepMod = true;
                  tmuxMod = true;
                  yaziMod = true;
                  zoxideMod = true;
                  zshMod = true;
                }
              ];
              home-manager.users.server = import ./modules/users/server.nix;
              home-manager.extraSpecialArgs = { inherit inputs info; };
            }
          ];
        };
      };
    };
}
