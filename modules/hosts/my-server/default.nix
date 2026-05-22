#---------------------------------------------------------------------------------------------------
# Host Definition: my-server
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  flake.nixosConfigurations.my-server = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.my-serverConfiguration
    ];
  };
}
