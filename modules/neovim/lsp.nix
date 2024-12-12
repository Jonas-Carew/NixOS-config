{ pkgs, ... }: {

	home.packages = with pkgs; [
		
		# nix
		nil

		#lua
		lua-language-server

	];

	programs.neovim.plugins = with pkgs.vimPlugins; [
			nvim-lspconfig					# lsp config
	];
}
