local skynet = require "skynet"
local class = require "class"
local log = require "log"
local trace = log.trace("webconsole")

local M = class("player_monitor_t")
function M:ctor(player)
    self.player = player
end

return M
