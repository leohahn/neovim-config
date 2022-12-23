return {
    "VonHeikemen/lsp-zero.nvim",
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

        local lsp = require("lsp-zero")

        lsp.set_preferences({
          suggest_lsp_servers = true,
          setup_servers_on_start = true,
          set_lsp_keymaps = false,
          configure_diagnostics = true,
          cmp_capabilities = true,
          manage_nvim_cmp = true,
          call_servers = 'local',
          sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
          }
        })

        lsp.on_attach(function(client, bufnr)
            local fmt = function(cmd) return function(str) return cmd:format(str) end end

            local map = function(m, lhs, rhs)
                local opts = {noremap = true, silent = true}
                vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, opts)
            end

            local lsp = fmt("<cmd>lua vim.lsp.%s<cr>")
            local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<cr>")
            local telescope = fmt("<cmd>lua require('telescope.builtin').%s<cr>")

            map("n", "K", lsp "buf.hover()")

            -- map("n", "gd", lsp "buf.definition()")
            map("n", "gd", telescope "lsp_definitions()")

            map("n", "gD", lsp "buf.declaration()")

            -- map("n", "gi", lsp "buf.implementation()")
            map("n", "gi", telescope "lsp_implementations()")

            -- map("n", "go", lsp "buf.type_definition()")
            map("n", "go", telescope "lsp_type_definitions()")

            map("n", "gr", telescope "lsp_references()")
            -- map('n', 'gr', lsp 'buf.references()')

            map("n", "<F2>", lsp "buf.rename()")
            map("n", "<F4>", lsp "buf.code_action()")
            map("x", "<F4>", lsp "buf.range_code_action()")

            -- if state.map_ctrlk then
            --     map("n", "<C-k>", lsp "buf.signature_help()")
            -- end

            map("n", "gl", diagnostic "open_float()")
            map("n", "[d", diagnostic "goto_prev()")
            map("n", "]d", diagnostic "goto_next()")
        end)

        lsp.setup()
    end,
}
