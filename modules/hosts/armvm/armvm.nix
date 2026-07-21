#---------------------------------------------------------------------------------------------------
# Host Definition: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosConfigurations.armvm = inputs.nixpkgs.lib.nixosSystem {

    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = with self.nixosModules; [
      armvm-cfg     # Configuration - Host: armvm
      armvm-hw      # Configuration - Hardware: armvm
      user-nix      # Configuration - User: nix
      core          # Configuration - Core: All Devices

    ];
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
