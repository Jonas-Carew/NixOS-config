{ inputs, pkgs, lib, username, Neve, ... }:
let
	vimFromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
		pname = "${lib.strings.sanitizeDerivationName repo}";
		version = ref;
		src = builtins.fetchGit {
			url = "https://github.com/${repo}.git";
			ref = ref;
			rev = rev;
		};
	};
in {

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
		
		packages = [
			pkgs.xclip
			pkgs.gum
			pkgs.neo-cowsay
			pkgs.fortune-kind
			pkgs.soft-serve
			pkgs.glow
			pkgs.unzip
			pkgs.tree-sitter
			pkgs.fsearch
			Neve.packages.${pkgs.system}.default
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

		neovim = {
			enable = true;
			defaultEditor = true;
			extraPackages = with pkgs; [
				xclip
			];
			extraLuaConfig = ''
				vim.cmd("colorscheme default")
				vim.cmd("command Tab2 %s/  /\t/g")
				local o = vim.opt
				o.number = true
				o.relativenumber = true
				o.mouse = 'a'
				o.tabstop = 4
				o.shiftwidth = 4
				o.smartindent = true
				o.clipboard = 'unnamedplus'
				o.undofile = true
				o.list = true
				o.colorcolumn = "81"
				vim.opt.listchars = {
					tab = '  ',
					multispace = '··',
					extends = '⟩',
					precedes = '⟨',
					trail = '·'
				}
			'';
			plugins = with pkgs.vimPlugins; [
				#adwaita
				#(vimFromGitHub "453167dc346f39e51141df4fe7b17272f4833c2b" "master" "fneu/breezy")
			];
		};

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
			'';
			plugins = with pkgs.tmuxPlugins; [
				sensible
				resurrect
				prefix-highlight
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
						~/diyfetch
					'';
				};
				desk = {
					body = ''
						c
						z ~/desktop
						fetch
						ls
						'';
				};
				rebuild = {
					body = ''
						sudo nixos-rebuild switch
					'';
				};
				config = {
					body = ''
						sudoedit /etc/nixos/home.nix
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
