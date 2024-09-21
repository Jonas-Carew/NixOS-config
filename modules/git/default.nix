{ pkgs, ... }: {
	programs = {
		git = {
			enable = true;
			userName = "jonasc";
			userEmail = "jonasc@omonporch@nixos";
			extraConfig = {
				init.defaultBranch = "main";
			};
		};
		fish.functions = {
			ga = {
				body = ''
					git add -A
					git commit -m $argv[1]
				'';
			};
			gp = {
				body = ''
					git push
				'';
			};
			gf = {
				body = ''
					git commit --amend
				'';
			};
		};
	};
}
