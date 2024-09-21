{ pkgs, ... }: {
	home.packages = with pkgs; [
		neo-cowsay
		fortune-kind
	];
	programs.fish.functions = {
		say = {
			body = ''
				fortune-kind | cowsay --random
			'';
		};
	};
}
