#--------------------------------------------------------------------------------------------------#
# Configuration: LLM
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.llm = { pkgs, lib, ... }: {
    imports = [
     # ...
    ];

    nixConfig = {
      extra-substituters          = [ "https://cache.numtide.com" ];
      extra-trusted-public-keys   = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
    };

    environment = {
      systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        hermes-agent
        hermes-hud
        hermes-desktop
        # ...
      ];
    };

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
