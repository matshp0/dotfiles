-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.hints")

vim.opt.number = true
vim.opt.relativenumber = true
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

vim.keymap.set("n", "gg", "gg0", { noremap = true, silent = true })
vim.keymap.set("n", "G", "G$", { noremap = true, silent = true })
vim.keymap.set("v", "gg", "gg0", { noremap = true, silent = true })
vim.keymap.set("v", "G", "G$", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>d", '"_d', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, silent = true })

vim.keymap.set("v", "p", "pgvy", { noremap = true, silent = true })

vim.keymap.set("n", "p", "p=`]", { noremap = true, silent = true })
vim.keymap.set("n", "P", "P=`]", { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<leader>*",
  ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>",
  { noremap = true, silent = false, desc = "Substitute word under cursor with confirmation" }
)

vim.keymap.set("n", "<leader>cM", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.addMissingImports" } },
    apply = true,
  })
end, { desc = "Add all missing imports (vtsls)" })
