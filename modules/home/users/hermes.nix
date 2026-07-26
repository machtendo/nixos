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
      hermes = {};    # Automatically Generate GID
    };

    # User Account
    users.users.hermes = {
      isNormalUser      = true;
      description       = "hermes";
      initialPassword   = "password";
      extraGroups       = [ "networkmanager" "wheel" ];
      packages          = with pkgs; [
        # ...
      ];
    };

  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
