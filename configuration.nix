{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
		nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
        ndg = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +4";
	};
    ohMyZsh = {
        enable = true;
        plugins = [ "git" "docker" "sudo" "npm" "history" ];     
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.defaultUserShell = pkgs.zsh;

  users.users.misha = {
    isNormalUser = true;
    description = "Misha";
    extraGroups = [ "wheel" "networkmanager" "video" "mysql" ];
    packages = with pkgs; [ tree ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config.hyprland = {
            default = [ "hyprland" ];
            "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
    };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -c start-hyprland -r --user-menu --theme \"background=#282a36;text=#f8f8f2;prompt=#bd93f9;input=#f8f8f2;action=#ff79c6;button=#44475a\""
        ;user = "greeter";
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    vim
    yazi
    brightnessctl
    rofi
    vanilla-dmz
    php85
    php85Packages.composer
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" ];
    sansSerif = [ "Noto Sans" ];
    serif    = [ "Noto Serif" ];
  };

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

    environment.variables = {
        XCURSOR_THEME = "Vanilla-DMZ";
        XCURSOR_SIZE = "24";
        MOZ_ENABLE_WAYLAND = 1;
        MOZ_WAYLAND = 1;
    };


  system.stateVersion = "26.05";
}
