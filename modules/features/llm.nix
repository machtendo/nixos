#--------------------------------------------------------------------------------------------------#
# Configuration: LLM
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.llm = { pkgs, lib, llm-agents, ... }: {
    imports = [
     # ...
    ];

    nix.settings = {
      extra-substituters = [
        "https://cache.numtide.com"
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };

    nixpkgs.overlays = [ llm-agents.overlays.shared-nixpkgs ];
    environment.systemPackages = [
      pkgs.llm-agents.hermes-agent
    ];

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
