#---------------------------------------------------------------------------------------------------
# Host Definition: mediarr
#---------------------------------------------------------------------------------------------------

{ inputs, self, ... }: {
  flake.nixosConfigurations.mediarr = { lib, ... } {
    modules = [
      # Host Configuration
      self.nixosModules.host-mediarr
    ];
  };

  flake.nixosModules.host-mediarr = { inputs, ... }: {
    imports = [
      # Host Configuration
      self.nixosModules.host-mediarr-cfg
      self.nixosModules.host-mediarr-hw

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
