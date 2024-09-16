{ inputs, pkgs, lib, username, ... }: {

	imports = [
		(import ../../modules/neovim)
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
			neo-cowsay
			fortune-kind
			soft-serve
			glow
			unzip
			fsearch
			ripgrep
		];
	};

	# all built-in to home manager programs
	# also has their configs
	programs = {

		home-manager = { enable = true; };

		eza = { enable = true; };

		zoxide = { enable = true; };

		fzf = { enable = true; };

		jq = { enable = true; };

		tmux = {
			enable = true;
			extraConfig = ''
				# set command bind to Ctrl-a instead of Ctrl-b
				unbind C-b
				set-option -g prefix C-a
				bind-key C-a send-prefix

				# change window splitting keybinds
				bind | split-window -h -c "#{pane_current_path}"
				bind - split-window -v -c "#{pane_current_path)"
				unbind '"'
				unbind %

				# easier movement
				bind -n M-Left select-pane -L
				bind -n M-Right select-pane -R
				bind -n M-Up select-pane -U
				bind -n M-Down select-pane -D

				# enable mouse
				set -g mouse on
				# auto-renaming off
				set-option -g allow-rename off

				# index at 1
				set -g base-index 1
				set -g pane-base-index 1
				set-window-option -g pane-base-index 1
				set-option -g renumber-windows on

				# prefix highlighting
				set -g status-left '#{?client_prefix,#[reverse]<Prefix>#[noreverse] ,}[#S] '
			'';
			plugins = with pkgs.tmuxPlugins; [
				sensible
				resurrect
				gruvbox
			];
		};

		git = {
			enable = true;
			userName = "jonasc";
			userEmail = "jonasc@nixos";
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
						/etc/nixos/NixOS-config/misc/fetches/diyfetch-vm
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
						sudo nixos-rebuild switch --flake /etc/nixos/NixOS-config#vm
					'';
				};
				config = {
					body = ''
						nvim /etc/nixos/NixOS-config/hosts/vm/home.nix
					'';
				};
				condir = {
					body = ''
						z /etc/nixos/NixOS-config/
					'';
				};
				/*dev = {
					body = ''
						switch $argv[1]
							case 'vhs'
								nix develop ~/flakes/vhs
							case 'zig'
								nix develop ~/flakes/zig
							case '*'
								echo unknown environment
						end
					'';
				};*/
				say = {
					body = ''
						fortune-kind | cowsay --random
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

	};
}
