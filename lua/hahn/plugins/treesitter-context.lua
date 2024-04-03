return {
	"nvim-treesitter/nvim-treesitter-context",
	enabled = true,
	config = function()
		local treesitter_context = require("treesitter-context")
		treesitter_context.setup({
			max_lines = 2,
			separator = nil,
			trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		})
	end,
}
