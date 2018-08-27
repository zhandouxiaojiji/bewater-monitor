local skynet = require "skynet"
local class = require "class"
local log = require "log"
local trace = log.trace("webconsole")

local M = class("player_monitor_t")
function M:ctor(player)
    self.player = player
end

function M:c2s_nodes()
    local nodes = skynet.call("svr", "lua", "get_nodes") 
    local list = {}
    for _, v in pairs(nodes) do
        list[#list+1] = {
            proj        = v.proj,
            c_name      = v.c_name,
            c_addr      = v.c_addr,
            pnet_addr   = v.pnet_addr,
            inet_addr   = v.inet_addr,
            cpu         = string.format("%.1f", v.cpu)..'%',
            mem         = string.format("%.1fM", v.mem/1024),
            pid         = v.pid,
            webconsole  = v.webconsole,
        }        
    end
    return {nodes = list}
end

return M
