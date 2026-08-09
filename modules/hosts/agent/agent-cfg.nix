#---------------------------------------------------------------------------------------------------
# Host Configuration: agent
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.agent-cfg = { pkgs, lib, ... }: {

    imports = [
      # ...
    ];

    # Bootloader ---------------------------------

    boot = {
      loader = {
        systemd-boot = {
          enable              = true;
        };

      efi = {
        canTouchEfiVariables  = true;
        efiSysMountPoint      = "/boot";
      };
    };

    # Networking ---------------------------------

    # Enable Networking
    networking = {
      networkmanager = {
        enable          = true;
      };

      # Hostname
      hostName          = "agent";

      # Network Proxy
      #proxy = {
      #  default        = "http://user:password@proxy:port/";
      #  noProxy        = "127.0.0.1,localhost,internal.domain";
      #};

      firewall = {
        enable          = true;
        allowedTCPPorts = [ 9119 8787 ];
        allowedUDPPorts = [ 9119 8787 ];
      };

      # ...

    };

    # System -------------------------------------

    system = {
      stateVersion = "26.05";
    };

    environment = {

      systemPackages = with pkgs; [
        # ...
      ];

    };

    # Services -----------------------------------

    services = {

      # OpenSSH Server
      openssh = {
        enable = true;
      };

      # ...

    };

    # System State Version -----------------------

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
