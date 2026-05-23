#---------------------------------------------------------------------------------------------------
# Modular Configuration: Users
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.baseConfiguration = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
    # ...
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jas = {
      isNormalUser = true;
      description = "jas";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];

    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
