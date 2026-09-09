{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.hermes-gateway;
in {
  options.services.hermes-gateway = {
    enable = lib.mkEnableOption "Hermes Desktop Gateway";
    port = lib.mkOption {
      type = lib.types.submodule {
        options = {
          number = lib.mkOption { type = lib.types.port; default = 8080; };
          host = lib.mkOption { type = lib.types.str; default = "0.0.0.0"; };
        };
      };
    };
    stateDir = lib.mkOption { type = lib.types.path; default = "/var/lib/hermes"; };
  };

  config = lib.mkIf cfg.enable {
    # REMOVED the 'config.' prefix.
    # 'services' and 'networking' are directly available on the 'config' object.
    services.hermes-gateway = {
      # This is redundant but ensures the sub-module recognizes its own name
    };

    networking.firewall.allowedTCPPorts = [ cfg.port.number ];

    systemd.services.hermes-gateway = {
      description = "Hermes Desktop Gateway Backend";
      after = [ "hermes-agent.service" ];
      requires = [ "hermes-agent.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "hermes";
        Group = "hermes";
        ExecStart = "${inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/hermes-backend --port ${toString cfg.port.number} --host ${cfg.port.host} --state-dir ${cfg.stateDir}";
        Restart = "always";
      };
    };
  };
}
