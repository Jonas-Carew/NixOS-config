{ pkgs, ... }: {
	programs.neovim = {

		enable = true;
		defaultEditor = true;
		extraPackages = with pkgs; [
			xclip
		];

		plugins = with pkgs.vimPlugins; [
			adwaita-nvim
			alpha-nvim
			vim-gitgutter
			telescope-nvim
			neo-tree-nvim
			vim-surround
			#vim-airline test different line
		];
		
		extraConfig = ''
			lua << EOF
			${builtins.readFile ./config/options.lua}
			${builtins.readFile ./config/keymaps.lua}
		'';
	};
}
