#---------------------------------------------------------------------------------------------------
# Host Configuration: mediarr
#---------------------------------------------------------------------------------------------------

{ inputs, self, ... }: {

  flake.nixosConfigurations.host-mediarr-cfg = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMediarr
    ];

    system.stateVersion = "25.11";

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Networking ---------------------------------

    # Enable Networking
    networking.networkmanager.enable = true;

    # Hostname
    networking.hostName = "mediarr";

    # Network Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Firewall
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Packages  ----------------------------------

    # Packages (System)
    environment.systemPackages = with pkgs; [
     # ...
    ];

    # Services
    services.openssh.enable = true;     # OpenSSH Server
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
