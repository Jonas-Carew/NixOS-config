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
		nixos-wsl = {
			url = "github:nix-community/nixos-wsl";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zig.url = "github:mitchellh/zig-overlay#master";
	};

	outputs = inputs:
	with inputs; let

		system = "x86_64-linux";

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
			wsl = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/wsl/configuration.nix
					nixos-wsl.nixosModules.wsl
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.backupFileExtension = "hm-backup";
						home-manager.extraSpecialArgs = {
							username = "nixos";
						};
						home-manager.users.nixos = {
							imports = [ ./hosts/wsl/home.nix ];
						};
					}

					nix-index-database.nixosModules.nix-index
					{ programs.command-not-found.enable = false; }
				];
			};
		};
	};
}
