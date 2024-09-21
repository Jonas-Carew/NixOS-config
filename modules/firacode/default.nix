{ pkgs, ... }: {
	home.packages = with pkgs; [
		fira-code
		nerdfonts
	];
}
