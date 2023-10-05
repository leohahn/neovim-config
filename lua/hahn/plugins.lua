return {
    -- Basic functionalities needed by other plugins (not user facing)
    "nvim-lua/plenary.nvim",

    -- Extend base vim functionality
    "tpope/vim-surround",
    "tpope/vim-repeat", -- support repeat '.' for plugins as well
    "tpope/vim-sleuth", -- detect indentation for files automatically
    { -- kill buffers without deleting the window as well
        "moll/vim-bbye",
        config = function()
            vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bq", ":Bwipeout<CR>", { noremap = true, silent = true, desc = "Wipeout buffer" })
        end,
        lazy = false,
    },
    -- Visualize undo tree
    "mbbill/undotree",

    -- Move between tmux windows and vim panes
    {
        'christoomey/vim-tmux-navigator',
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
        end,
        config = function()
            vim.keymap.set("n", "<C-s>h", ":<C-U>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<C-s>j", ":<C-U>TmuxNavigateDown<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<C-s>k", ":<C-U>TmuxNavigateUp<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<C-s>l", ":<C-U>TmuxNavigateRight<CR>", { noremap = true, silent = true })
        end,
        keys = { "<C-s>h", "<C-s>j", "<C-s>k", "<C-s>l" },
    },

    -- Startup screen for neovim
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    },

    -- Universal increment with neovim
    {
        "monaqa/dial.nvim",
        config = function()
            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true, silent = true})
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true, silent = true})
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true, silent = true})
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true, silent = true})
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true, silent = true})
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true, silent = true})
        end,
        keys = { "<C-a>", "<C-x>" },
    },

    -- Improve how some of the ui in nvim looks
    { "stevearc/dressing.nvim", event = "VeryLazy" },

    -- Navigate to matching keyword based on tree sitter
    {
        "andymass/vim-matchup",
        event = "BufReadPost",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
        end,
    },

    -- Prompts the user to pick a window
    {
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
        config = function()
            require('window-picker').setup()
        end,
        lazy = false,
    },
}
