#---------------------------------------------------------------------------------------------------
# Modular Configuration: Users
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.user-hermes = { pkgs, lib, ... }: {

    imports = [
      # ...
    ];

    # Group
    users.groups = {
      hermes            = {};    # Automatically Generate GID
    };

    # User Account
    users.users.hermes = {
      isSystemUser      = true;
      group             = "hermes";
      description       = "hermes";
      initialPassword   = "password";
      extraGroups       = [ "hermes" ];
      packages          = with pkgs; [
        # ...
      ];
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
