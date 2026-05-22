#---------------------------------------------------------------------------------------------------
# Host Definition: my-desktop
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  flake.nixosConfigurations.my-desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.my-desktopConfiguration
    ];
  };
}
