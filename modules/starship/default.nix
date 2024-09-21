{ pkgs, ... }: {
	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			character = {
				success_symbol = "[λ[~>](bold green)](white)";
				error_symbol = "[λ[~>](bold red)](white)";
			};
			directory = {
				truncation_symbol = ".../";
			};
			status = {
				disabled = false;
				format = "[$symbol:$status ]($style)";
				symbol = "Err";
				not_executable_symbol = "not exe";
				not_found_symbol = "not found";
				sigint_symbol = "BREAK";
			};
			lua = {
				symbol = " ";
			};
			nix_shell = {
				format = "via [$symbol$state]($style) ";
				symbol = "󱄅 ";
			};
			zig = {
				symbol = " ";
			};
		};
	};
}
