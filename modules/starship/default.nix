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
			c = {
				format = "with [$symbol($version(-$name) )]($style)";
				symbol = "C ";
			};
			lua = {
				format = "with [$symbol($version )]($style)";
				symbol = " ";
			};
			nix_shell = {
				format = "with [$symbol$state( \($name\))]($style) ";
				symbol = "󱄅~>";
			};
			zig = {
				format = "with [$symbol($version )]($style)";
				symbol = " ";
			};
			python = {
				format = "with [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
				symbol = " ";
			};
		};
	};
}
