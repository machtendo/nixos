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
    users.users.nix = {
      isNormalUser = true;
      description = "nix";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];

    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
