
local opts = { noremap = true, silent = true }

-- Shorten keymap function
local keymap = vim.api.nvim_set_keymap

-- Space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open Neotree
keymap("n", "<leader>e", ":Neotree toggle")

-- Quick normal (change to using capslock)
keymap("i", "jk", "<ESC>", opts)

-- Hold onto shifts
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
