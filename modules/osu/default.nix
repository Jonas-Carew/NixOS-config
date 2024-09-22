{ pkgs, ... }: {
	programs = {
		fish.functions = {
			osu = {
				body = ''
					ssh caewj@flip1.engr.oregonstate.edu
				'';
			};
		};
	};
}
