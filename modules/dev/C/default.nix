{ pkgs, ... }: {
	home.packages = with pkgs; [
		gcc11
		gnumake
		valgrind
		gdb
	];
}
