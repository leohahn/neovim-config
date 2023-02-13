return {
    "EdenEast/nightfox.nvim",
    dependencies = {
        "RRethy/vim-illuminate",
        "nvim-lualine/lualine.nvim",
    },
    config = function()
        require("nightfox").setup {
            modules = {
                illuminate = false,
            },
            groups = {
                all = {
                    IlluminatedWordText = { link = "LspReferenceText" },
                    IlluminatedWordRead = { link = "LspReferenceText" },
                    IlluminatedWordWrite = { link = "LspReferenceText" },
                },
            },
        }
    end,
}
