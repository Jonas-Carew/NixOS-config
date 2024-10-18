{ pkgs, ... }: {
	imports = [ (import ../../neovim) ];

	programs.neovim.plugins = with pkgs.vimPlugins; [
		glow.nvim
	];
}
