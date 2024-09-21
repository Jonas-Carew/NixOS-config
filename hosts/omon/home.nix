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

		# pkgs for cs290 - web dev
		(import ../../modules/cs290)
	];

	# Home manager config
	home = {
		stateVersion = "24.05";

		username = "${username}";
		homeDirectory = "/home/jonasc";

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
			fsearch
			ripgrep
			flameshot
			discord
		];
	};

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

		wezterm = {
			enable = true;
			extraConfig = ''
			'';
		};
	};
}
