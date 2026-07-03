# /etc/nixos/home.nix
{ config, pkgs, ... }:

{
    home.username = "misha";
    home.homeDirectory = "/home/misha";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [
        foot
        hyprpaper
        fastfetch
        grim
        slurp
        wl-clipboard
        opencode
    ];

    programs.bash = {
		enable = true;
	};

    programs.ssh = {
        enable = true;
        settings = {
            "Host github.com" = {
                HostName = "github.com";
                User = "git";
                IdentityFile = "~/.ssh/github";
            };
        };
    };

	programs.git = {
		enable = true;
        settings = {
		    user =  {
                name = "mikhailkatsman";
		        email = "kry3er@gmail.com";
            };
        };
	};

    programs.firefox = {
        enable = true;
        profiles.misha = {
            settings = {
                "widget.use-xdg-desktop-portal.file-picker" = 1;
                "media.ffmpeg.vaapi.enabled" = true;
                "media.hardware-video-decoding.enabled" = true;
                "gfx.webrender.all" = true;
                "datareporting.healthreport.uploadEnabled" = false;
                "datareporting.policy.dataSubmissionEnabled" = false;
                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.unified" = false;
                "app.shield.optoutstudies.enabled" = false;
                "app.normandy.enabled" = false;
                "extensions.pocket.enabled" = false;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.newtabpage.activity-stream.feeds" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            };
        };
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;

        plugins = with pkgs.vimPlugins; [
            #Colorscheme
            dracula-nvim

            # Completion
            nvim-cmp
            cmp-nvim-lsp
            cmp-buffer
            cmp-path

            # Nvim tree
            nvim-tree-lua
            nvim-web-devicons

            # Treesitter
            nvim-treesitter.withAllGrammars

            # Convenience
            nvim-autopairs

            # Fuzzy Finder
            nvim-fzf
            fzf-lua

        ];

        extraPackages = with pkgs; [
            # Language servers
            nixd
            lua-language-server
            fd
            ripgrep
            fzf
            phpactor
        ];
    };

    programs.waybar.enable = true;

	xdg.configFile."hypr".source = ./config/hypr;
  	xdg.configFile."opencode/opencode.jsonc".source = ./config/opencode/opencode.jsonc;
  	xdg.configFile."opencode/tui.json".source = ./config/opencode/tui.json;
  	xdg.configFile."foot".source = ./config/foot;
    xdg.configFile."nvim".source = ./config/nvim;
  	xdg.configFile."yazi".source = ./config/yazi;
  	xdg.configFile."waybar".source = ./config/waybar;
  	xdg.configFile."rofi".source = ./config/rofi;

    # enable Yazi as file picker
    xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=yazi-wrapper.sh
        create_help_file=0
        default_dir=$HOME
        env=TERMCMD="${pkgs.foot}/bin/foot"
        PATH=${pkgs.yazi}/bin:${pkgs.foot}/bin
        open_mode=suggested
        save_mode=last
    '';

    # Create folder for screenshots
    home.file."Pictures/Screenshots/.keep".text = "";

  	programs.home-manager.enable = true;
}
