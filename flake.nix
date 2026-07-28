#---------------------------------------------------------------------------------------------------
# Flake: Entrypoint
#---------------------------------------------------------------------------------------------------

{
  description = "Dendritic NixOS";

  nixConfig = {
    substituters = [
      "https://hyprland.cachix.org"
    ];

    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];

    extra-substituters = [
      "https://cache.numtide.com"
      "https://noctalia.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];

    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  inputs = {

    # nixpkgs: unstable
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # import-tree
    import-tree = {
      url = "github:vic/import-tree";
    };

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # numtide llm-agents
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }

    (inputs.import-tree ./modules);
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
