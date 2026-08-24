{ config, lib, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    networking.hostName = "nixos-framework";

    hardware.graphics.enable = true;

    services.fwupd.enable = true;

    users.users.misha.initialPassword = "changeme";
}
