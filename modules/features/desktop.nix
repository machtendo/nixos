#--------------------------------------------------------------------------------------------------#
# Configuration: Desktop Environment
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, lib, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    # Desktop Environment -----------------------#
    # Hyprland - Wayland Compositor
    #--------------------------------------------#

    programs.hyprland = {
      enable    = true;
      withUWSM  = true; # Universal Wayland Session Manager
      #settings = [
      #  # ...
      #];

      #plugins = [
      #  # ...
      #];
    };

    #xwayland.enable = false; # Xwayland can be disabled.

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
