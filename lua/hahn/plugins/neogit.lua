return {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    init = function()
        vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
    end,
    config = function()
        require("neogit").setup {
            kind = "split",
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            integrations = { diffview = true },
        }
    end,
}
