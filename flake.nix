{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    mkSystem = host: nixpkgs.lib.nixosSystem {
        system = "x86_62-linux";
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
        ];
    };
    in {
        nixosConfigurations = {
            nixos-thinkpad = mkSystem "thinkpad";
        };
    };
}
