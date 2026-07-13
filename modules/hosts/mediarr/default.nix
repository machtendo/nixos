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
      sops-nix.nixosModules.sops
      nixflix.nixosModules.default

    ];
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
