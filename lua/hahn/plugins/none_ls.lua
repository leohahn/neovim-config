return {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			sources = {
				formatting.ocamlformat,
				-- formatting.mix,
				diagnostics.credo,
			},
		})

		vim.keymap.set("n", "<leader>bf", function()
			vim.cmd("Format")
			-- vim.lsp.buf.format()
			-- require("conform").format()
		end)
	end,
}
