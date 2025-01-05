{ pkgs, ... }: {
	home.packages = with pkgs; [
		python3Full
		jetbrains.pycharm-community
	];
}
