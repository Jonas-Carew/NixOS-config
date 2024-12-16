{ pkgs, ... }: {
	home.packages = with pkgs; [
		zig_0_12
	];
}
