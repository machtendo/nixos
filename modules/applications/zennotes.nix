#---------------------------------------------------------------------------------------------------
# Application Module: ZenNotes
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.zennotes = { pkgs, lib, config, ... }: {
    imports = [
      #inputs.zennotes.nixosModules.default
      # ...
    ];

    networking = {
      firewall = {
        allowedTCPPorts = [ 7878 ];
      };
    };

    sops = {
      defaultSopsFile     = ../../secrets/llm.yaml;
      defaultSopsFormat   = "yaml";

      age = {
        keyFile           = "/home/hermes/.config/sops/age/keys.txt";
        sshKeyPaths       = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        "zennotes/authToken" = {};
      };
    };

    services.zennotes = {
      enable            = true;
      vault             = "/var/lib/zennotes/vault";
      authToken         = config.sops.secrets."zennotes/authToken".path;
      port              = 7878;
      persistSessions   = true;
      disableWatcher    = false;
      extraArgs         = [ "--max-asset-bytes=104857600" ]; # 100MB Limit
    };
  };
}
#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
