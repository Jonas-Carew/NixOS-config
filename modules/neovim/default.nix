{ pkgs, ... }: {

	imports = [
		(import ./lsp.nix)
	];

	programs.neovim = {

		enable = true;
		defaultEditor = true;
		extraPackages = with pkgs; [
			xclip
			tree-sitter
			ripgrep
		];

		viAlias = true;
		vimAlias = true;

		plugins = with pkgs.vimPlugins; [
			adwaita-nvim					# colorscheme
			
			vim-gitgutter					# live git status
			nvim-treesitter.withAllGrammars	# treesitter
			galaxyline-nvim					# status line
			nvim-web-devicons				# missing galaxyline icons

			telescope-nvim					# fuzzy finder
			neo-tree-nvim					# file tree
			
			vim-surround					# surround selections with pairs

			# alpha-nvim					# greeter
		];
		
		# read configs
		extraLuaConfig = ''
			${builtins.readFile ./config/options.lua}
			${builtins.readFile ./config/keymaps.lua}
			${builtins.readFile ./config/galaxyline-nvim.lua}
			${builtins.readFile ./config/treesitter.lua}
		'';
	};
}
