{ self, inputs, ... }: {

  flake.nixosModules.baseConfiguration = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
    #self.nixosModules.mediarrHardware
    ];

    # ...

  };
 }
