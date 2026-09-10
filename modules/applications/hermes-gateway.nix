{ lib, ... }:

{
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
}
