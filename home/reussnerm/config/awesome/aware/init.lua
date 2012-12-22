-- aware : a feed reader for awesome
-- (c) 2009 olcc

-- environment
local pairs = pairs
local io = { popen = io.popen }
local widget = widget
local string = { find = string.find, rep = string.rep, sub = string.sub, gsub = string.gsub }
local timer = timer
local awful = awful

-- awareness is the key
module("aware")

local awidget       -- handle of widget
local ttip          -- handle of tooltip
local afeeds        -- feeds to track
local anews = {}    -- contents
local current = {}  -- useful for updates
local scr = {}      -- scrolling datas
local sets = {}     -- settings

-- {{{ Small tools
-- {{ string processing (preserves unicode and xml escaped chars)
local function cut_begin(str, n)
    local out = awful.util.unescape(str)
    out = out:sub(n, out:len())
    -- preserve multi-byte chars
    out = out:match("^[^%w%s%p]?([%w%s%p].*)") or out 

    return awful.util.escape(out)
end

local function cut_end(str, n)
    local out = awful.util.unescape(str)
    out = out:sub(1,n)
    -- preserve multi-byte chars
    out = out:match("(.*[%w%s])") 

    return awful.util.escape(out)
end
-- }}
-- {{ data cleaning

-- makes sure we don't display crap
local function cleandisp(str)
    -- don't flood wibox
    if str:len() >  sets.siz and str and not sets.scroll then
	str = cut_end(str, sets.siz - 3)
	str = str .. "..."
    end

    -- insert spaces to distinguish news in scroller
    if sets.scroll and str then
	str = string.rep(" ", sets.spacing) .. str
    end

    return str or ""
end

-- makes sure we don't provide crappy links
-- (primarily for google links)
local function cleanlink(str)
    return '"' .. string.gsub(str, "&amp;", "\&") .. '"'
end

-- }}
-- }}}

-- {{{ Main tools
-- {{ extract informations from a formatted content
local function parse(str)
    local hfields = { "title", "lastBuildDate" }
    local bfields = { "title", "link", "description", "pubDate" }
    local out = {}
    out.len = 0
    local i,k

    -- head
    out.head = {}
    local hstr
    _,_,hstr = str:find("(.*)<item>", 1)
    if hstr then
	for _,v in pairs(hfields) do
	    out.head[v] = hstr:match("<" .. v .. ">(.-)</" .. v .. ">")
	end
    end

    -- body
    out.body = {}
    for _, v in pairs(bfields) do
	out.body[v] = {}
    end

    i,k = 1,0
    while true do
	local ob
	_,i,ob = str:find("<item>(.-)</item>", i)
	if not ob then break end
	for _, v in pairs(bfields) do
	    local st = ob:match("<" .. v .. ">(.-)</" .. v .. ">")
	    -- some feeds use this (yahoo)
	    if st then
		out.body[v][k] = st:match("<!%[CDATA%[(.-)]]>") or st
	    end
	end
	k = k+1
	i = i+1
    end
    out.len = k

    return out
end
-- }}
-- {{ downloading functions

-- d/l and process one feed
local function retrieve(url)
    local curl = "curl -A 'Mozilla/4.0' -fsm 5 --connect-timeout 3 "

    local f = io.popen( curl .. '"' .. url .. '"' )
    local rss = f:read("*all")
    f:close()

    return parse(rss)
end

-- d/l every feeds
local function getf()
    for k,v in pairs(afeeds) do
	anews[k-1] = retrieve(v)
    end
    anews.len = # afeeds
end
-- }}
-- {{ scroller
local function scroll()
    local str

    if not scr.str then str = current.title
    else str = scr.str end

    if str then
	-- crop first letter (scr.i set to 2 by default)
	str = cut_begin(str, scr.i)
	-- use news to fill space
	while str and str:len() < sets.siz do
	    current.id = (current.id + 1) % anews[current.feed].len
	    current.url = cleanlink(anews[current.feed].body.link[current.id])
	    str = str .. cleandisp(anews[current.feed].body.title[current.id])
	end
	scr.str = str or ""
	-- crop to keep wibox clean
	str = cut_end(str, sets.siz)
    end
    awidget.text = str
end

-- }}
-- }}}

-- {{{ Exported functions

-- provides a link
function link()
    return current.url
end

-- register to a widget
function register(wid, feed, set)
    awidget = wid
    afeeds = feed

    -- settings
    if set then
	sets.autodl = set.autodl or true     -- enable auto-dl
	sets.scroll = set.scroll or false    -- scrolling
	sets.tip = set.tip or true           -- enable tooltip
	sets.dltime = set.dltime or 607      -- seconds between two d/l
	sets.siz = set.siz or 50             -- size of wibox
	sets.spacing = set.spacing or 5      -- spacing for scroller
	sets.speed = set.speed or 1          -- scroll speed
    else
	sets.autodl = true
	sets.scroll = false
	sets.tip = true
	sets.dltime = 607
	sets.siz = 50
	sets.spacing = 5
	sets.speed = 1
    end

    if sets.scroll then
	scr.i = 2
	local cscroll = timer { timeout = sets.speed }
	cscroll:add_signal("timeout", function () scroll() end)
	cscroll:start()
    end
    if sets.autodl then
	local cclock = timer { timeout = sets.dltime }
	cclock:add_signal("timeout", function () 
	    getf() 
	    update("+0+0")
	end)
	cclock:start()
    end
    if sets.tip then
	ttip = awful.tooltip({
	    objects = {awidget},
	    timer_function = function()
		if anews then
		    return anews[current.feed].head.title .. '\n' .. 
		    anews[current.feed].body.title[current.id]
		else return '' end
	    end
	})
    end

    getf()
    update("=0=0")
end

-- update display
function update(param)
    local i_feed,feed,i_id,id = param:match("([=%+%-]?)(%d*)([=%+%-])(%d*)")

    if feed and id then
	if i_feed == "=" or not i_feed then
	    current.feed = feed % anews.len
	elseif i_feed == "\+" then
	    current.feed = (current.feed + feed) % anews.len
	else 
	    current.feed = (current.feed - feed) % anews.len
	end

	if i_id == "=" then
	    current.id = id % anews[current.feed].len
	elseif i_id == "\+" then
	    current.id = (current.id + id) % anews[current.feed].len
	else 
	    current.id = (current.id - id) % anews[current.feed].len
	end
    end

    if anews[current.feed] and anews[current.feed].len ~= 0 then
	current.title = cleandisp(anews[current.feed].body.title[current.id])
	current.url = cleanlink(anews[current.feed].body.link[current.id])

	if sets.scroll then
	    scroll()
	else
	    awidget.text = current.title
	end
    else
	current.title = ""
	current.url = ""
	awidget.text = ""
    end
end

-- }}}

