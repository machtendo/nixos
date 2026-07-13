#--------------------------------------------------------------------------------------------------#
# Host Definition: mediarr
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {
  flake.nixosConfigurations.mediarr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
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
