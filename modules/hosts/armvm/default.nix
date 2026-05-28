#---------------------------------------------------------------------------------------------------
# Host Definition: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  flake.nixosConfigurations.armvm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # Host Configuration
      self.nixosModules.host-armvm
    ];
  };

  flake.nixosModules.host-armvm = { self, inputs, ... }: {
    imports = [
      # Host Configuration
      inputs.nixosModules.host-armvm-cfg
      inputs.nixosModules.host-armvm-hw

      # User Configuration
      self.nixosModules.user-nix
      self.nixosModules.user-jas

      # Modules
      self.nixosModules.config-base
    ];
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
