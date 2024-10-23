{ pkgs, ... }: {

	# add CSS lsp

	programs.neovim.plugins = with pkgs.vimPlugins; [
	];
}
