# flake.nix

{
	description = "System flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
	with inputs; let

		system = "x86_64-linux";

		pkgs = import nixpkgs{
			inherit system;
			config.allowUnfree = true;
		};

		lib = nixpkgs.lib;

	in {
		nixosConfigurations = {
			vm = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/vm/configuration.nix

					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.backupFileExtension = "hm-backup";
						home-manager.extraSpecialArgs = {
							username = "jonasc";
						};
						home-manager.users.jonasc = {
							imports = [ ./hosts/vm/home.nix ];
						};
					}

					nix-index-database.nixosModules.nix-index
					{ programs.command-not-found.enable = false; }
				];
			};
			omon = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/omon/configuration.nix

					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.backupFileExtension = "hm-backup";
						home-manager.extraSpecialArgs = {
							username = "jonasc";
						};
						home-manager.users.jonasc = {
							imports = [ ./hosts/omon/home.nix ];
						};
					}

					nix-index-database.nixosModules.nix-index
					{ programs.command-not-found.enable = false; }
				];
			};
		};
	};
}
