#---------------------------------------------------------------------------------------------------
# Flake: Entrypoint
#---------------------------------------------------------------------------------------------------

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # flake-parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # import-tree
    import-tree.url = "github:vic/import-tree";

    # sops-nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # nixflix
    nixflix.url = "github:kiriwalawren/nixflix";
    nixflix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
