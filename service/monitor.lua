local skynet = require "skynet"
local conf   = require "conf"

skynet.start(function()
    -- 后台服务
    local c = skynet.newservice("ws/watchdog", "webconsole.webconsole", "player.player_t")
    skynet.call(c, "lua", "start", {
        port = conf.webconsole.port,
        preload = 1,
    })
end)
