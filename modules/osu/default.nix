{ pkgs, ... }: {
	programs = {
		fish.functions = {
			osu = {
				body = ''
					ssh carewj@flip1.engr.oregonstate.edu
				'';
			};
			osutransfer = {
				body = ''
					scp $argv carewj@flip1.engr.oregonstate.edu:~/transfer
				'';
			};
		};
	};
}
