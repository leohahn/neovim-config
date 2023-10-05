return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        local treesitter_context = require("treesitter-context")
        treesitter_context.setup({
            max_lines = 1,
            separator = nil,
            trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        })
    end
}
