#--------------------------------------------------------------------------------------------------#
# Configuration: Desktop Environment
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, lib, ... }: {

    imports = [
      # ...
    ];

    # Cachix ------------------------------------#
    # Package Cache for hyprland
    #--------------------------------------------#

    nix.settings = {
      substituters                = [ "https://hyprland.cachix.org" ];
      trusted-substituters        = [ "https://hyprland.cachix.org" ];
      extra-substituters          = [ "https://noctalia.cachix.org" ];
      trusted-public-keys         = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      extra-trusted-public-keys   = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      trusted-users               = [ "root" "@wheel" ];
      # ...
    };

    # Desktop Environment -----------------------#
    # Hyprland - Wayland Compositor
    #--------------------------------------------#

    programs.hyprland = {
      enable = true;
      settings = [
        # ...
      ];

      #plugins = [
      #  # ...
      #];
    };

    programs.noctalia = {
      enable = true;

      recommendedServices = {
        enable = true;
      };

      systemd = {
        enable = true;
      };
    };

    # Packages (System)
    environment.systemPackages = [
      # ...

      # Hyprland
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland

      # Noctalia
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    ];

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
