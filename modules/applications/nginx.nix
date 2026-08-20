#--------------------------------------------------------------------------------------------------
# Module Configuration: nginx
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.searxng = { pkgs, lib, config, ... }: {
    imports = [
      # ...
    ];

    # Systemd configuration
    systemd.services.nginx.serviceConfig.ProtectHome = false;

    # User management
    users.groups.searx.members = ["nginx"];

    # Nginx configuration
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts = {
        "search.example.com" = {
          forceSSL = true;
          sslCertificate = "...";
          sslCertificateKey = "...";
          locations = {
            "/" = {
              extraConfig = ''
                uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
              '';
            };
          };
        };
      };
    };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
