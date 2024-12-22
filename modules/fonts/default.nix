{ pkgs, ... }: {
	home.packages = with pkgs; [
		fira-code
		nerd-fonts.fira-code
	];
}
