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
		/*Neve = {
			url = "github:redyf/Neve";
			inputs.nixpkgs.follows = "nixpkgs";
		};*/
	};

	#outputs = {self, nixpkgs}:
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
					./hosts/default/configuration.nix

					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.backupFileExtension = "hm-backup";
						home-manager.extraSpecialArgs = {
							#inherit Neve;
							username = "jonasc";
						};
						home-manager.users.jonasc = {
							imports = [ ./hosts/default/home.nix ];
						};
					}

					nix-index-database.nixosModules.nix-index
					{ programs.command-not-found.enable = false; }
				];
			};
		};
	};
}
