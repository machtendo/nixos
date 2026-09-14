#---------------------------------------------------------------------------------------------------
# Application: Pi
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.pi = { pkgs, lib, config, ... }: {
    imports = [
      inputs.pi.nixosModules.default
      # ...
    ];

    programs = {
      pi = {
        coding-agent = {
          enable                      = true;
          #extraArgs                  = [ "--provider" "openai" "--model" "gpt-5" ];

          #environment = {
          #
            PI_CODING_AGENT_DIR = {
              value                   = "/var/lib/pi-agent";
            };
          #  
          #  OPENAI_API_KEY = {
          #    file                   = config.sops.secrets.openai-api-key.path;
          #  };
          #
          #};

          #jail = {
          #  enable                   = true;
          #};

          rules                       = ''Be concise.'';
          #skills                     = [ ./skills/my-skill ];
          #extensions                 = [ ./extensions/my-extension.ts ];
          #themes                     = [ ./themes/catppuccin-mocha.json ];
          #promptTemplates            = [ ./prompts ];
          #models                     = ./models.json;

          #settings = {
          #  model                    = "gpt-5";
          #};
        };
      };
    };

    # ...

  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
