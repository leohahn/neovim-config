vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
-- vim.o.background = "light" -- or "light" for light mode

-- local colorscheme = "gruvbox"
-- local colorscheme = "blue-moon"
-- local colorscheme = "carbonfox"
local colorscheme = "tokyonight"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
