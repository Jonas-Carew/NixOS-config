{ pkgs, ... }: {
	programs = {
		fish.functions = {
			zig_start = {
				body = ''
					nix shell 'github:mitchellh/zig-overlay#master'
				'';
			};
		};
	};
}
