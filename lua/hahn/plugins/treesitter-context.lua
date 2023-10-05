return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        local treesitter_context = require("treesitter-context")
        treesitter_context.setup({
            max_lines = 0,
            separator = nil,
        })
    end
}
