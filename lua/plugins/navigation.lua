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
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus",
      "NvimTreeFindFile",
    },
    keys = {
      {
        "<leader>ft",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Toggle file tree",
      },
      {
        "<leader>fe",
        "<cmd>NvimTreeFindFile<CR>",
        desc = "Reveal current file in tree",
      },
    },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 35,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
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
