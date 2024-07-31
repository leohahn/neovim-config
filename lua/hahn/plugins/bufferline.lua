return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye",
    },
    config = function()
        require("bufferline").setup {
            options = {
                close_command = "Bdelete! %d",
                right_mouse_command = "Bdelete! %d",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
        }
    end,
}

