local opts = { noremap = true, silent = true }
local set_keymap = vim.api.nvim_set_keymap

-- Map space as a leader
set_keymap("n", "<Space>", "<Nop>", opts)
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
set_keymap("n", "<leader>fs", ":w<CR>", opts)

-- Faster than using esc to exit insert mode
set_keymap("i", "kj", "<ESC>", opts)
set_keymap("i", "jk", "<ESC>", opts)

-- Quickly manipulate window splits
set_keymap("n", "<leader>wv", ":vsplit<CR>", opts)
set_keymap("n", "<leader>ws", ":split<CR>", opts)
set_keymap("n", "<leader>wd", ":close<CR>", opts)
set_keymap("n", "<leader>wm", ":only<CR>", opts)

-- Manipulate buffers
set_keymap("n", "<leader><TAB>", ":e #<CR>", opts) -- switch to previous buffer

-- Stay in indent mode
--set_keymap("v", "<", "<gv", opts)
--set_keymap("v", ">", ">gv", opts)

-- Replace on top of another selection without yanking the selection
set_keymap("v", "p", '"_dP', opts)

-- Move text up and down
-- set_keymap("n", "<C-k>", ":m .-2<CR>==", opts)
-- set_keymap("n", "<C-j>", ":m .+1<CR>==", opts)
set_keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
set_keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)
set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Clear search highlight
set_keymap("n", "<C-L>", ":noh<CR>", opts)

