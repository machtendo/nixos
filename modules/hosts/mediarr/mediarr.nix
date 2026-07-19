#--------------------------------------------------------------------------------------------------#
# Host Definition: mediarr
#--------------------------------------------------------------------------------------------------#

{ self, inputs, config, sops-nix, nixflix, ... }: {
  flake.nixosConfigurations.mediarr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = with self.nixosModules; [
      mediarr-cfg   # Configuration - Host: mediarr
      mediarr-hw    # Configuration - Hardware: mediarr
      user-nix      # Configuration - User: nix
      core          # Applications - Core: All Devices
      sops          # Security - Tools: sops-nix
      nixflix       # Aspect - Configuration: Nixflix
    ];
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
