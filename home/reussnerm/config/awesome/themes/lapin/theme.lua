-------------------------------
--  "Lapin" awesome theme  --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.wallpaper_cmd = {  "awsetbg Pictures/Wallpapers/02946_intothemountains_1600x900.jpg" }
-- }}}
local home   = os.getenv("HOME")

-- {{{ Styles
theme.font      = "Profont 6"

-- {{{ Colors
theme.fg_normal = "#f2f2f2"
theme.fg_focus  = "#222429"
theme.fg_urgent = "#222429"
theme.bg_normal = "#222429cc"
theme.bg_focus  = "#a3d069"
theme.bg_urgent = "#fc8200"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#222429"
theme.border_focus  = "#a3d069"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}
theme.opacity_focus = 0.85
theme.opacity_normal = 0.75 
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
theme.fg_widget        = "#a3d069"
theme.fg_center_widget = "#cf8134"
theme.fg_end_widget    = "#fc3200"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = home.. "/.config/awesome/themes/lapin/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = home.. "/.config/awesome/themes/lapin/layouts/max.png"
theme.layout_fullscreen = home.. "/.config/awesome/themes/lapin/layouts/fullscreen.png"
theme.layout_magnifier  = home.. "/.config/awesome/themes/lapin/layouts/magnifier.png"
theme.layout_floating   = home.. "/.config/awesome/themes/lapin/layouts/floating.png"
-- }}}

-- {{{ Widget icons
theme.widget_cpu    = home.. "/.config/awesome/icons2/cpu.png"
theme.widget_netup  = home.. "/.config/awesome/icons2/up.png"
theme.widget_fs     = home.. "/.config/awesome/icons2/disk.png"
theme.widget_vol    = home.. "/.config/awesome/icons2/vol.png"
theme.widget_date   = home.. "/.config/awesome/icons2/time.png"
theme.widget_music  = home.. "/.config/awesome/icons2/music.png"
theme.widget_mem    = home.. "/.config/awesome/icons2/mem.png"
theme.widget_net    = home.. "/.config/awesome/icons2/down.png"
theme.widget_bat    = home.. "/.config/awesome/icons2/bat.png"
theme.widget_mail   = home.. "/.config/awesome/icons2/mail.png"
-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

naughty.config.presets.online = {
    bg = "#1f880e80",
    fg = "#ffffff",
}
naughty.config.presets.chat = naughty.config.presets.online
naughty.config.presets.away = {
    bg = "#eb4b1380",
    fg = "#ffffff",
}
naughty.config.presets.xa = {
    bg = "#65000080",
    fg = "#ffffff",
}
naughty.config.presets.dnd = {
    bg = "#65340080",
    fg = "#ffffff",
}
naughty.config.presets.invisible = {
    bg = "#ffffff80",
    fg = "#000000",
}
naughty.config.presets.offline = {
    bg = "#64636380",
    fg = "#ffffff",
}
naughty.config.presets.requested = naughty.config.presets.offline
naughty.config.presets.error = {
    bg = "#ff000080",
    fg = "#ffffff",
}
naughty.config.icon_dirs = { os.getenv("HOME") .. ".config/awesome/naughtyicons/",  "/usr/share/pixmaps/" }

return theme
