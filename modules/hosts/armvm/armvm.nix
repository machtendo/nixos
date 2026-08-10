#---------------------------------------------------------------------------------------------------
# Host Definition: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosConfigurations.armvm = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = with self.nixosModules; [
      armvm-cfg     # Configuration - Host: armvm
      armvm-hw      # Configuration - Hardware: armvm
      user-nix      # Configuration - User: nix
      core          # Module - Core: All Devices
      desktop       # Module - Desktop Environment
    ];
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
