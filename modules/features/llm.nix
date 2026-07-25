#--------------------------------------------------------------------------------------------------#
# Configuration: Core System - All Devices
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.llm = { pkgs, lib, ... }: {

    imports = [
      inputs.hermes-agent.nixosModules.default
      # ...
    ];

    # Hermes
    services.hermes-agent = {
      enable = true;
      #configFile = /etc/hermes/config.yaml;
      settings = {
        #model.default         = "anthropic/claude-sonnet-4";
        #environmentFiles      = [ config.sops.secrets."hermes-env".path ];
        addToSystemPackages   = true;
        toolsets              = [ "all" ];
        terminal              = { backend = "local"; timeout = 180; };

        # Personality
        display   = { compact = false; personality = "kawaii"; };
        memory    = { memory_enabled = true; user_profile_enabled = true; };
      };
    };

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
