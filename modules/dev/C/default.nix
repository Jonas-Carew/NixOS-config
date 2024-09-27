{ pkgs, ... }: {
	home.packages = with pkgs; [
		gcc11
		cmake
		valgrind
	];
}
