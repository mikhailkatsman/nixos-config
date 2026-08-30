{ config, lib, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    networking.hostName = "nixos-framework";

    hardware.graphics.enable = true;

    services.fwupd.enable = true;

    users.users.misha.initialPassword = "changeme";

    # Limit battery charge to 80% to reduce wear while mostly on AC
    systemd.services.battery-charge-limit = {
        description = "Set battery charge limit to 80%";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
        };
        script = ''
            for bat in /sys/class/power_supply/BAT*/charge_control_end_threshold; do
                [ -w "$bat" ] && echo 80 > "$bat"
            done
        '';
    };
}
