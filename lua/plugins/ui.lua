return {
  {
    "nvim-mini/mini.starter",
    version = false,
    lazy = false,
    opts = {},
  },

  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- Set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- Hide statusline if opening without arguments
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: avoid extra indirection in lualine's require helper
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local function gitsigns_diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      return {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = {
            statusline = { "NvimTree", "alpha", "dashboard", "ministarter" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = "E:",
                warn = "W:",
                info = "I:",
                hint = "H:",
              },
            },
            { "filename", path = 1 },
          },
          lualine_x = {
            {
              "diff",
              source = gitsigns_diff_source,
            },
            "encoding",
            "fileformat",
            { "filetype", icon_only = false },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
      }
    end,
  },
}
