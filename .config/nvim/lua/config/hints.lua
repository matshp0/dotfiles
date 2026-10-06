-- Personal keybind cheatsheet. Run `:Hints`, or `:Hints <text>` to filter.
-- Add a line to M.hints whenever you meet a key you keep forgetting.

local M = {}

M.hints = {
  { section = "Search / Replace" },
  { "<leader>sr", "Search + replace across files (grug-far: live preview, undoable)" },

  { section = "Selection" },
  { "<C-Space>", "Treesitter incremental select -- <C-Space> grows, <BS> shrinks" },

  { section = "Navigation" },
  { "gx", "Open URL or filepath under cursor with the system handler" },
}

---Build the rendered lines plus their highlight spans.
---@param filter string|nil
local function build(filter)
  local lines, hls = {}, {}
  local needle = filter and filter:lower() or nil

  local keyw = 0
  for _, h in ipairs(M.hints) do
    if h[1] then
      keyw = math.max(keyw, vim.fn.strdisplaywidth(h[1]))
    end
  end

  local function add(line)
    table.insert(lines, line)
    return #lines - 1
  end

  -- Sections are emitted lazily so a filter never leaves an empty heading.
  local pending = nil
  for _, h in ipairs(M.hints) do
    if h.section then
      pending = h.section
    elseif not needle or (h[1] .. " " .. h[2]):lower():find(needle, 1, true) then
      if pending then
        if #lines > 0 then
          add("")
        end
        local text = "  " .. pending
        table.insert(hls, { add(text), 0, #text, "Title" })
        pending = nil
      end
      local key = h[1] .. string.rep(" ", keyw - vim.fn.strdisplaywidth(h[1]))
      table.insert(hls, { add("  " .. key .. "   " .. h[2]), 2, 2 + #key, "Special" })
    end
  end

  if #lines == 0 then
    add("  nothing matches " .. vim.inspect(filter))
  end
  add("")

  return lines, hls
end

---@param filter string|nil
function M.show(filter)
  local lines, hls = build(filter)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local ns = vim.api.nvim_create_namespace("hints")
  for _, h in ipairs(hls) do
    vim.api.nvim_buf_set_extmark(buf, ns, h[1], h[2], { end_col = h[3], hl_group = h[4] })
  end

  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local width = 0
  for _, l in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(l))
  end
  width = math.min(width + 2, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 6)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = filter and (" Hints: " .. filter .. " ") or " Hints ",
    title_pos = "center",
  })
  vim.wo[win].cursorline = true

  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, { buffer = buf, nowait = true, silent = true })
  end
end

vim.api.nvim_create_user_command("Hints", function(opts)
  M.show(opts.args ~= "" and opts.args or nil)
end, { nargs = "?", desc = "Keybind cheatsheet" })

return M
