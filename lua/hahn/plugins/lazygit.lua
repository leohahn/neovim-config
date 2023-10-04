return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {"<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit"},
        },
        init = function ()
            vim.g.lazygit_floating_window_use_plenary = 1
            vim.g.lazygit_floating_window_winblend = 1
        end
    },
}
