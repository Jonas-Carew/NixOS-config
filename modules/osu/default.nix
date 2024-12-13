{ pkgs, ... }: {

	imports = [
		(import ./cs290)
	];

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
			osuweb = {
				body = ''
					scp -r $argv carewj@flip1.engr.oregonstate.edu:~/public_html
				'';
			};
		};
	};
}
