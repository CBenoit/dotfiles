-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.default_prog = { '/home/auroden/.cargo/bin/nu' }

-- Finally, return the configuration to wezterm:
return config
