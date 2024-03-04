vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
-- vim.o.background = "light" -- or "light" for light mode
--
-- set Vim-specific sequences for RGB colors
vim.cmd([[
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])

-- local colorscheme = "gruvbox"
-- local colorscheme = "blue-moon"
-- local colorscheme = "carbonfox"
-- local colorscheme = "dayfox"
-- local colorscheme = "everforest"
-- local colorscheme = "catppuccin-mocha"
local colorscheme = "tokyonight-night"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
