{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.hermes-gateway;

1. Construct the ExecStart string HERE, in the local scope where pkgs/inputs exist.
This prevents the "attribute pkgs missing" error during config evaluation.
  execStartCmd = "${inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/hermes-backend --port ${toString cfg.port.number} --host ${cfg.port.host} --state-dir ${cfg.stateDir}";

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
    # 2. Use config. to reach the top-level system options
    config.networking.firewall.allowedTCPPorts = [ cfg.port.number ];

    config.systemd.services.hermes-gateway = {
      description = "Hermes Desktop Gateway Backend";
      after = [ "hermes-agent.service" ];
      requires = [ "hermes-agent.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "hermes";
        Group = "hermes";
        # 3. Use the pre-constructed string
        ExecStart = execStartCmd;
        Restart = "always";
      };
    };
  };
}
