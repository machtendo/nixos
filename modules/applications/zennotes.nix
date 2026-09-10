#---------------------------------------------------------------------------------------------------
# Application Module: ZenNotes
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.zennotes = { pkgs, lib, config, ... }: {
    imports = [
      # ...
    ];

    networking = {
      firewall = {
        allowedTCPPorts = [ config.services.zennotes.port ];
      };
    };

    options.services.zennotes = {
      enable = lib.mkEnableOption "ZenNotes Self-Hosted Server";

      vault = lib.mkOption {
        type = lib.types.path;
        description = "Path to the Markdown vault directory.";
      };

      authToken = lib.mkOption {
        type = lib.types.str;
        description = "The bootstrap authentication token for the server.";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 7878;
        description = "Port the ZenNotes server listens on.";
      };
    };

    config = lib.mkIf config.services.zennotes.enable {

      # User and Group Management
      users = {
        users = {
          zennotes = {
            isSystemUser              = true;
            group                     = "zennotes";
            home                      = "/var/lib/zennotes";
            createHome                = true;
          };
        };

        groups = {
          zennotes = {};
        };
      };

      # Systemd Service Configuration
      systemd.services.zennotes = {
        description                   = "ZenNotes Self-Hosted Go Server";
        after                         = [ "network.target" ];
        wantedBy                      = [ "multi-user.target" ];

        serviceConfig = {
          # References the package defined in the derivation
          ExecStart                   = "${pkgs.zennotes}/bin/zennotes-server --port ${toString config.services.zennotes.port} --vault ${config.services.zennotes.vault} --token ${config.services.zennotes.authToken}";
          Restart                     = "always";
          User                        = "zennotes";
          Group                       = "zennotes";

          # Security Hardening
          ProtectSystem               = "full";
          ProtectHome                 = "tmpfs";
          PrivateTmp                  = true;
          NoNewPrivileges             = true;
          ProtectControlGroups        = true;
          ProtectKernelModules        = true;
          ProtectKernelTunables       = true;
          RestrictRealtime            = true;
          CapabilityBoundingSet       = "";
        };

        # Lifecycle: Ensure vault exists and is owned by the service user
        preStart = ''
          mkdir -p ${config.services.zennotes.vault}
          chown zennotes:zennotes ${config.services.zennotes.vault}
        '';
      };
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
