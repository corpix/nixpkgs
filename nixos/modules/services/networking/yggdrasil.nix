{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.yggdrasil;
  settingsProvided = cfg.settings != { };
  configFileProvided = cfg.configFile != null;

  format = pkgs.formats.json { };
  keysPath = "${cfg.dataDir}/keys.json";
in {
  imports = [
    (mkRenamedOptionModule
      [ "services" "yggdrasil" "config" ]
      [ "services" "yggdrasil" "settings" ])
  ];

  options = with types; {
    services.yggdrasil = {
      enable = mkEnableOption (lib.mdDoc "the yggdrasil system service");

      dataDir = mkOption {
        description = lib.mdDoc "Yggdrasil data directory";
        type = path;
        default = "/var/lib/yggdrasil";
      };

      settings = mkOption {
        type = format.type;
        default = { };
        example = {
          Peers = [
            "tcp://aa.bb.cc.dd:eeeee"
            "tcp://[aaaa:bbbb:cccc:dddd::eeee]:fffff"
          ];
          Listen = [
            "tcp://0.0.0.0:xxxxx"
          ];
        };
        description = lib.mdDoc ''
          Configuration for yggdrasil, as a Nix attribute set.

          Warning: this is stored in the WORLD-READABLE Nix store!
          Therefore, it is not appropriate for private keys. If you
          wish to specify the keys, use {option}`configFile`.

          If the {option}`persistentKeys` is enabled then the
          keys that are generated during activation will override
          those in {option}`settings` or
          {option}`configFile`.

          If no keys are specified then ephemeral keys are generated
          and the Yggdrasil interface will have a random IPv6 address
          each time the service is started. This is the default.

          If both {option}`configFile` and {option}`settings`
          are supplied, they will be combined, with values from
          {option}`configFile` taking precedence.

          You can use the command `nix-shell -p yggdrasil --run "yggdrasil -genconf"`
          to generate default configuration values with documentation.
        '';
      };

      configFile = mkOption {
        type = nullOr path;
        default = null;
        example = "/run/keys/yggdrasil.conf";
        description = lib.mdDoc ''
          A file which contains JSON or HJSON configuration for yggdrasil. See
          the {option}`settings` option for more information.

          Note: This file must not be larger than 1 MB because it is passed to
          the yggdrasil process via systemd‘s LoadCredential mechanism. For
          details, see <https://systemd.io/CREDENTIALS/> and `man 5
          systemd.exec`.
        '';
      };

      user = mkOption {
        type = types.nullOr types.str;
        default = "yggdrasil";
        example = "ygg";
        description = lib.mdDoc "User to run yggdrasil service from.";
      };

      group = mkOption {
        type = types.str;
        default = "yggdrasil";
        example = "wheel";
        description = lib.mdDoc "Group to grant access to the Yggdrasil control socket.";
      };

      openMulticastPort = mkOption {
        type = bool;
        default = false;
        description = lib.mdDoc ''
          Whether to open the UDP port used for multicast peer discovery. The
          NixOS firewall blocks link-local communication, so in order to make
          incoming local peering work you will also need to configure
          `MulticastInterfaces` in your Yggdrasil configuration
          ({option}`settings` or {option}`configFile`). You will then have to
          add the ports that you configure there to your firewall configuration
          ({option}`networking.firewall.allowedTCPPorts` or
          {option}`networking.firewall.interfaces.<name>.allowedTCPPorts`).
        '';
      };

      denyDhcpcdInterfaces = mkOption {
        type = listOf str;
        default = [ ];
        example = [ "tap*" ];
        description = lib.mdDoc ''
          Disable the DHCP client for any interface whose name matches
          any of the shell glob patterns in this list.  Use this
          option to prevent the DHCP client from broadcasting requests
          on the yggdrasil network.  It is only necessary to do so
          when yggdrasil is running in TAP mode, because TUN
          interfaces do not support broadcasting.
        '';
      };

      package = mkOption {
        type = package;
        default = pkgs.yggdrasil;
        defaultText = literalExpression "pkgs.yggdrasil";
        description = lib.mdDoc "Yggdrasil package to use.";
      };

      persistentKeys = mkEnableOption (lib.mdDoc ''
        If enabled then keys will be generated once and Yggdrasil
        will retain the same IPv6 address when the service is
        restarted.
      '');
    };
  };

  config = mkIf cfg.enable (
    let
      binYggdrasil = "${cfg.package}/bin/yggdrasil";
      binHjson = "${pkgs.hjson-go}/bin/hjson-cli";
    in
    {
      assertions = [{
        assertion = config.networking.enableIPv6;
        message = "networking.enableIPv6 must be true for yggdrasil to work";
      }];

    system.activationScripts.yggdrasil = mkIf cfg.persistentKeys ''
      if [ ! -e ${keysPath} ]
      then
        mkdir --mode=700 -p ${builtins.dirOf keysPath}
        ${binYggdrasil} -genconf -json \
          | ${pkgs.jq}/bin/jq \
              'to_entries|map(select(.key|endswith("Key")))|from_entries' \
          > ${keysPath}
        chown -R yggdrasil ${builtins.dirOf keysPath}
      fi
    '';

    systemd.services.yggdrasil = {
      description = "Yggdrasil Network Service";
      after = [ "network-pre.target" ];
      wants = [ "network.target" ];
      before = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart =
        (if settingsProvided || configFileProvided || cfg.persistentKeys
         then concatStringsSep "\n" [
           "set -o pipefail"
           "{"
           "echo ${optionalString settingsProvided "'${builtins.toJSON cfg.settings}'"}"
           (optionalString configFileProvided "cat ${cfg.configFile}")
           (optionalString cfg.persistentKeys "cat ${keysPath}")
           "} | ${pkgs.jq}/bin/jq -s add | ${binYggdrasil} -normaliseconf -useconf"
         ]
         else "${binYggdrasil} -genconf") + " > /run/yggdrasil/yggdrasil.conf";

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        StateDirectory = "yggdrasil";
        RuntimeDirectory = "yggdrasil";
        RuntimeDirectoryMode = "0750";
        ReadOnlyPaths = lib.optional configFileProvided cfg.configFile ++ lib.optional cfg.persistentKeys keysPath;
        ReadWritePaths = "/run/yggdrasil";

        ExecStart = "${binYggdrasil} -useconffile /run/yggdrasil/yggdrasil.conf";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        Restart = "always";

        AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
        CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
        MemoryDenyWriteExecute = true;
        ProtectControlGroups = true;
        ProtectHome = "tmpfs";
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "@system-service" "~@privileged @keyring" ];
      };
    };

      networking.dhcpcd.denyInterfaces = cfg.denyDhcpcdInterfaces;
      networking.firewall.allowedUDPPorts = mkIf cfg.openMulticastPort [ 9001 ];

      users.groups.${cfg.group} = {};
      users.users.${cfg.user} = {
        description = "Yggdrasil daemon user";
        home = cfg.dataDir;
        createHome = true;
        isSystemUser = true;
        group = cfg.group;
      };

      # Make yggdrasilctl available on the command line.
      environment.systemPackages = [ cfg.package ];
    }
  );
  meta = {
    doc = ./yggdrasil.md;
    maintainers = with lib.maintainers; [ gazally ehmry ];
  };
}
