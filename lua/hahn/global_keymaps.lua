local set_keymap = vim.api.nvim_set_keymap

-- Map space as a leader
set_keymap("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal = "n"
--   insert = "i"
--   visual = "v"
--   visual block = "x"
--   term = "t"
--   command "c"

-- Saving buffers
set_keymap("n", "<leader>fs", ":w<CR>", { noremap = true, silent = true, desc = "Save buffer" })

-- Faster than using esc to exit insert mode
set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Quickly manipulate window splits
set_keymap("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Open vertical split window" })
set_keymap("n", "<leader>ws", ":split<CR>", { noremap = true, silent = true, desc = "Open horizontal split window" })
set_keymap("n", "<leader>wd", ":close<CR>", { noremap = true, silent = true, desc = "Close window" })
set_keymap("n", "<leader>wm", ":only<CR>", { noremap = true, silent = true, desc = "Maximize window" })

-- Manipulate buffers
set_keymap("n", "<leader><TAB>", ":e #<CR>", { noremap = true, silent = true, desc = "Previous buffer" }) -- switch to previous buffer

-- Stay in indent mode
--set_keymap("v", "<", "<gv", { noremap = true, silent = true })
--set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Replace on top of another selection without yanking the selection
set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

-- Move text up and down
-- set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
-- set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
set_keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
set_keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Clear search highlight
set_keymap("n", "<C-L>", ":noh<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })

