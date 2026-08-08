#--------------------------------------------------------------------------------------------------#
# Configuration: Desktop Environment
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, lib, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    # Packages (System)
    environment.systemPackages = with pkgs; [
      ghostty
      # ...

      # Hyprland
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland

      # Noctalia
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    ];

    # Login Manager ------------------------------
    # greetd + tuigreet
    #---------------------------------------------

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --greeting 'System Ready.' --cmd \"${pkgs.uwsm}/bin/uwsm start hyprland-session\"";
        };
      };
    };

    # Desktop Environment ------------------------
    # Hyprland - Wayland Compositor
    #---------------------------------------------

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

    # Shell --------------------------------------
    # Noctalia - Wayland Shell
    #---------------------------------------------

    programs.noctalia = {
      enable = true;

      recommendedServices = {
        enable = true;
      };

      systemd = {
        enable = true;
      };
    };

    #---------------------------------------------
    #---------------------------------------------
    #---------------------------------------------

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
