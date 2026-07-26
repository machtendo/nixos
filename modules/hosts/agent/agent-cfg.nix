#---------------------------------------------------------------------------------------------------
# Host Configuration: agent
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.agent-cfg = { pkgs, lib, ... }: {

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
    networking.hostName = "agent";

    # Network Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Firewall
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 9119 8787 ];
      allowedUDPPorts = [ 9119 8787 ];
    };

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
