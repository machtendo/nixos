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
      brave
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
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd \"${pkgs.uwsm}/bin/uwsm start hyprland\"";
        };
      };
    };

    # Desktop Environment ------------------------
    # Hyprland - Wayland Compositor
    #---------------------------------------------

    programs.hyprland = {
      enable    = true;
      withUWSM  = true; # Universal Wayland Session Manager
      settings = {
        bind = [
          # Window Management
          "SUPER, C, killactive"
          "SUPER, F, togglefloating"
          "SUPER, M, fullscreen"

          "SUPER CTRL, left, movewindow, l"
          "SUPER CTRL, right, movewindow, r"
          "SUPER CTRL, up, movewindow, u"
          "SUPER CTRL, down, movewindow, d"

          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"

          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"

          "SUPER SHIFT, M, exit, hyprland"

          # Applications =========================
          "SUPER, Q, exec, ghostty"
          "SUPER, B, exec, brave"
        ];

        # ...
      };

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
