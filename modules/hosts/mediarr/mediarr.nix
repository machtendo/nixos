#--------------------------------------------------------------------------------------------------#
# Host Definition: mediarr
#--------------------------------------------------------------------------------------------------#

{ self, inputs, config, sops-nix, nixflix, ... }: {
  flake.nixosConfigurations.mediarr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [

      # Host Configuration
      self.nixosModules.host-mediarr-cfg
      inputs.sops-nix.nixosModules.sops
      inputs.nixflix.nixosModules.default

    ];
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
