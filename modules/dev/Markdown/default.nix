{ pkgs, ... }: {
	programs.neovim.plugins = with pkgs.vimPlugins; [
		glow-nvim
	];
}
