{ pkgs, ... }: {

	home.packages = with pkgs; [
		
		# nix
		nil
		# lua
		lua-language-server
		# C / C++
		ccls

	];

	programs.neovim = {
		
		extraLuaConfig = ''
			require('lspconfig').nil_ls.setup({})
			require('lspconfig').ccls.setup({})
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = {'vim'},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		'';

		plugins = with pkgs.vimPlugins; [
			# lsp config
			nvim-lspconfig
			# completion
			nvim-cmp
			cmp-nvim-lsp
		];
		
	};
}
