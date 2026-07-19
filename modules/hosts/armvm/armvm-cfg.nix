#---------------------------------------------------------------------------------------------------
# Host Configuration: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.armvm-cfg = { pkgs, lib, ... }: {
    imports = [
      # ...
    ];

    # Bootloader ---------------------------------

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";

    # Networking ---------------------------------

    # Enable Networking
    networking.networkmanager.enable = true;

    # Hostname
    networking.hostName = "armvm";

    # Network Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Firewall
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Packages  ----------------------------------

    # System
    environment.systemPackages = with pkgs; [
     # ...
    ];

    # Services -----------------------------------

    services.openssh.enable = true;     # OpenSSH Server

    # System State Version -----------------------
    system.stateVersion = "26.05";

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
