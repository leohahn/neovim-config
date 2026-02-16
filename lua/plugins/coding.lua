return {
  { 
    "nvim-mini/mini.basics",
    version = false,
    opts = {
      -- Options. Set field to `false` to disable.
      options = {
        -- Basic options ('number', 'ignorecase', and many more)
        basic = true,
        -- Extra UI features ('winblend', 'listchars', 'pumheight', ...)
        extra_ui = false,
        -- Presets for window borders ('single', 'double', ...)
        -- Default 'auto' infers from 'winborder' option
        win_borders = 'auto',
      },
      -- Mappings. Set field to `false` to disable.
      mappings = {
        -- Basic mappings (better 'jk', save with Ctrl+S, ...)
        basic = true,
        -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
        -- Supply empty string to not create these mappings.
        option_toggle_prefix = [[\]],
        -- Window navigation with <C-hjkl>, resize with <C-arrow>
        windows = false,
        -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
        move_with_alt = false,
      },
      -- Autocommands. Set field to `false` to disable
      autocommands = {
        -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
        basic = true,
        -- Set 'relativenumber' only in linewise and blockwise Visual mode
        relnum_in_visual_mode = false,
      },
      -- Whether to disable showing non-error feedback
      silent = false,
    }
  },

  { "nvim-mini/mini.icons", version = false },

  -- Auto pairs
  -- Automatically inserts a matching closing character
  -- when you type an opening character like `"`, `[`, or `(`.
  {
    "nvim-mini/mini.pairs",
    event = { "InsertCharPre" },
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\]' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\]' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\]' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\]' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\]',   register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%a\\]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^\\]',   register = { cr = false } },
      },
    },
  },

  -- Improves comment syntax, lets Neovim handle multiple
  -- types of comments for a single language, and relaxes rules
  -- for uncommenting.
  {
    "folke/ts-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Extends the a & i text objects, this adds the ability to select
  -- arguments, function calls, text within quotes and brackets, and to
  -- repeat those selections to select an outer text object.
  {
    "nvim-mini/mini.ai",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
}
