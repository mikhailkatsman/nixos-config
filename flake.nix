{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, ... }: let
    mkSystem = host: extraModules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            (./hosts + "/${host}/hardware-configuration.nix")
            (./hosts + "/${host}")
            home-manager.nixosModules.home-manager
            {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.misha = import ./home.nix;
                    backupFileExtension = "backup";
                };
            }
        ] ++ extraModules;
    };
    in {
        nixosConfigurations = {
            nixos-thinkpad = mkSystem "thinkpad" [];
            nixos-framework = mkSystem "framework" [
                nixos-hardware.nixosModules.framework-amd-ai-300-series
            ];
        };
    };
}
