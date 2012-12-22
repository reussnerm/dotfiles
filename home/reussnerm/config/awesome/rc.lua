require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("revelation")
require("shifty")
vicious = require("vicious")
require("awesompd/awesompd")
util=require("awful.util")
require("aware")

local home   = os.getenv("HOME")

beautiful.init(home .."/.config/awesome/themes/lapin/theme.lua")

terminal = "xterm"
editor = os.getenv("EDITOR") or "geany"
editor_cmd = "geany"

modkey = "Mod4"
modkey2 = "Mod3"

layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}


-- {{{ Tags
shifty.config.defaults = {
    layout = "max",
    mwfact = 0.5,
    run = function(tag) naughty.notify({text = tag.name}) end,
}
shifty.config.tags = {

    ["[urxvt]"] = { position = 2, init = true, },
    ["[sys]"]  = { position = 3, exclusive = true,  nopopup = true },
    ["[Wireshark]"]  = { position = 4, exclusive = true,  nopopup = true },
    ["[firefox]"] 	= { position = 11,  spawn = browser,nopopup = true},
    ["[xxxterm]"] 	= { position = 11,  spawn = browser,nopopup = true},
    ["[Bookmarks]"] 	= { position = 12,  spawn = browser,nopopup = true},
    ["[Rss/Atom]"] = {position = 40,nopopup = true},
    ["[Download]"] = { position = 60, nopopup = false},
    ["[ide]"] = { position = 70 },
    ["[edit]"] = { position = 71 },
    ["[office]" ] = {position = 72 },
    ["[pdf]"] = { position = 73 },
    ["[view]"] = { position = 80, exclusive = true, nopopup = true  },
    ["[Picture]"] = {position = 81,nopopup = true },
    ["[mplayer]"] = { position = 100, nopopup = false, spawn = mplayer, exclusive = true },
    ["[Xephyr]" ] = {position = 999 }
}

shifty.taglist = mytaglist

shifty.config.apps = {

    { match = { "wireshark", "Wireshark"         			},	tag = "[Wireshark]",                                   	},
    { match = { "Places", "Firefox"								},	tag = "[Bookmarks]", 						opacity = 1.0   },
    { match = { "Firefox"										},	tag = "[firefox]", 							opacity = 1.0   },
    { match = { "xxxterm", "XXXTerm" 							},	tag = "[xxxterm]",	 						opacity = 1.0   },
	{ match = { "liferea", "Liferea"			  		     	}, 	tag = "[Rss/Atom]",					opacity = 1.0	},
	{ match = { "Download"			  							}, 	tag = "[Download]",					opacity = 1.0	},
    { match = { "gedit","geany", "Geany"						},	tag = "[edit]", 					opacity = 1.0   },
    { match = { "evince", "Evince"                   			}, 	tag = "[pdf]" 										},
	{ match = { "gwenview", "Gwenview"  						}, 	tag = "[Picture]",					opacity = 1.0	},
    { match = { "MPlayer","ffplay","Qt-subapplication"      	},	tag = "[mplayer]",	float = true, 	opacity = 1.0   },
	{ match = { "Xephyr", "Xephyr" }, 	tag = "[Xephyr]" 									}
}

-- Options par défaut.
shifty.config.defaults = {
  layout = awful.layout.suit.fair,
  ncol = 1,
  mwfact = 0.50,
  floatBars=false,
}


-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
menu_awesome = {
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

menu_internet = {
	{ "Mozilla Firefox", "firefox" }
}


mymainmenu = awful.menu({
  items = {
	{ "open terminal", terminal },
	{ "awesome", menu_awesome},
	{ "Internet", menu_internet},
	{ "Reboot", "sudo reboot" },
	{ "Shutdown", "sudo halt -p" }
  }
})


mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
mytextclock = awful.widget.textclock({ align = "right" })
mysystray = widget({ type = "systray" })
mywibox = {}
mywibox_bottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )


mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		client.focus = c
		c:raise()
	end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width=250 })
		end
	end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end))




for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(function(c) return awful.widget.tasklist.label.currenttags(c, s) end, mytasklist.buttons)
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)
-- Mem Widget
memwidget = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.rightleft })
memwidget:set_width(50)
memwidget:set_height(15)
memwidget:set_background_color(beautiful.fg_focus)
memwidget:set_border_color("#FFFFFF")
memwidget:set_color("#AECF96")
memwidget:set_gradient_colors({ beautiful.fg_widget, theme.fg_center_widget, theme.fg_end_widget })
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
-- CPU Widget
cpuwidget = awful.widget.graph({ layout = awful.widget.layout.horizontal.rightleft })
cpuwidget:set_width(50)
cpuwidget:set_height(15)
cpuwidget:set_border_color("#FFFFFF")
cpuwidget:set_background_color(beautiful.fg_focus)
cpuwidget:set_color(beautiful.fg_focus)
cpuwidget:set_gradient_colors({ beautiful.fg_widget, theme.fg_center_widget, theme.fg_end_widget })
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")
-- Widget MPD
musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "Liberation Mono" -- Set widget font 
musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
musicwidget.output_size = 30 -- Set the size of widget in symbols
musicwidget.update_interval = 10 -- Set the update interval in seconds
musicwidget.path_to_icons = home .."/.config/awesome/awesompd/icons" 
musicwidget.jamendo_format = awesompd.FORMAT_MP3
musicwidget.show_album_cover = true
musicwidget.album_cover_size = 50
musicwidget.mpd_config = "/etc/mpd.conf"
musicwidget.browser = "firefox"
musicwidget.ldecorator = " "
musicwidget.rdecorator = " "
musicwidget.servers = {{ server = "localhost",port = 6600 }}
musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
	{ "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
	{ "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
	{ "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
	{ modkey, "Pause", musicwidget:command_playpause() } })
musicwidget:run()


-- Net Widget
-- netwidget       = widget({ type = "textbox", name = "netwidget" })
-- vicious.register(netwidget, vicious.widgets.net, '<span color="'.. beautiful.fg_end_widget ..'">${eth0 down_kb}</span> <span color="'.. beautiful.fg_widget ..'">${eth0 up_kb}</span>', 3)
-- FS Widget
fswidget       = widget({ type = "textbox", name = "fswidget" })
vicious.register(fswidget, vicious.widgets.fs,' ${/ used_gb}Go<span color="'.. beautiful.fg_widget ..'"> /</span> ${/ size_gb}Go ', 120)
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, " $1% ", 1, "PCM")
volwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q set Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("xterm -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q set PCM 3dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q set PCM 3dB-", false) end)
))


-- {{{ Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
-- Initialize widgets
volbar    = awful.widget.progressbar()
volwidget = widget({ type = "textbox" })
-- Progressbar properties
volbar:set_vertical(true):set_ticks(true)
volbar:set_height(12):set_width(8):set_ticks_size(2)
volbar:set_background_color(beautiful.fg_off_widget)
volbar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
}) -- Enable caching
vicious.cache(vicious.widgets.volume)
-- Register widgets
vicious.register(volbar,    vicious.widgets.volume,  "$1",  2, "PCM")
vicious.register(volwidget, vicious.widgets.volume, " $1%", 2, "PCM")
-- Register buttons
volbar.widget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("kmix") end),
   awful.button({ }, 4, function () exec("amixer -q set PCM 2dB+", false) end),
   awful.button({ }, 5, function () exec("amixer -q set PCM 2dB-", false) end)
)) -- Register assigned buttons
volwidget:buttons(volbar.widget:buttons())
-- }}}


wifi = widget({ type = "textbox" })
vicious.register(wifi, vicious.widgets.wifi, "${ssid} ${chan} ${sign} dB", 20, "wlan0")
--  {ssid}, {mode}, {chan}, {rate}, {link}, {linp} and {sign}


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- {{{ File system usage
fsicon = widget({ type = "imagebox" })
fsicon.image = image(beautiful.widget_fs)
-- Initialize widgets
fs = {
  b = awful.widget.progressbar(), r = awful.widget.progressbar(),
  h = awful.widget.progressbar(), s = awful.widget.progressbar()
}
-- Progressbar properties
for _, w in pairs(fs) do
  w:set_vertical(true):set_ticks(true)
  w:set_height(14):set_width(5):set_ticks_size(2)
  w:set_border_color(beautiful.border_widget)
  w:set_background_color(beautiful.fg_off_widget)
  w:set_gradient_colors({ beautiful.fg_widget,
     beautiful.fg_center_widget, beautiful.fg_end_widget
  }) -- Register buttons
  w.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () exec("rox", false) end)
  ))
end -- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",     599)
vicious.register(fs.h, vicious.widgets.fs, "${" .. home .." used_p}", 599)
-- }}}
-- {{{ Mail subject
mailicon = widget({ type = "imagebox" })
mailicon.image = image(beautiful.widget_mail)
-- Initialize widget
mailwidget = widget({ type = "textbox" })
-- Register widget
-- vicious.register(mailwidget, vicious.widgets.mdir, "$1", 181, {home .. "/Maildir/INBOX",home .. "/Maildir/INBOX"})
vicious.register(mailwidget, vicious.widgets.mdir, "$1", 181, {home .. "/Maildir/matthieu_at_reussner_dot_ch/INBOX", home .. "/Maildir/matthieu_dot_reussner_at_HOST2_dot_tld/INBOX"})

-- Register buttons
mailwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec("urxvt -T Alpine -e alpine.exp") end)
))
-- }}}
bat1graph    = awful.widget.progressbar()
-- Progressbar properties
bat1graph:set_vertical(true):set_ticks(false)
bat1graph:set_height(12):set_width(8):set_ticks_size(2)
bat1graph:set_background_color(beautiful.fg_off_widget)
bat1graph:set_gradient_colors({ beautiful.fg_end_widget,beautiful.fg_center_widget, beautiful.fg_widget})
-- -- Enable caching
--vicious.cache(vicious.widgets.bat)
-- Register widgets
vicious.register(bat1graph,  vicious.widgets.bat,      "$2", 10, "BAT1")

-- }}}
bat0graph    = awful.widget.progressbar()
-- Progressbar properties
bat0graph:set_vertical(true):set_ticks(false)
bat0graph:set_height(12):set_width(8):set_ticks_size(2)
bat0graph:set_background_color(beautiful.fg_off_widget)
bat0graph:set_gradient_colors({ beautiful.fg_end_widget,beautiful.fg_center_widget, beautiful.fg_widget})
 -- Enable caching
-- vicious.cache(vicious.widgets.bat)
-- Register widgets
vicious.register(bat0graph,  vicious.widgets.bat,      "$2", 10, "BAT0")

-- }}}
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 -- Quick launch bar widget BEGINS
 function find_icon(icon_name, icon_dirs)
    if string.sub(icon_name, 1, 1) == '/' then
       if util.file_readable(icon_name) then
          return icon_name
       else
          return nil
       end
    end
    if icon_dirs then
       for _, v in ipairs(icon_dirs) do
          if util.file_readable(v .. "/" .. icon_name) then
             return v .. '/' .. icon_name
          end
       end
    end
    return nil
 end
 
 function getValue(t, key)
    _, _, res = string.find(t, key .. " *= *([^%c]+)%c")
    return res
 end
 
 launchbar = { layout = awful.widget.layout.horizontal.leftright }
 filedir = home .. "/.config/awesome/launchbar/" -- Specify your folder with shortcuts here
 local items = {}
 local files = io.popen("ls " .. filedir .. "*.desktop")
 for f in files:lines() do
     local t = io.open(f):read("*all")
     table.insert(items, { image = find_icon(getValue(t,"Icon"), 
                                             { "/usr/share/icons/hicolor/22x22/apps" }),
                           command = getValue(t,"Exec"),
                           tooltip = getValue(t,"Name"),
                           position = tonumber(getValue(t,"Position")) or 255 })
 end
 table.sort(items, function(a,b) return a.position < b.position end)
 for i = 1, table.getn(items) do
    launchbar[i] = awful.widget.launcher(items[i])
 end
 
 -- Quick launch bar widget ENDS
rssbox = {}
rssbox = widget({ type = "textbox", name = "rss" })
aware.register(rssbox, { "http://news.google.com/news?pz=1&num=25&output=rss" }, { autodl = true,scroll = true, speed = 0.1, siz = 200})
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

bat0widget     = widget({ type = "textbox" })
vicious.register(bat0widget, vicious.widgets.bat, "$1$2%", 32, "BAT0")
bat1widget     = widget({ type = "textbox" })
vicious.register(bat1widget, vicious.widgets.bat, "$1$2%", 32, "BAT1")





mycpuicon        = widget({ type = "imagebox", name = "mycpuicon" })
mycpuicon.image  = image(beautiful.widget_cpu)
myneticon         = widget({ type = "imagebox", name = "myneticon" })
myneticonup       = widget({ type = "imagebox", name = "myneticonup" })
myneticonup.image = image(beautiful.widget_netup)
myneticon.image   = image(beautiful.widget_net)
myvolicon       = widget({ type = "imagebox", name = "myvolicon" })
myvolicon.image = image(beautiful.widget_vol)
mymusicicon     = widget({ type = "imagebox", name = "mymusicicon"})
mymusicicon.image = image(beautiful.widget_music)
myspacer         = widget({ type = "textbox", name = "myspacer" })
myseparator      = widget({ type = "textbox", name = "myseparator" })
myspacer.text    = " "
myseparator.text = "|"
mydiskicon         = widget({ type = "imagebox", name = "mydiskicon" })
mytimeicon       = widget({ type = "imagebox", name = "mytimeicon" })
mytimeicon.image = image(beautiful.widget_date)
mydiskicon.image   = image(beautiful.widget_fs)
mymemicon       = widget({ type = "imagebox", name = "mymemicon" })
mymemicon.image = image(beautiful.widget_mem)
mybaticon       = widget({ type = "imagebox", name = "mymemicon" })
mybaticon.image = image(beautiful.widget_bat)

-- Calendar
local calendar = nil
local offset = 0

function remove_calendar()
	if calendar ~= nil then
		naughty.destroy(calendar)
		calendar = nil
		offset = 0
		end
	end

function add_calendar(inc_offset)
	remove_calendar()
	local cal = awful.util.pread("~/.bin/generate_calendar.sh")
	calendar = naughty.notify({
		icon=home .."/.cal.png",
		ontop = true, 
		timeout = 0, 
		hover_timeout = 0.5,
	})
end


----datewidget
---- change clockbox for your clock widget (e.g. mytextclock)
datewidget:add_signal("mouse::enter", function()
	add_calendar(0)
end)
datewidget:add_signal("mouse::leave", remove_calendar)



-- Create the wibox
mywibox[s] = awful.wibox({ position = "top", screen = s })
mywibox_bottom[s] = awful.wibox({ position = "bottom", screen = s })
mywibox[s].widgets = {
	{
		mytaglist[s],
        mypromptbox[s],        
        layout = awful.widget.layout.horizontal.rightleft
    },
    mylayoutbox[s],
    datewidget, mytimeicon,
	mailwidget, mailicon,

    
    s == 1 and mysystray or nil,
    myspacer,
--    batwidget,
    bat1widget,bat1graph.widget,myspacer,
    bat0graph.widget,bat0widget,
    mybaticon,
    myspacer,
	fs.h.widget, fs.r.widget, fsicon,
--    fswidget,
--    mydiskicon,
    myspacer,
    myneticonup,
--    netwidget,
    myneticon,
    myspacer,
    cpuwidget,
    mycpuicon,
    myspacer,
    memwidget,
    mymemicon,
	volwidget,
	volbar.widget, volicon,
	musicwidget.widget,
	mymusicicon,
	myspacer,rssbox,

--	mailicon:buttons(mailbuttons),
	--mpdwidget,
    layout = awful.widget.layout.horizontal.rightleft
    }



mywibox_bottom[s].widgets = {
	{
		mylauncher,
		launchbar,
        layout = awful.widget.layout.horizontal.leftright
        },
        --mylayoutbox[s],
        --mytextclock,
		wifi,
        s == 1  or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"   }, "t",             shifty.add),
    awful.key({ modkey, "Shift"   }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Shift"   }, "Right",  shifty.shift_next        ),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn("xterm -e bash -c 'tmux attach -t default'") end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn("xterm -e bash -c 'ssh HOST1 -t tmux attach -t default'") end),
    awful.key({ modkey            }, "Down",                          revelation.revelation),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer sset Master toggle") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset PCM 3dB- unmute") end),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset PCM 3dB+ unmute") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("sudo /usr/bin/backlight -") end),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("sudo /usr/bin/backlight +") end),
    awful.key({ }, "XF86KbdBrightnessDown", function () awful.util.spawn("sudo /usr/bin/kbd_backlight -") end),
    awful.key({ }, "XF86KbdBrightnessUp", function () awful.util.spawn("sudo /usr/bin/kbd_backlight +") end),
    awful.key({ }, "XF86KbdLightOnOff", function () awful.util.spawn("sudo /usr/bin/kbd_backlight toggle") end),
    awful.key({ }, "XF86Display", function () awful.util.spawn("/usr/bin/arandr") end),
    awful.key({ }, "F12", function () awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({ }, "F11", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/ScreenShots/ 2>/dev/null'") end),
    awful.key({ }, "XF86Eject", function () awful.util.spawn("xterm -e bash -c '~/.screenlayout/nokia_lab.sh'") end),
    awful.key({ modkey },            "BackSpace",     function () mypromptbox[mouse.screen]:run() end)


)
clientkeys = awful.util.table.join(awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end))

    awful.key({ modkey           }, "w", function ()
        awful.prompt.run({ prompt = "Urxvt : " }, mypromptbox[mouse.screen].widget,
            function (command)
                awful.util.spawn("urxvtc -e "..command.."", false)
            end)
    end)


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys

-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)
shifty.init()
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- }}}
client.add_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_focus
  end
end)

client.add_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_normal
  end
end)


function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x '" .. prg .. "' || (" .. prg .. ")")
end

-- {{{ functions to help launch run commands in a terminal using ":" keyword
function check_for_terminal (command)
   if command:sub(1,1) == ":" then
      command = terminal .. ' -e ' .. command:sub(2)
   end
   awful.util.spawn(command)
end

function clean_for_completion (command, cur_pos, ncomp, shell)
   local term = false
   if command:sub(1,1) == ":" then
      term = true
      command = command:sub(2)
      cur_pos = cur_pos - 1
   end
   command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
   if term == true then
      command = ':' .. command
      cur_pos = cur_pos + 1
   end
   return command, cur_pos
end


muc_nick = "matthieu@reussner.ch"

function mcabber_event_hook(kind, direction, jid, msg, myicon,domain)
    if kind == "MSG" then
        if direction == "IN" or direction == "MUC" then
            local filehandle = io.open(msg)
            local txt = filehandle:read("*all")
            filehandle:close()
            awful.util.spawn("rm "..msg)
            if direction == "MUC" and txt:match("^<" .. muc_nick .. ">") then
                return
            end
            naughty.notify{
                icon = myicon,
                text = awful.util.escape(txt),
                title = jid
            }
        end
    elseif kind == "STATUS" then
        local mapping = {
            [ "O" ] = "online",
            [ "F" ] = "chat",
            [ "A" ] = "away",
            [ "N" ] = "xa",
            [ "D" ] = "dnd",
            [ "I" ] = "invisible",
            [ "_" ] = "offline",
            [ "?" ] = "error",
            [ "X" ] = "requested"
        }
        local status = mapping[direction]
        local iconstatus = status
        if not status then
            status = "error"
        end
        if jid:match("icq") then
            iconstatus = "icq/" .. status
        end
        naughty.notify{
            preset = naughty.config.presets[status],
            text = jid,
            run = function () 
				awful.tag.viewidx(2)
				awful.util.spawn("xterm -e bash -c 'tmux  select-window -t " .. domain .. "'")
				awful.util.spawn("xterm -e bash -c 'echo roster search " ..jid.. " > " .. home .. "/.mcabber/mcabber.fifo'")
				end,
            icon = myicon
--            icon = iconstatus
        }
    end
end


-- }}}
run_once("xscreensaver")
run_once(home .."/.bin/autorun.sh")
