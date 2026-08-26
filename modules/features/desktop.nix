#---------------------------------------------------------------------------------------------------
# Configuration: Desktop Environment
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.desktop = { pkgs, lib, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    # Packages (System)
    environment.systemPackages = with pkgs; [
      ghostty
      brave
      # ...
    ];

    # Login Manager ------------------------------
    # greetd + tuigreet
    #---------------------------------------------

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user      = "greeter";
          command   = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd \"sh -c '${pkgs.uwsm}/bin/uwsm start hyprland'\"";
        };
      };
    };

    # Desktop Environment ------------------------
    # Hyprland - Wayland Compositor
    #---------------------------------------------

    programs.hyprland = {
      enable        = true;
      withUWSM      = true;     # Universal Wayland Session Manager
      package       = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
    };

    # Shell --------------------------------------
    # Noctalia - Wayland Shell
    #---------------------------------------------

    programs.noctalia = {
      enable        = true;

      recommendedServices = {
        enable      = true;
      };

      systemd = {
        enable      = true;
      };
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
