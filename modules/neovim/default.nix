{ pkgs, ... }: {
	programs.neovim = {
		plugins = with pkgs; [
			vimPlugins.adwaita-nvim
		];
	};
}
