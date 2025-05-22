-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the COLOR SCHEME:
-- config.color_scheme = '3024 (dark) (terminal.sexy)'
-- config.color_scheme = "Tomorrow Night Burns"
--

------------------------------- THEME CONFIGURATION ----------------------------------

local neofusion_theme = {
  foreground = "#00deff",
  background = "#000000",
  cursor_bg = "#e0d9c7",
  cursor_border = "#e0d9c7",
  cursor_fg = "#070f1c",
  selection_bg = "#ea6847",
  selection_fg = "#e0d9c7",
  ansi = {
    "#070f1c", -- Black (Host)
    "#dd0000", -- Red (Syntax string)
    "#ff5f1f", -- Green (Command) (This one changes the commit colors)
    "#5db2f8", -- Yellow (Command second)
    "#2f516c", -- Blue (Path)
    "#d943a8", -- Magenta (Syntax var)
    "#86dbf5", -- Cyan (Prompt)
    "#e0d9c7", -- White
  },
  brights = {
    "#2f516c", -- Bright Black
    "#d943a8", -- Bright Red (Command error)
    "#ea6847", -- Bright Green (Exec) (changes headings)
    "#dd0000", -- Bright Yellow
    "#5db2f8", -- Bright Blue (Folder)
    "#d943a8", -- Bright Magenta
    "#ea6847", -- Bright Cyan
    "#e0d9c7", -- Bright White
  },
  tab_bar = {
    inactive_tab_edge = "#de0000",
    background = "#000000",
  },
}

config.colors = neofusion_theme
-- "#ea6847", -- Bright Cyan (original neofusino color for red(dd0000) and ff5f1f (neon orange))
-- "#86dbf5", -- Cyan (Prompt)

-- config.default_cursor_style = "BlinkingBlock"
-- config.animation_fps = 1

---------------------------------------- FONT CONFIGURATION -------------------------------------------

-- config.font = wezterm.font("Iosevka SS04")
config.font_size = 13.5
config.default_prog = { "zsh" }
-- config.window_background_opacity = 0.7
-- config.win32_system_backdrop = "Acrylic"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

------------------------------- TAB BAR CONFIGURATION ----------------------------------

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  font = wezterm.font({ family = "SpaceMono Nerd Font" }),
  active_titlebar_bg = "#000000",
}
config.tab_max_width = 20
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_flame_thick_mirrored
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_flame_thick

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = "#000000"
  local background = "#1b1032"
  local foreground = "#808080"

  if tab.is_active then
    background = "#de0000"
    foreground = "#c0c0c0"
  elseif hover then
    background = "#3b3052"
    foreground = "#909090"
  end

  local edge_foreground = background

  local title = tab_title(tab)

  -- ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  title = wezterm.truncate_right(title, max_width - 2)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- and finally, return the configuration to wezterm
return config
