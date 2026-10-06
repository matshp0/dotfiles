return {
  {
    "nvim-mini/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "gsa",       -- add surrounding
          delete = "gsd",    -- delete surrounding
          find = "sf",       -- find surrounding to the right
          find_left = "sF",  -- find surrounding to the left
          highlight = "sh",  -- highlight surrounding
          replace = "sr",    -- replace surrounding

          suffix_last = "l", -- optional, search prev
          suffix_next = "n", -- optional, search next
        },
        -- optional: highlight duration when using sh
        highlight_duration = 500,
        n_lines = 20, -- how many lines to search for surrounding
        respect_selection_type = false,
        search_method = "cover",
        silent = false,
      })
    end
  }
}
