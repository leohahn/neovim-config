return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		local indent = require("ibl")

		indent.setup({
			exclude = {
				filetypes = {
					"lspinfo",
					"packer",
					"checkhealth",
					"help",
					"man",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
					"",
					"startify",
					"dashboard",
					"neogitstatus",
					"NvimTree",
					"neo-tree",
					"Trouble",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
			indent = {
				char = { "│" },
			},
			scope = {
				enabled = false,
			},
		})
	end,
}
