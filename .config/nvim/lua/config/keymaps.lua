-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>L")

vim.keymap.set("n", "<leader>Lt", "<cmd>Leet test<cr>", { desc = "Leet Test" })
vim.keymap.set("n", "<leader>Ls", "<cmd>Leet submit<cr>", { desc = "Leet Submit" })
vim.keymap.set("n", "<leader>Ll", "<cmd>Leet lang<cr>", { desc = "Leet Lang" })
vim.keymap.set("n", "<leader>Lm", "<cmd>Leet menu<cr>", { desc = "Leet Menu" })
