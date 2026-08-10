#--------------------------------------------------------------------------------------------------
# Package Configuration: hyprland
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {
  # ...

  perSystem = { pkgs, lib, ... }: {
    packages.myHyprland = inputs.nix-wrapper-modules.wrappers.hyprland.wrap {
      inherit pkgs;

      settings = {

        # Hyprland Configuration
        monitor             = "DP-1, 2560x1440@144, 0x0, 1";

        general = {
          gaps_in           = 5;
          gaps_out          = 20;
          border_size       = 2;
        };

        binds = {

          # Window Management
          "SUPER, C"            = "killactive";
          "SUPER, F"            = "togglefloating";
          "SUPER, M"            = "fullscreen";

          "SUPER, CTRL, left"   = "movewindow, l";
          "SUPER, CTRL, right"  = "movewindow, r";
          "SUPER, CTRL, up"     = "movewindow, u";
          "SUPER, CTRL, down"   = "movewindow, d";

          # Workspaces
          "SUPER, 1"            = "workspace, 1";
          "SUPER, 2"            = "workspace, 2";
          "SUPER, 3"            = "workspace, 3";
          "SUPER, 4"            = "workspace, 4";

          "SUPER, SHIFT, 1"     = "movetoworkspace, 1";
          "SUPER, SHIFT, 2"     = "movetoworkspace, 2";
          "SUPER, SHIFT, 3"     = "movetoworkspace, 3";
          "SUPER, SHIFT, 4"     = "movetoworkspace, 4";

          # Applications
          "SUPER, Q"            = "exec, ghostty";
          "SUPER, B"            = "exec, brave";

        };
      };
    };
  };

}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
