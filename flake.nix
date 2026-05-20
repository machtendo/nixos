#---------------------------------------------------------------------------------------------------
# Flake: Entrypoint
#---------------------------------------------------------------------------------------------------

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, import-tree, ... }:

  flake-parts.lib.mkFlake { inherit inputs; } {

    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    imports = [
      (import-tree ./modules)
    ];

    flake = {
      nixosConfigurations = {
        mediarr = nixpkgs.lib.nixosSystem {
          #system = "x86_64-linux";
          system = "aarch64-darwin";

          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./hosts/mediarr/configuration.nix
          ];
        };
      };
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
