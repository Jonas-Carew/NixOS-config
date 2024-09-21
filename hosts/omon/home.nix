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
			vscodium
			nodejs_20
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

		git = {
			enable = true;
			userName = "jonasc";
			userEmail = "jonasc@omonporch@nixos";
			extraConfig = {
				init.defaultBranch = "main";
			};
		};

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
				ga = {
					body = ''
						git add --all
						git commit -m $argv[1]
					'';
				};
				gp = {
					body = ''
						git push
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
				homdir = {
					body = ''
						z /etc/nixos/NixOS-config/hosts/omon
					'';
				};
			};
		};

		starship = {
			enable = true;
			settings = {
				add_newline = true;
				character = {
					success_symbol = "[λ[~>](bold green)](white)";
					error_symbol = "[λ[~>](bold red)](white)";
				};
				directory = {
					truncation_symbol = ".../";
				};
				status = {
					disabled = false;
					format = "[$symbol:$status ]($style)";
					symbol = "Err";
					not_executable_symbol = "not exe";
					not_found_symbol = "not found";
					sigint_symbol = "BREAK";
				};
				lua = {
					symbol = " ";
				};
				nix_shell = {
					format = "via [$symbol$state]($style) ";
					symbol = "󱄅 ";
				};
				zig = {
					symbol = " ";
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
