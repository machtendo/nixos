#---------------------------------------------------------------------------------------------------
# Host Definition: my-laptop
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  flake.nixosConfigurations.my-laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.my-laptopConfiguration
    ];
  };
}
