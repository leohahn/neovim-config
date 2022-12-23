return {
    "windwp/nvim-autopairs",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local npairs = require("nvim-autopairs")
        npairs.setup {
            disable_filetype = { "TelescopePrompt" }
        }

        local cmp_npairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_npairs.on_confirm_done())
    end
}


