#---------------------------------------------------------------------------------------------------
# Flake: Entrypoint
#---------------------------------------------------------------------------------------------------

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    #wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  # Import all .nix files from current directory except flake.nix recursively
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    isNixModule = file:
      # Include all .nix files
      file.hasExt "nix"
      # Exclude flake.nix
      && file.name != "flake.nix"
      # Exclude "_filename.ext"
      && !lib.hasPrefix "_" file.name;

    importTree = path:
      toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
      in
    mkFlake {imports = importTree ./.;};
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
