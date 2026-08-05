#--------------------------------------------------------------------------------------------------
# Module Configuration: Overlay - Unstable Packages (nixpkgs-unstable)
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixopsModules.overlay-unstablePackages = {pkgs, config, lib, ... }: {

    imports = [
      # ...
    ];

    # Option Definition
    options.unstablePackages = {
      default       = [];
      type          = types.list;
      description   = "List of packages to source from nixpkgs-unstable.";
    };

    # Overlay Definition
    nixpkgs.overlays = [(
      final: prev:

      let
        pkgList = config.unstablePackages;

        unstable      = import inputs.nixpkgs-unstable {
          system      = pkgs.system;
          config      = {};
        };

        # List Definition
        overrides = builtins.listToAttr (map (name: {
          name        = name;
          value       = unstable.${name};
        }) pkgList);

      in
        # Merge List into Package List
        overrides
    )];

  };

}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
