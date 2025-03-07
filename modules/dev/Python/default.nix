{ pkgs, ... }: {
	home.packages = with pkgs; [
		(python3.withPackages (python-pkgs: with python-pkgs; [
			# lsp
			python-lsp-server

			# MTH 499 - Math of Data Science
			numpy
			scipy
			matplotlib
			torch
			torchvision
			torchaudio
			scikit-learn
			keras

			# Manim
			manim
		]))
	];
}
