{ pkgs, ... }: {
	programs = {
		git = {
			enable = true;
			userName = "jonasc@nixos";
			userEmail = "carewj@oregonstate.edu";
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
