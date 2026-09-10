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
        allowedTCPPorts = [ 7878 ];
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
