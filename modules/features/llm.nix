#--------------------------------------------------------------------------------------------------#
# Configuration: LLM
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.llm = { pkgs, lib, ... }: {

    imports = [
      inputs.hermes-agent.nixosModules.default
      # ...
    ];

    # Hermes Agent --------------------------------------------------------
    #
    #----------------------------------------------------------------------

    services.hermes-agent = {
      enable = true;

      addToSystemPackages   = true;
      extraArgs             = [ "--verbose" ];
      restart               = "always";
      restartSec            = 5;

      # ── Container options ──────────────────────────────────────────────
      container = {
        enable        = false;
        image         = "ubuntu:24.04";
        backend       = "docker";
        hostUsers     = [ "your-username" ];
        extraVolumes  = [ "/home/user/projects:/projects:rw" ];
        extraOptions  = [ "--gpus" "all" ];
      };

      # Secrets ----------------------------------
      #
      #-------------------------------------------

      environmentFiles = [ config.sops.secrets."hermes-env".path ];

      # Documents --------------------------------
      #
      #-------------------------------------------

      documents = {
        "SOUL.md"       = ./documents/SOUL.md;
        "AGENTS.md"     = ./documents/AGENTS.md;
        "USER.md"       = ./documents/USER.md;
        "MEMORIES.md"   = ./documents/MEMORIES.md
      };

      # ── MCP Servers ────────────────────────────────────────────────────
      mcpServers = {
        filesystem = {
          command   = "npx";
          args      = [ "-y" "@modelcontextprotocol/server-filesystem" "/data/workspace" ];
        };

        # ...

      };

      # ── Model ──────────────────────────────────────────────────────────
      settings = {

        toolsets    = [ "all" ];
        max_turns   = 100;

        model = {
          base_url  = "https://openrouter.ai/api/v1";
          default   = "anthropic/claude-opus-4.6";
        };

        terminal = {
          backend   = "local";
          cwd       = ".";
          timeout   = 180;
        };

        compression = {
          enabled         = true;
          threshold       = 0.85;
          summary_model   = "google/gemini-3-flash-preview";
        };

        memory = {
          memory_enabled        = true;
          user_profile_enabled  = true;
        };

        display = {
          compact       = false;
          personality   = "kawaii";
        };

        agent = {
          max_turns   = 60;
          verbose     = false;
        };

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
