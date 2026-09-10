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
      vault             = "/home/user/my-vault";
      authToken         = "your-super-secret-token";
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
