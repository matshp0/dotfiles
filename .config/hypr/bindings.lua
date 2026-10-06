-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- Close window on SUPER + Q instead of the default SUPER + W.
hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- File manager on SUPER + E (default is SUPER + SHIFT + F).
-- SUPER + E opens Files in the terminal's directory (tmux pane aware) when a
-- terminal is focused (see ~/.local/bin/nautilus-smart), otherwise a plain window.
o.bind("SUPER + E", "File manager", os.getenv("HOME") .. "/.local/bin/nautilus-smart")

-- Browser on SUPER + B. Follows the xdg default browser (currently Zen from AUR).
o.bind("SUPER + B", "Browser", { omarchy = "browser" })

-- App launcher on SUPER + D (walker is gone; this is the apps menu,
-- also on the default SUPER + ALT + SPACE).
o.bind("SUPER + D", "Launch apps", "omarchy-menu toggle apps")

-- Activity monitor on SUPER + SHIFT + T (default is SUPER + CTRL + T).
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Region screenshot on SUPER + SHIFT + S (default there is the Google Maps
-- web app; default screenshot is PRINT).
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot to clipboard", "omarchy capture screenshot region")

-- Layout-proof universal clipboard (overrides default/hypr/bindings/clipboard.lua).
-- Omarchy's defaults pass key = "C"/"V"/"X" to send_key_state, and Hyprland resolves
-- that keysym against the ACTIVE xkb group. With kb_layout = "us,ua", the Ukrainian
-- group has no Latin C/V/X keysym, so SUPER+C dies with:
--   Runtime error in lua: =[C]:-1: send_key_state: key not found
-- Hardware keycodes resolve in every group. evdev code + 8: x = 53, c = 54, v = 55.
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function active_window_is_terminal()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    if tag:gsub("%*$", "") == "terminal" then
      return true
    end
  end

  return false
end

local function universal_clipboard_shortcut(default_mods, default_key, terminal_mods, terminal_key)
  return function()
    if active_window_is_terminal() then
      send_shortcut_once(terminal_mods, terminal_key)()
    else
      send_shortcut_once(default_mods, default_key)()
    end
  end
end

hl.unbind("SUPER + C")
hl.unbind("SUPER + V")
hl.unbind("SUPER + X")

o.bind("SUPER + C", "Universal copy", universal_clipboard_shortcut("CTRL", "code:54", "CTRL", "Insert"))
o.bind("SUPER + V", "Universal paste", universal_clipboard_shortcut("CTRL", "code:55", "SHIFT", "Insert"))
o.bind("SUPER + X", "Universal cut", send_shortcut_once("CTRL", "code:53"))
