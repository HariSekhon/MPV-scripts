--
--  Author: Hari Sekhon
--  Date: 2026-06-14 23:33:03 +0100 (Sun, 14 Jun 2026)
--
--  vim:ts=4:sts=4:sw=4:et
--
--  https///github.com/HariSekhon/MPV-Scripts
--
--  License: see accompanying Hari Sekhon LICENSE file
--
--  If you're using my code you're welcome to connect with me on LinkedIn
--  and optionally send me feedback
--
--  https://www.linkedin.com/in/HariSekhon
--
--

-- ========================================================================== --
--                         M a x i m i z e   W i n d o w
-- ========================================================================== --

-- Automatically maximizes the mpv window without entering fullscreen which annoying;y slow on Macs due to fancy effects
-- (equivalent to double-clicking the title bar on most window managers)
--
-- Also adds key binding Shift-M to toggle this maximize

local mp = require 'mp'
local msg = require("mp.msg")

local script_name = mp.get_script_name()
msg.info(script_name .. " script loaded")

mp.register_event("file-loaded", function()
    mp.add_timeout(0.5, function()
        msg.info("setting window-maximized property to true")
        mp.set_property_native("window-maximized", true)
    end)
end)

local function toggle_maximize()
    -- mpv exposes this on supported windowing systems
    local maximized = mp.get_property_native("window-maximized")

    if maximized ~= nil then
        mp.set_property_native("window-maximized", not maximized)
        return
    end

    mp.osd_message("window-maximized property not supported")
    msg.warn("window-maximized property not supported")
end

mp.add_key_binding("M", "toggle-maximize", toggle_maximize)
