{ pkgs, ... }: {
	home.packages = with pkgs; [
		(python3.withPackages (python-pkgs: with python-pkgs; [
			numpy
			scipy
			matplotlib
			torch
			torchvision
			torchaudio
		]))
		jetbrains.pycharm-community-bin
	];
}
