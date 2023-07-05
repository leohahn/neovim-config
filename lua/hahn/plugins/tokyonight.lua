return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      style = "night",
      light_style = "day",
      terminal_colors = true,
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows

      },
      day_brightness = 0.3,
      on_highlights = function(hl, colors)
        hl.IlluminatedWordRead = {
          link = "Visual",
        }
        hl.IlluminatedWordText = {
          link = "Visual",
        }
        hl.IlluminatedWordWrite = {
          link = "Visual",
        }
      end,
    })
  end,
}
