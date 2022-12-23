return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup {
            "css";
            "javascript";
            "typescript";
            "html";
            "typescriptreact";
            "javascriptreact";
        }
    end,
    ft = { "css", "javscript", "typescript", "html", "typescriptreact", "javascriptreact" },
}

