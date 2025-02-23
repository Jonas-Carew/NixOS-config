# home.nix

{ pkgs, username, ... }: 
let

	tex = (pkgs.texlive.combine {
		inherit (pkgs.texlive) scheme-medium
		pgfplots
	;});

in {

	imports = [
		# neovim with config
		(import ../../modules/neovim)

		# tmux with config
		(import ../../modules/tmux)

		# import all fonts
		(import ../../modules/fonts)

		# use cowsay and fortune for a 'say' command
		(import ../../modules/say-fortune)

		# starship prompt
		(import ../../modules/starship)

		# git with fish functions
		(import ../../modules/git)

		# pkgs for accessing osu servers
		# and for all classes
		(import ../../modules/osu)

		# dev package for C
		(import ../../modules/dev/C)

		# dev package for Zig
		(import ../../modules/dev/Zig)

		# dev package for Python
		(import ../../modules/dev/Python)

		# wezterm with config
		# (import ../../modules/wezterm)
	];

	# Home manager config
	home = {
		# version
		stateVersion = "24.05";

		# sey username and home
		username = "${username}";
		homeDirectory = "/home/${username}";

		# Personal editor & shell
		sessionVariables.EDITOR = "nvim";
		sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";

		# overwriting default functions wasn't working in fish, so it's here
		shellAliases = {
			# better ls
			ls = "eza --icons";
			# better la
			la = "eza -a --icons";
		};

		packages = with pkgs; [
			# charm packages
			gum # stick things together - used in fetch
			soft-serve # manage git repos
			glow # read markdown
			vhs # cli gifs

			# dependencies
			# texmaker
			tex # tex library

			# general CLI utilities
			unzip # unzip things
			ripgrep # grep!
			cloc # count lines of code
			ncdu # file size viewer
			bottom # task manager

			# general desktop utilities
			flameshot # screenshot tool
			kdePackages.kolourpaint # paint replacement

			# larger desktop programs
			krita # larger drawing program
			onlyoffice-bin_latest # office replacement
			marktext # markdown editor
			kdenlive # video editor
			vlc # video viewer
			texmaker # tex editor
			octave # better than matlab
			heroic # game launcher

			# desktop programs for fun
			steam # steam
			discord-canary # discord nightly so streaming works on wayland
		];
	};

	# enable fonts
	fonts.fontconfig.enable = true;

	# all built-in to home manager programs
	# also has their configs
	programs = {

		#home-manager itself
		home-manager = { enable = true; };

		# general CLI utilities
		zoxide = { enable = true; };
		fzf = { enable = true; };
		eza = {
			enable = true;
			icons = "auto";
		};

		# wezterm (WIP)
		/*
		wezterm = {
			enable = true;
			package = pkgs.wezterm-nightly;
			extraConfig = ''
				local wezterm = require 'wezterm'
				local config = wezterm.config_builder()
				
				config.front_end = "WebGpu"
				enable_wayland = false

				return config
			'';
		};
		*/

		# fish
		fish = {
			enable = true;
			# enable my nix-shell abbreviation
			interactiveShellInit = ''
				abbr --add nix-shell nix-shell --command \"fish \&\& exit\; return\"
			'';
			# fish fucntions
			functions = {
				# short exit
				x = {
					body = ''
						exit
					'';
				};
				# short clear
				c = {
					body = ''
						clear
					'';
				};
				# short ncdu (I'm not remembering that)
				size = {
					body = ''
						ncdu
					'';
				};
				# better la
				lz = {
					body = ''
						eza -a -l -h --git --git-repos --no-user --total-size --icons
					'';
				};
				# short screen refresh
				cl = {
					body = ''
						c
						ls
					'';
				};
				# run the system diy-fetch
				fetch = {
					body = ''
						/etc/nixos/NixOS-config/misc/fetches/diyfetch-omon
					'';
				};
				# navigate to desktop w/ niceties
				desk = {
					body = ''
						c
						z ~/Desktop/Desktop
						fetch
						ls
						'';
				};
				# rebuild NixOS
				rebuild = {
					body = ''
						sudo nixos-rebuild switch --flake /etc/nixos/NixOS-config#omon
					'';
				};
				# access home-manager config for current system
				config = {
					body = ''
						nvim /etc/nixos/NixOS-config/hosts/omon/home.nix
					'';
				};
				# access flake directroy
				condir = {
					body = ''
						z /etc/nixos/NixOS-config/
					'';
				};
				# touchpad settings for a laptop via the KDE settings
				touchpad-settings = {
					body = ''
						kcmshell6 kcm_touchpad
					'';
				};
			};
		};	
	};
}
