{ pkgs, ... }: {

	# add html lsp

	programs.neovim.plugins = with pkgs.vimPlugins; [
	];
}
