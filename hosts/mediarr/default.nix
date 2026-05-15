#---------------------------------------------------------------------------------------------------
# Host Definition: mediarr
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  flake.nixosConfigurations.mediarr = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.mediarr
    ];
  };
}
