return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
        vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
}
