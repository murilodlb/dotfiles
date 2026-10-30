local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 2. Define the Nerd Font symbols
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- System & Rendering
config.enable_wayland = true
config.front_end = "WebGpu"
config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"
config.tab_max_width = 35
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

config.line_height = 1.0

config.initial_cols = 200
config.initial_rows = 64

-- or, changing the font size and color scheme.
config.font_size = 12
config.font = wezterm.font("AdwaitaMono Nerd Font")
config.font_rules = {
    {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font {
        family = 'AdwaitaMono Nerd Font',
        weight = 'Bold',
        },
    },
}
-- config.color_scheme = 'Mathias'
config.bold_brightens_ansi_colors = false
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}
-- Hide the tab bar when you only have one tab open
-- config.hide_tab_bar_if_only_one_tab = true

-- Set the cursor to a blinking block
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 1000

-- Set Leader key to Ctrl + A
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Press Ctrl+A, then press '-' to split horizontally (top/bottom)
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Press Ctrl+A, then press '\' to split vertically (left/right)
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Press Ctrl+A, then 'z' to toggle zooming the current pane to full screen
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- Press Ctrl+A, then 'x' to close the current pane
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Quick Select, press Ctrl+a then Space
	{
		key = "Space",
		mods = "LEADER",
		action = wezterm.action.QuickSelect,
	},
}
-- config.colors = require("neolux")

config.colors = dofile("/home/murilo/Desktop/projetos/neolux/extras/wezterm/neolux.lua")

-- 4. Use the `format-tab-title` event to dynamically draw the edges
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- Define the colors based on whether the tab is active
	local background = "#000000"
	local foreground = "#2a2a2a"
	local edge_background = "#000000" -- The terminal background color

	if tab.is_active then
		background = "#2a2a2a"
		foreground = "#808080"
	elseif hover then
		background = "#2a2a2a"
		foreground = "#3a3a3a"
	end

    -- Tab Title: number + directory
    local index = tab.tab_index + 1
    local cwd_uri = tab.active_pane.current_working_dir
    local cwd = ""

    if cwd_uri then
        -- 1. Extract the file path
        local path = cwd_uri.file_path
        -- 2. Remove any trailing slash at the end (if it exists)
        path = path:gsub("/$", "")
        -- 3. Grab just the final folder name safely
        cwd = path:match("([^/]+)$") or path
    end

    local raw_title = index .. ": " .. cwd
    local title = string.format(" %-5s ", raw_title)
	-- Return the formatted array of elements
	return {
		-- The Left Arrow (points right, colored with tab background)
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = background } },
		{ Text = SOLID_RIGHT_ARROW },

		-- The Tab Body
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },

		-- The Right Arrow (points left, colored with tab background)
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = background } },
		{ Text = SOLID_LEFT_ARROW },
	}
end)

-- Finally, return the configuration to wezterm:
return config
