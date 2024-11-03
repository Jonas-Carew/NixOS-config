# My personal NixOS config that runs on all my computers and virtual machines

To make a new host one must follow these steps:

- Add a new host directory with the new host's `configuration.nix` and `hardware-configuration.nix` files.

- Create a new `home.nix` file for home-manager
		
	- You can copy 

- Edit flake.nix and create a new output.
		
	- If you copy another output, change the path to `configuration.nix` and `home.nix` to match the new host directory.


