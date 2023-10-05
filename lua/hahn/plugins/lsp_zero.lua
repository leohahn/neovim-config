return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"zbirenbaum/copilot-cmp",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",

		-- Neodev for better vim lua completions
		"folke/neodev.nvim",

		-- We depend on telescope for keymaps as well
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neodev").setup()

		local lsp_zero = require("lsp-zero")
		local telescope_builtin = require("telescope.builtin")

		lsp_zero.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>cs", function()
				telescope_builtin.lsp_document_symbols()
			end, opts)
			vim.keymap.set("n", "<leader>cws", function()
				telescope_builtin.lsp_workspace_symbols()
			end, opts)
			vim.keymap.set("n", "<leader>cd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "gr", function()
				telescope_builtin.lsp_references()
			end, opts)
			vim.keymap.set("n", "<leader>cr", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "tsserver", "rust_analyzer", "pyright" },
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})

		-- lsp_zero.configure("sumneko_lua", {
		--     settings = {
		--         Lua = {
		--             workspace = {
		--                 checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
		--             },
		--         },
		--     },
		-- })
		--
		-- lsp_zero.configure("yamlls", {
		--     settings = {
		--         yaml = {
		--             keyOrdering = false
		--         }
		--     }
		-- })

		-- lsp_zero.setup()

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "copilot" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
			},
			formatting = lsp_zero.cmp_format(),
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			}),
		})
	end,
}
