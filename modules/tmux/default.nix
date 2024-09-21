{ pkgs, ... }: {
	programs.tmux = {
		enable = true;
		extraConfig = ''
			# set command bind to Ctrl-a instead of Ctrl-b
			unbind C-b
			set-option -g prefix C-a
			bind-key C-a send-prefix

			# change window splitting keybinds
			bind | split-window -h -c "#{pane_current_path}"
			bind - split-window -v -c "#{pane_current_path)"
			unbind '"'
			unbind %

			# easier movement
			bind -n M-Left select-pane -L
			bind -n M-Right select-pane -R
			bind -n M-Up select-pane -U
			bind -n M-Down select-pane -D

			# enable mouse
			set -g mouse on
			# auto-renaming off
			set-option -g allow-rename off

			# index at 1
			set -g base-index 1
			set -g pane-base-index 1
			set-window-option -g pane-base-index 1
			set-option -g renumber-windows on

			# prefix highlighting
			set -g status-left '#{?client_prefix,#[reverse]<Prefix>#[noreverse] ,}[#S] '
		'';
		plugins = with pkgs.tmuxPlugins; [
			sensible
			resurrect
			gruvbox
		];
	};
}
