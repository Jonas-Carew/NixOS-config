# home.nix

{ inputs, pkgs, lib, username, ... }: {

	imports = [
		# neovim with config
		(import ../../modules/neovim)

		# tmux with config
		(import ../../modules/tmux)

		# use FiraCode nerdfont w/ symbols
		(import ../../modules/firacode)

		# use cowsay and fortune for a 'say' command
		(import ../../modules/say-fortune)

		# starship prompt
		(import ../../modules/starship)

		# git with fish functions
		(import ../../modules/git)

		# pkgs for accessing osu servers
		(import ../../modules/osu)

		# dev package for C
		(import ../../modules/dev/C)

		# dev package for Markdown
		(import ../../modules/dev/Markdown)

		# dev package for Nix
		(import ../../modules/dev/Markdown)

		# wezterm with config
		# (import ../../modules/wezterm)
	];

	# Home manager config
	home = {
		stateVersion = "24.05";

		username = "${username}";
		homeDirectory = "/home/${username}";

		# Personal editor & shell
		sessionVariables.EDITOR = "nvim";
		sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";

		# overwriting default functions wasn't working in fish, so it's here
		shellAliases = {
			ls = "eza --icons";
			la = "eza -a --icons";
		};

		packages = with pkgs; [
			gum
			soft-serve
			glow
			unzip
			ripgrep
			flameshot
			discord
			krita
			onlyoffice-bin_latest
			cloc
			ncdu
			marktext
			/*
			swaylock
			swayidle
			wl-clipboard
			mako
			alacritty
			wofi
			waybar
			*/
		];
	};

	/*wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		config = {
			startup = [{
				command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK";
			}];
			terminal = "alacritty";
			menu = "wofi --show run";
			bars = [{
				fonts.size = 15.0;
				position = "bottom";
			}];
			output.eDP-1 = {
				scale = "1";
			};
		};
	};*/

	fonts.fontconfig.enable = true;

	# all built-in to home manager programs
	# also has their configs
	programs = {

		home-manager = { enable = true; };

		eza = { enable = true; };

		zoxide = { enable = true; };

		fzf = { enable = true; };

		#jq = { enable = true; };

		fish = {
			enable = true;
			interactiveShellInit = ''
				abbr --add nix-shell --command \"fish \&\& exit\; return\"
			'';
			functions = {
				x = {
					body = ''
						exit
					'';
				};
				lz = {
					body = ''
						eza -a -l -h --git --git-repos --no-user --total-size --icons
					'';
				};
				c = {
					body = ''
						clear
					'';
				};
				cl = {
					body = ''
						c
						ls
					'';
				};
				fetch = {
					body = ''
						/etc/nixos/NixOS-config/misc/fetches/diyfetch-omon
					'';
				};
				desk = {
					body = ''
						c
						z ~/Desktop/Desktop
						fetch
						ls
						'';
				};
				rebuild = {
					body = ''
						sudo nixos-rebuild switch --flake /etc/nixos/NixOS-config#omon
					'';
				};
				config = {
					body = ''
						nvim /etc/nixos/NixOS-config/hosts/omon/home.nix
					'';
				};
				condir = {
					body = ''
						z /etc/nixos/NixOS-config/
					'';
				};
				touchpad-settings = {
					body = ''
						kcmshell6 kcm_touchpad
					'';
				};
			};
		};	
	};
}
