return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- arrow colors
		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#FFD700 ]])

		-- local tree_cb = nvim_tree_config.nvim_tree_callback

		local nvimtree = require("nvim-tree")
		nvimtree.setup({
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			filters = { custom = { "^.git$" }, exclude = { ".env" } },
			hijack_cursor = true,
			view = {
				width = 40,
			},
			renderer = {
				full_name = true,
				indent_markers = { enable = true },
				indent_width = 2,
				-- root_folder_label = true,
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_open = "󰦺", -- arrow when folder is open
							arrow_closed = "󱞶", -- arrow when folder is closed
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "💡",
					info = "",
					warning = "",
					error = "",
				},
			},
			actions = {
				open_file = {
					quit_on_open = false,
				},
			},
		})
	end,
}
