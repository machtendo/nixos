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

    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

  outputs = inputs: inputs.flake-parts.lib.mkFlake

    { inherit inputs; }
    #(inputs.import-tree ./profiles),
    (inputs.import-tree ./);
    #(inputs.import-tree ./hosts);
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
