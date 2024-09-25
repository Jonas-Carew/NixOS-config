{ pkgs, ... }: {
	home.packages = with pkgs; [
		vscodium
		nodejs_20
	];
	programs = {
		fish.functions = {
			cs290 = {
				body = ''
					z ~/Desktop/Desktop/School-Work/F2/CS290
				'';
			};
		};
	};
}
