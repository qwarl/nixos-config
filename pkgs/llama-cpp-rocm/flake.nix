{
  description = "Llama.cpp with ROCm support (AMD GPU)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = {
        llama-cpp-rocm = import ./default.nix { inherit pkgs; };
        default = self.packages.${system}.llama-cpp-rocm;
      };
    };
}
