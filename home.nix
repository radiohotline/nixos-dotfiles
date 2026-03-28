{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
  };
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "troy";
  home.homeDirectory = "/home/troy";

  #imports = [
  #  ./modules/suckless.nix
  #];

  # configs
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    
    # editors
    vscodium
    edwood

    # wm
    # dwm
    #dwmbar
    #prio
    #wio
    #larswm

    # wm util
    #dwmblocks
    #dunst

    # wayland
    #wlroots
    #cage

    # shell + terminal
    #rc

    # utility
    plan9port
    #xxkb
    #gxkb
    #conky
    #calc
    #flameshot

    # network
    protonvpn-gui
    #spoofdpi
    #zapret
    #qbittorrent

    # browser
    w3m
    #qutebrowser
    # surf

    # design
    #kicad
    #krita
    #freecad
    #ngspice

    # documents
    zathura
    libreoffice
    #wordgrinder
    #sc
    logseq

    # audio/video
    #rmpc
    #mpc
    strawberry
    #vlc
    #mpv
    #ffmpeg
    #pavucontrol
    #jellytui
    #jellyfin-tui
	finamp
	jellyfin-desktop

    # files
    #lf
    #gparted
    #syncthing
    #xarchiver
    #unzip
    #unrar

    # graphics
    #gimp
    feh
    nsxiv
    #imagemagick

    # fun
    catclock
    cowsay
    fortune
    #godot
    fastfetch

    # misc
    #qemu
    vesktop
    signal-desktop
    #signal-cli
    #praat

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/troy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # graphics
  xsession.enable = true;

  # programs
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.cmus.enable = true;

  # services
  # mpd
  services.mpd = {
	enable = false;
	musicDirectory = "/home/troy/Music";
	extraConfig = ''
		audio_output {
		  type	"pipewire"
		  name	"PipeWire output"
		}
	'';
  };

  services.mpd-discord-rpc = {
	enable = false;
  };

  # ssh
  programs.ssh = {
    enable = true;
    extraConfig = "
      Host freebsd
        Hostname softmachine.dev
        Port 50000
        User freebsd
        IdentityFile ~/.ssh/freebsd
      
      Host *
        IdentityFile ~/.ssh/github
	
	  Host inspiron
	    Hostname 192.168.1.45
		Port 42069
		User troy
		IdentityFile ~/.ssh/inspiron
    ";
  };
}
