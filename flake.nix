#---------------------------------------------------------------------------------------------------
# Flake: Entrypoint
#---------------------------------------------------------------------------------------------------

{
  #-----------------------------------------------
  # Description
  #-----------------------------------------------

  description = "Dendritic, Modular NixOS";

  #-----------------------------------------------
  # Binary Cache
  #-----------------------------------------------

  nixConfig = {
    substituters = [
      "https://hyprland.cachix.org"     # Hyprland Pre-Compiled Binaries
    ];

    trusted-substituters = [
      "https://hyprland.cachix.org"     # Hyprland Pre-Compiled Binaries
    ];

    extra-substituters = [
      "https://noctalia.cachix.org"     # Noctalia Pre-Compiled Binaries
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="    # Hyprland
    ];

    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="    # Noctalia
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

#---------------------------------------------------------------------------------------------------
# Flake Inputs
#---------------------------------------------------------------------------------------------------

  inputs = {

    #---------------------------------------------
    # Core NixOS
    #---------------------------------------------

    # nixpkgs: stable branch (26.05)
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # nixpkgs: unstable branch
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    #---------------------------------------------
    # Flake Modules
    #---------------------------------------------

    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    # import-tree
    import-tree = {
      url = "github:vic/import-tree";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-wrapper-modules
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    #---------------------------------------------
    # Security
    #---------------------------------------------

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #---------------------------------------------
    # Features
    #---------------------------------------------

    # nixflix
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    # noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hermes-agent
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # ...

  };

#---------------------------------------------------------------------------------------------------
# Flake Outputs
#---------------------------------------------------------------------------------------------------

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }

    (inputs.import-tree ./modules);

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------

}
