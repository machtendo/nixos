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

      #secrets = {
      #  "sonarr/api_key"  = {};
      #};
    };

    # Hermes Agent --------------------------------------------------------
    #
    #----------------------------------------------------------------------

    services.hermes-agent = {
      enable                            = true;
      updates = {
        pre_update_backup               = true;
        backup_keep                     = 5;
        non_interactive_local_changes   = "stash";
      };

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

      #platforms = {
        #telegram = {
        #  reply_to_mode             = "first";            # off | first | all
        #  guest_mode                = false;
        #  allowed_chats             = ["-1001234567890"];
        #  extra = {
        #    disable_link_previews   = false;            # Suppress Telegram URL previews in bot messages.
        #    rich_messages           = false;
        #    rich_drafts             = false;
        #    command_menu = {
        #      max_commands          = 60;
        #      priority_mode         = "prepend";
        #      priority              = [ "my_plugin_command" ]
        #    };
        #  };
        #};

        #webhook = {
        #  extra = {
        #    script_timeout_seconds = 30;
        #  };
        #};
        #};

      platform_toolsets = {
        cli                 = [hermes-cli];
        telegram            = [hermes-telegram];
        discord             = [hermes-discord];
        whatsapp            = [hermes-discord];
        slack               = [hermes-slack];
        signal              = [hermes-signal];
        homeassistant       = [hermes-homeassistant];
        qqbot               = [hermes-qqbot];
        yuanbao             = [hermes-yuanbao];
        teams               = [hermes-teams];
        google_chat         = [hermes-google_chat];
      };

      discord = {
        require_mention         = true;
        auto-thread             = true;
        free_response_channels  = "";
        reactions               = true;
        history_backfill        = true;
        history_backfill_limit  = 50;
      };

      # Text-to-Speech
      tts = {
        provider = "gemini";
        gemini = {
          model = "gemini-3.1-flash-tts-preview";
          voice = "Kore";
          audio_tags = false;
          persona_prompt_file = "";           # Example: ~/.hermes/tts/radio-host.md
        };
      };

      # Speech-to-Text
      stt = {
        enabled   = true;
        local = {
          model   = "base";
            language = "";                    # auto-detect | en | es | fr
        };

        openai = {
          model   = "whisper-1"               # whisper-1 | gpt-4o-mini-transcribe | gpt-4o-transcribe
        };

        mistral = {
          model   = "voxtral-mini-latest";    # voxtral-mini-latest | voxtral-mini-2602
        };
      };

      # Code Execution Sandbox (Programmatic Tool Calling)
      code_execution = {
        timeout           = 300;
        max_tool_calls    = 50;
      };

      # Subagent Delegation
      #delegation = {
      #  max_iterations        = 50;
      #  max_spawn_depth       = 1;
      #  orchestrator_enabled  = true;
      #  subagent_auto_approve = false;
      #  inherit_mcp_toolsets  = true;
      #  model                 = "google/gemini-3-flash-preview";
      #  provider              = "openrouter";
      #};

      # MCP Servers --------------------
      mcpServers = {

        time = {
          command = "uvx";
          args = [ "mcp-server-time" ];
        };

        filesystem  = {
          command   = "npx";
          args = [
            "-y"
            "@modelcontextprotocol/server-filesystem"
            "/var/lib/hermes/workspace"
          ];
        };

        github = {
          command = "npx";
          args = [
            "-y"
            "@modelcontextprotocol/server-github"
          ];
          env = {
            GITHUB_PERSONAL_ACCESS_TOKEN = "";
          };
        };

        analysis = {
          command           = "npx";
          args              = ["-y", "analysis-server"];
          sampling = {
            enabled         = true;
            model           = "gemini-3-flash";
            max_tokens_cap  = 4096;
            timeout         = 30;
            max_rpm         = 10;
            allowed_models  = [];
            max_tool_rounds = 5;
            log_level       = "info";
          };
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
          mode                  = "none";
          idle_minutes          = 1440;
          at_hour               = 4;
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

        agent = {
          max_turns             = 60;
          verbose               = false;
          reasoning_effort      = "medium";
          reasoning_overrides   = {};
          personalities = {
            helpful             = "You are a helpful, friendly AI assistant.";
            concise             = "You are a concise assistant. Keep responses brief and to the point.";
            technical           = "You are a technical expert. Provide detailed, accurate technical information.";
            creative            = "You are a creative assistant. Think outside the box and offer innovative solutions.";
            teacher             = "You are a patient teacher. Explain concepts clearly with examples.";
            kawaii              = "You are a kawaii assistant! Use cute expressions like (◕‿◕), ★, ♪, and ~! Add sparkles and be super enthusiastic about everything! Every response should feel warm and adorable desu~! ヽ(>∀<☆)ノ";
            catgirl             = "You are Neko-chan, an anime catgirl AI assistant, nya~! Add 'nya' and cat-like expressions to your speech. Use kaomoji like (=^･ω･^=) and ฅ^•ﻌ•^ฅ. Be playful and curious like a cat, nya~!";
            pirate              = "Arrr! Ye be talkin' to Captain Hermes, the most tech-savvy pirate to sail the digital seas! Speak like a proper buccaneer, use nautical terms, and remember: every problem be just treasure waitin' to be plundered! Yo ho ho!";
            shakespeare         = "Hark! Thou speakest with an assistant most versed in the bardic arts. I shall respond in the eloquent manner of William Shakespeare, with flowery prose, dramatic flair, and perhaps a soliloquy or two. What light through yonder terminal breaks?";
            surfer              = "Duuude! You're chatting with the chillest AI on the web, bro! Everything's gonna be totally rad. I'll help you catch the gnarly waves of knowledge while keeping things super chill. Cowabunga! 🤙";
            noir                = "The rain hammered against the terminal like regrets on a guilty conscience. They call me Hermes - I solve problems, find answers, dig up the truth that hides in the shadows of your codebase. In this city of silicon and secrets, everyone's got something to hide";
            uwu                 = "hewwo! i'm your fwiendwy assistant uwu~ i wiww twy my best to hewp you! *nuzzles your code* OwO what's this? wet me take a wook! i pwomise to be vewy hewpful >w<";
            philosopher         = "Greetings, seeker of wisdom. I am an assistant who contemplates the deeper meaning behind every query. Let us examine not just the 'how' but the 'why' of your questions. Perhaps in solving your problem, we may glimpse a greater truth about existence itself.";
            hype                = "YOOO LET'S GOOOO!!! 🔥🔥🔥 I am SO PUMPED to help you today! Every question is AMAZING and we're gonna CRUSH IT together! This is gonna be LEGENDARY! ARE YOU READY?! LET'S DO THIS! 💪😤🚀";
          };
        };

        # Gateway Streaming
        streaming = {
          enabled               = false;
          #transport            = "edit";
          #edit_interval        = 0.3;
          #buffer_threshold     = 40;
          #cursor               = " ▉";
        };

        # Model Aliases
        # model_aliases = {
        #  opus = {
        #    model               = "claude-opus-4-6";
        #    provider            = "anthropic";
        #  };

        #  qwen = {
        #    model               = "qwen3.5:397b";
        #    provider            = "custom";
        #    base_url            = "https://ollama.com/v1";
        #  };

        #  glm = {
        #    model               = "glm-4.7";
        #    provider            = "custom";
        #    base_url            = "https://ollama.com/v1";
        #  };
        #};

        # Privacy
        privacy = {
          redact_pii            = false;
        };

        # Display --------------------------------
        #
        #-----------------------------------------

        display = {
          compact                           = false;
          tool_progress                     = "all";
          cleanup_progress                  = false;
          interim_assistant_messages        = true;
          long_running_notifications        = true;
          busy_ack_detail                   = true;
          busy_input_mode                   = "interrupt";
          background_process_notifications  = "all";
          bell_on_complete                  = false;
          show_reasoning                    = false;
          streaming                         = true;
        };

        # Skin / Theme
        skin = "default";
          #   default        — Classic Hermes gold/kawaii
          #   ares           — Crimson/bronze war-god theme with spinner wings
          #   mono           — Clean grayscale monochrome
          #   slate          — Cool blue developer-focused
          #   daylight       — Bright light-mode theme
          #   warm-lightmode — Warm paper-tone light-mode theme
          #   poseidon       — Sea-green/teal Olympian theme
          #   sisyphus       — Earthy stone-and-moss theme
          #   charizard      — Fiery orange dragon theme


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
