{ pkgs, ... }: {

	home.packages = with pkgs; [
		
		# Nix
		nixd
		# C / C++
		ccls
		# markdown
		marksman
		# Lua
		lua-language-server
		# Zig
		zls

		#html, css, json, eslint
		# vscode-langservers-extracted

	];

	programs.neovim = {
		
		extraLuaConfig = ''
			require('lspconfig').nixd.setup({})
			require('lspconfig').ccls.setup({})
			require('lspconfig').marksman.setup({})
			require('lspconfig').zls.setup({})
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
			# require('lspconfig').html.setup({})
			# require('lspconfig').cssls.setup({})
			# require('lspconfig').eslint.setup({})
		plugins = with pkgs.vimPlugins; [
			# lsp config
			nvim-lspconfig
		];
		
	};
}
