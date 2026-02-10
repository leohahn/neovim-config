return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but recommended
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      vim.keymap.set("n", "<C-s>h", ":<C-U>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-s>j", ":<C-U>TmuxNavigateDown<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-s>k", ":<C-U>TmuxNavigateUp<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-s>l", ":<C-U>TmuxNavigateRight<CR>", { noremap = true, silent = true })
    end,
    lazy = false,
  },
}
