return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = false,
				diagnostics_update_in_insert = false,
				color_icons = true,
				show_buffer_icons = true,
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = false,
						padding = 1,
					},
				},
			},

			highlights = {
				separator = {
					guifg = "#073642",
					guibg = "#002b36",
				},
				separator_selected = {
					guifg = "#073642",
				},
				background = {
					guifg = "#657b83",
					guibg = "#002b36",
				},
				buffer_selected = {
					guifg = "#fdf6e3",
					gui = "bold",
				},
				fill = {
					guibg = "#073642",
				},
			},
		})
	end,
}
