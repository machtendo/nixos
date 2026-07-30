#--------------------------------------------------------------------------------------------------#
# Configuration: LLM
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.llm = { pkgs, lib, ... }: {
    imports = [
     # ...
    ];

    environment = {
      systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        hermes-agent
        hermes-hud
        hermes-desktop
        # ...
      ];
    };

    sops = {
      defaultSopsFile     = ../../../../secrets/llm.yaml;
      defaultSopsFormat   = "yaml";

      age = {
        sshKeyPaths       = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        "sonarr/api_key"  = {};
      };
    };

    # Hermes Agent --------------------------------------------------------
    #
    #----------------------------------------------------------------------

    services.hermes-agent = {
      enable              = true;

      # Override --------
      #configFile         = /var/lib/hermes/config.yaml;    # Overrides All Declared Settings

      # Service ---------
      addToSystemPackages = true;
      #extraArgs           = [ "--verbose" ];
      restart             = "always";
      restartSec          = 5;

      # User
      user                = "hermes";
      group               = "hermes";
      createUser          = false;

      # Directories
      stateDir            = "/var/lib/hermes";
      workingDirectory    = "/var/lib/hermes/workspace";

      # Environment -----
      environment         = {};

      # Secrets ---------
      #environmentFiles    = [ config.sops.secrets."hermes-env".path ];

      # Container --------------------------------
      # Run in a Container (optional)
      #-------------------------------------------

      container = {
        enable                = false;
        #container_cpu         = 1;         # CPU Cores
        #container_memory      = 5120;      # Memory (MB)
        #container_disk        = 51200;     # Disk (MB)
        #container_persistent  = true;      # Persist Filesystem Across Sessions
        #image                = "ubuntu:24.04";
        #backend              = "docker";

        #hostUsers = [
        #  "your-username"
        #];

        #extraVolumes = [
        #  "/home/user/projects:/projects:rw"
        #];

        #extraOptions         = [ "--gpus" "all" ];
      };

      # Personality ------------------------------
      #
      #-------------------------------------------

      documents = {

        # Inline Definitions

        "SOUL.md"   = ''
          # SOUL.md
          You are a sharp, pragmatic AI assistant.
        '';

        "AGENTS.md" = ''
          # AGENTS.md
          Read SOUL.md first. Then help the user.
        '';

        "USER.md"   = ''
          # USER.md
          Name: Your Human
        '';

        # External Files

        #"SOUL.md"     = ${workingDirectory}/SOUL.md;
        #"AGENTS.md"   = ${workingDirectory}/AGENTS.md;
        #"USER.md"     = ${workingDirectory}/USER.md;
        #"MEMORIES.md" = ${workingDirectory}/MEMORIES.md

      };

      # Tools ------------------------------------
      # MCP, Packages, etc.
      #-------------------------------------------

      browser = {
        inactivity_timeout = 120;
      };

      tool_loop_guardrails = {
        warnings_enabled          = true;
        hard_stop_enabled         = false;
        warn_after = {
          exact_failure           = 2;
          same_tool_failure       = 2;
          idempotent_no_progress  = 2;
        };

        hard_stop_after = {
          exact_failure           = 5;
          same_tool_failure       = 8;
          idempotent_no_progress  = 5;
        };
      };

      # MCP Servers --------------------
      mcpServers = {
        filesystem  = {
          command   = "npx";
          args = [
            "-y"
            "@modelcontextprotocol/server-filesystem"
            "/var/lib/hermes/workspace"
          ];
        };

        # ...

      };

      # Skills -------------------------

      skills = {
        creation_nudge_interval   = 15;
        #external_dirs = {
        #  - ~/.agents/skills
        #  - /home/shared/team-skills
        #};
      };

      # Model ------------------------------------
      #
      #-------------------------------------------

      settings = {

        toolsets = [
          "all"
        ];

        session_reset = {
          mode          = "none";
          idle_minutes  = 1440;
          at_hour       = 4;
        };

        max_turns               = 100;
        max_concurrent_sessions = null;
        group_sessions_per_user = true;

        model = {
          provider              = "custom";
          base_url              = "http://192.168.86.239:11434/api/v1";
          default               = "ollama/laguna-s-2.1";
        };

        terminal = {
          backend               = "local";
          cwd                   = ".";
          timeout               = 180;
          home_mode             = "profile"     # force HERMES_HOME/home
        };

        # Context Compression
        compression = {
          enabled               = true;
          progress_notices      = false;
          threshold             = 0.50;
          #summary_model        = "google/gemini-3-flash-preview";
        };

        # Persistent Memory
        memory = {
          memory_enabled        = true;
          user_profile_enabled  = true;
          memory_char_limit     = 2200;
          user_char_limit       = 1375;
          nudge_interval        = 10;
          flush_min_turns       = 6;
          provider              = "hindsight";
        };

        display = {
          compact               = false;
          personality           = "technical";
        };

        agent = {
          max_turns             = 60;
          verbose               = false;
        };

        # Gateway Streaming
        streaming = {
          enabled               = false;
          #transport            = "edit";
          #edit_interval        = 0.3;
          #buffer_threshold     = 40;
          #cursor               = " ▉";
        };
      };

      #-------------------------------------------
      # Extra Options
      #-------------------------------------------

      extraDependencyGroups = [
        #"messaging"          # Discord, Telegram, Slack
        #"matrix"             # Matrix/Element
        #"dingtalk"           # DingTalk
        #"feishu"             # Feishu/Lark
        #"voice"              # Local speech-to-text (faster-whisper)
        #"edge-tts"           # Edge TTS provider
        #"tts-premium"        # ElevenLabs TTS
        #"anthropic"          # Native Anthropic SDK (not needed via OpenRouter)
        #"bedrock"            # AWS Bedrock (boto3)
        #"azure-identity"     # Azure Entra ID auth
        #"honcho"             # Honcho memory provider
        "hindsight"          # Hindsight memory provider
        #"modal"              # Modal terminal backend
        #"daytona"            # Daytona terminal backend
        #"exa"                # Exa web search
        #"firecrawl"          # Firecrawl web search
        #"fal"                # FAL image generation
      ];
    };
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
