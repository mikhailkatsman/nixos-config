{ config, lib, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    networking.hostName = "nixos-thinkpad";

    boot.initrd.kernelModules = [ "nvidia" ];

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
            sync.enable = true;
            intelBusId  = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };
}
