{ pkgs, ... }: {

	imports = [
		(import ../../dev/C)
	];

	programs = {
		fish.functions = {
			cs261 = {
				body = ''
					z ~/Desktop/Desktop/School-Work/F2/CS261
				'';
			};
		};
	};
}
