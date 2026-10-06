-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,
    border_size = 2,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- Use round window corners.
    rounding = 5,
  },
})

-- Make terminal windows see-through (Omarchy default is "0.985 0.96").
-- Third value is fullscreen opacity, which otherwise falls back to 1.0.
-- Omarchy tags every terminal, including TUI windows with their own app-id
-- (About, btop, ...), so match the tag instead of individual classes.
o.window({ tag = "terminal" }, { tag = "-default-opacity", opacity = "0.95 0.95 0.95" })

-- Keep the screensaver solid.
o.window("org.omarchy.screensaver", { opacity = "1 1 1" })
