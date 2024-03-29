return {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")
		-- local formatting = null_ls.builtins.formatting
		null_ls.setup({
			sources = {
				-- formatting.black.with({ extra_args = { "--fast" } }),
				-- formatting.prettierd,
				-- formatting.stylua,
				-- formatting.golines,
			},
		})

		vim.keymap.set("n", "<leader>bf", function()
			vim.cmd("Format")
			vim.lsp.buf.format()
			-- require("conform").format()
		end)
	end,
}
