return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"bash",
				"javascript",
				"json",
				"lua",
				"c",
				"vim",
				"vimdoc",
				"query",
				"typescript",
				"tsx",
				"css",
				"scss",
				"html",
				"markdown",
				"markdown_inline",
				"gitignore",
			}, -- one of "all" or a list of languages
			highlight = {
				enable = true, -- false will disable the whole extension
				additional_vim_regex_highlighing = false,
				-- disable = { "css" }, -- list of language that will be disabled
			},
			-- autopairs = {
			-- 	enable = true,
			-- },
			autotag = {
				enable = true,
			},
			indent = { enable = true, disable = { "python" } },
			-- rainbow = {
			-- 	enable = true,
			-- 	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			-- 	extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			-- 	max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- 	-- colors = {}, -- table of hex strings
			-- 	-- termcolors = {} -- table of colour name strings
			-- },
			autoinstall = true,
		})
	end,
}
