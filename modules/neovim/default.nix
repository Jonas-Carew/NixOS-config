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
		];
		
		extraConfig = ''
			:luafile /etc/nixos/NixOS-config/modules/neovim/config/init.lua
		'';
	};
}
