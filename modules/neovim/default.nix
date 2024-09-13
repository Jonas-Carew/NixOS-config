{ pkgs, ... }: {
	programs.neovim = {
		plugins = with pkgs; [
			vimPlugins.adwaita-nvim
			vimPlugins.alpha-nvim
			vimPlugins.vim-gitgutter
			vimPlugins.telescope-nvim
			vimPlugins.neo-tree-nvim
			vimPlugins.vim-surround
			#vimPlugins.vim-airline test different line
		];
	};
}
