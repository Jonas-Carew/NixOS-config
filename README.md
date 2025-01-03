# My personal NixOS config that runs on all my computers and virtual machines

## Features

This flake has many features and bindings, many of which are documented on the wiki for my WSL-Nix-Basis repository

I plan to document all features and tweaks of this full flake on a wiki here, but I haven't done it yet.

## Making a new host

To make a new host one must follow these steps:

- Add a new host directory with the new host's `configuration.nix` and `hardware-configuration.nix` files.

- Create a new `home.nix` file for home-manager in the new host directory
		
	- If copy a `home.nix` file from another host, make sure to change the `config` and `rebuild` functions for fish to match the new host directory.

- Edit flake.nix and create a new output.
		
	- If you copy another output, change the path to `configuration.nix` and `home.nix` to match the new host directory.

- run `sudo nixos-rebuild switch --flake.#<new output>`
