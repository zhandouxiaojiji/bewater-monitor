local skynet = require "skynet"
local conf   = require "conf"

skynet.start(function()
    -- 玩家侦听服务
    skynet.newservice("web/webserver", "gate", 
        "loginsvr", "player", conf.gate.port, conf.gate.preload)

    -- 后台服务
    local c = skynet.newservice("ws/watchdog", "webconsole.webconsole", "webconsole.player_t")
    skynet.call(c, "lua", "start", {
        port = conf.webconsole.port,
        preload = 1,
    })
end)
