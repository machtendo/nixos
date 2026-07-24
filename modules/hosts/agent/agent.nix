#---------------------------------------------------------------------------------------------------
# Host Definition: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosConfigurations.agent = inputs.nixpkgs.lib.nixosSystem {

    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = with self.nixosModules; [
      agent-cfg     # Configuration - Host: armvm
      agent-hw      # Configuration - Hardware: armvm
      user-nix      # Configuration - User: nix
      core          # Configuration - Core: All Devices

    ];
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
