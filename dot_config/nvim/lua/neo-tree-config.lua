require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file_enabled = true,
	},
})
