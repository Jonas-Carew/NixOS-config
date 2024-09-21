{ pkgs, ... }: {
	home.packages = with pkgs; [
		vscodium
		nodejs_20
	];
}
