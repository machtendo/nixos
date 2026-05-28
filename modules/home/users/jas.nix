#---------------------------------------------------------------------------------------------------
# Modular Configuration: Users
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.user-jas = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
      # ...
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jas = {
      isNormalUser = true;
      description = "jas";
      initialPassword = "password";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        # ...
      ];
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
