{ pkgs, ... }: {
	programs.neovim = {

		enable = true;
		defaultEditor = true;
		extraPackages = with pkgs; [
			xclip
			tree-sitter
			ripgrep
		];

		plugins = with pkgs.vimPlugins; [
			adwaita-nvim					# colorscheme
			alpha-nvim						# greeter
			vim-gitgutter					# live git status
			telescope-nvim					# fuzzy finder
			neo-tree-nvim					# file tree
			vim-surround					# surround selections with pairs
			nvim-treesitter.withAllGrammars	# treesitter
			galaxyline-nvim					# status line

			nvim-lspconfig					# lsp config
		];
		
		extraConfig = ''
			lua << EOF
			${builtins.readFile ./config/options.lua}
			${builtins.readFile ./config/keymaps.lua}
			${builtins.readFile ./config/galaxyline-nvim.lua}
			${builtins.readFile ./config/treesitter.lua}
		'';
	};
}
