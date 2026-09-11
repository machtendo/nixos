#---------------------------------------------------------------------------------------------------
# Module Configuration: [NAME]
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.netbird = { pkgs, lib, config, ... }: {
    imports = [
      # ...
    ];

    sops = {
      defaultSopsFile     = ../../secrets/shared.yaml;
      defaultSopsFormat   = "yaml";

      age = {
        keyFile           = "/etc/sops-nix/age/age.key";
        sshKeyPaths       = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        "setupKeyFile" = {                            # File: /run/secrets/netbird/setupKeyFile
          owner = config.users.users.netbird.name;    # Owner: User
          group = config.users.users.netbird.group;   # Owner: Group
          mode  = "0400";                             # Permissions: Read Only (Owner, Group)
        };
      };
    };

    services = {

      # Netbird Client
      netbird = {
        clients = {

          wt0 = {
            login = {
              enable              = true;
              setupKeyFile        = config.sops.secrets."netbird/setupKeyFile".path;
            };

            port                  = 51821;

            ui = {
              enable              = false;
            };

            openFirewall          = true;
            openInternalFirewall  = true;
          };
        };
      };

      # resolved
      resolved = {
        enable                    = true;
      };

      # ...

    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
