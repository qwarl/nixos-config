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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      wezterm-config,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
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
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.users.quan = import ./hosts/vm/home.nix;
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/pc/configuration.nix

            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.users.kde = import ./hosts/pc/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
    };
}
