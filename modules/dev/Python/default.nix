{ pkgs, ... }: {
	home.packages = with pkgs; [
		(python3.withPackages (python-pkgs: with python-pkgs; [
			# MTH 499 - Math of Data Science
			numpy
			scipy
			matplotlib
			torch
			torchvision
			torchaudio

			# Manim
			manim
		]))
	];
}
