-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ghostty leaves 14px of padding below the statusline. Drop the bottom padding
-- while nvim owns the window and restore it on exit.
if vim.env.GHOSTTY_RESOURCES_DIR or vim.env.TERM == "xterm-ghostty" then
  local script = vim.fn.expand("~/.local/bin/ghostty-nvim-padding")
  if vim.fn.executable(script) == 1 then
    local pid = tostring(vim.fn.getpid())
    local group = vim.api.nvim_create_augroup("ghostty_padding", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      callback = function()
        vim.system({ script, "on", pid }, { detach = true })
      end,
    })

    vim.api.nvim_create_autocmd("VimLeave", {
      group = group,
      callback = function()
        -- Synchronous: a detached job would race with the exiting process.
        vim.system({ script, "off", pid }):wait(2000)
      end,
    })
  end
end
