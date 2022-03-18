--Define variables
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme = {}

--Define paths
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/holo/wall.png"

--Define colors
theme.purple					= "#B16286"
theme.blue					  = "#458588"
theme.red					    = "#CC241D"
theme.gray					  = "#A89984"
theme.green					  = "#98971A"
theme.yellow					= "#D79921"
theme.orange					= "#D65D0E"
theme.white					  = "#FBF1C7"
theme.black					  = "#282828"
theme.black1					= "#3C3836"
theme.black2					= "#504945"
theme.black3					= "#665C54"

--UI Preferences
theme.icon_theme                        				= "Papirus-Dark"
theme.font                                      = "Roboto 11"
theme.taglist_font                              = "Roboto 11"
theme.tasklist_font                             = "Roboto 11"
theme.fg_normal                                 = theme.white
theme.fg_focus                                  = theme.blue
theme.bg_focus                                  = theme.black1
theme.bg_normal                                 = theme.black
theme.fg_urgent                                 = theme.white
theme.bg_urgent                                 = theme.red
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.gray
theme.taglist_fg_focus                          = theme.white
theme.tasklist_bg_normal                        = theme.bg_normal
theme.tasklist_font_focus                       = "Roboto 11"
theme.tasklist_bg_focus                         = theme.black1
theme.tasklist_fg_focus                         = theme.green
theme.menu_height                               = dpi(30)
theme.menu_width                                = dpi(250)
theme.menu_icon_size                            = dpi(12)
theme.useless_gap                               = dpi(0)
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = false



--Icons paths
theme.ac                                        = theme.icon_dir .. "/ac.png"
theme.bat                                       = theme.icon_dir .. "/bat.png"
theme.bat_low                                   = theme.icon_dir .. "/bat_low.png"
theme.bat_no                                    = theme.icon_dir .. "/bat_no.png"
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.vol                                       = theme.icon_dir .. "/vol.png"
theme.vol_low                                   = theme.icon_dir .. "/vol_low.png"
theme.vol_no                                    = theme.icon_dir .. "/vol_no.png"
theme.vol_mute                                  = theme.icon_dir .. "/vol_mute.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"


local markup = lain.util.markup
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup(theme.white, space3 .. "%H:%M" .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_normal, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, theme.white, space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_normal, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(5), dpi(5))
theme.cal = lain.widget.cal({
    attach_to = { mytextclock, mytextcalendar },
    notification_preset = {
        fg = theme.white,
        bg = theme.bg_normal,
        position = "bottom_right",
        font = "Monospace 10"
    }
})

-- Battery
local baticon = wibox.widget.imagebox(theme.bat)
local batbar = wibox.widget {
    forced_height    = dpi(1),
    forced_width     = dpi(59),
    color            = theme.bg_normal,
    background_color = theme.bg_normal,
    margins          = 2,
    paddings         = 1,
    ticks            = false,
    ticks_size       = dpi(1),
    widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.status == "Charging" then
            baticon:set_image(theme.ac)
            if bat_now.perc >= 98 then
                batbar:set_color(theme.green)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.green)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.green)
            else
                batbar:set_color(theme.red)
            end
        else
            if bat_now.perc >= 98 then
                batbar:set_color(theme.green)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.green)
                baticon:set_image(theme.bat)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.red)
                baticon:set_image(theme.bat_low)
            else
                batbar:set_color(theme.red)
                baticon:set_image(theme.bat_no)
            end
        end
        batbar:set_value(bat_now.perc / 100)
    end
})
local batbg = wibox.container.background(batbar, theme.black1, gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, dpi(1), dpi(6), dpi(7), dpi(7))


-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar {
   width = dpi(59), border_width = dpi(5), ticks = false, ticks_size = dpi(1),
   backgroud_color = theme.red, color=theme.red,
    notification_preset = { font = theme.font },
    settings = function()
        if volume_now.status == "off" then
	   volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
	   volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
	   volicon:set_image(theme.vol_low)
        else
	   volicon:set_image(theme.vol)
        end
    end,
    colors = {
        background   = theme.black,
        mute         = theme.red,
        unmute       = theme.blue
    }
}
theme.volume.bar.margins = dpi(2)
theme.volume.tooltip.wibox.fg = theme.fg_focus
theme.volume.bar:buttons(my_table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 2, function()
            os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 3, function()
            os.execute(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 4, function()
            os.execute(string.format("%s set %s 5%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 5, function()
            os.execute(string.format("%s set %s 5%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end)
))
local volumebg = wibox.container.background(theme.volume.bar, theme.black1, gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(1), dpi(6), dpi(7), dpi(7))







-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)



function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = theme.black2 })

    mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rounded_rect)
    s.mytag = wibox.container.margin(mytaglistcont, dpi(6), dpi(6), dpi(2), dpi(3))



    s.mytasklist = awful.widget.tasklist {
       
       list_update,
       screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = awful.util.tasklist_buttons,
    style    = {
       shape_border_width = 2,
        shape_border_color = theme.black3,
        shape  = gears.shape.rounded_rect,
    },
    layout   = {
       spacing = 5,
       max_widget_size=250,
        layout  = wibox.layout.flex.horizontal
    },
    widget_template = {
    {
      {
        {
            {
              id     = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            margins = 9,
            widget  = wibox.container.margin,
          },
        {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 1,
        right = 10,
        top = 0,
        bottom= 0,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,

    },
  }



    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s, border_width=4 ,border_color =theme.bg_normal, bg = theme.bg_normal, height = dpi(30) })
    --s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(3), bg = theme.bg_normal, x = dpi(0), y = dpi(33)})
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
	    mylauncher,
	    first,
            s.mytag,
	    first,
	    s.mypromptbox,
	    first,
        },
	s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
	    volicon,
	    volumewidget,
	    baticon,
	    batwidget,
	    clock_icon,
	    calendarwidget,
            clockwidget,
	    s.mylayoutbox,

        },
    }


end

return theme
