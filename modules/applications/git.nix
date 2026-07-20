#------------------------------------------------#
# Application Module: Git
#------------------------------------------------#


{ self, inputs, ... }: {
  flake.nixosModules.git = {pkgs, lib, ... }: {
    imports = [
      # ...
    ];

      # Packages (System)
    environment.systemPackages = with pkgs; [
      git           # Git - Version Control
    ];
  };
}
