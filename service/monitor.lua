local skynet = require "skynet"
local conf   = require "conf"
local util   = require "util"
local server = require "server"

skynet.start(function()
    server:start()

    -- 后台服务
    local c = skynet.newservice("ws/watchdog", "webconsole.webconsole", "player.player_t")
    skynet.call(c, "lua", "start", {
        port = conf.webconsole.port,
        preload = 1,
    })

    skynet.dispatch("lua", function(_,_, cmd, ...)
        local f = assert(server[cmd], cmd)
        util.ret(f(server, ...))
    end)

end)
