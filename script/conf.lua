local skynet = require "skynet"
local conf = {
    workspace = skynet.getenv('workspace'),

    proj = "monitor",
    webconsole = {
        host = "www.kaizhan8.com",
        port = 8701,
    },

    mongo = {
        host = "127.0.0.1",
        name = "test",
        port = 8799,
    },
    redis = {
        host = "127.0.0.1",
        port = 6378,
        preload = 10,
    },
    whitelist = true,

    -- 通用节点
    cluster = {
        stop    = "127.0.0.1:9999",
        monitor = "127.0.0.1:9998",
        share   = "127.0.0.1:9997",
    },

    alert = { 
        --enable      = true,
        corpid      = 'dingbf0f32a0c5a10f0735c2f4657eb6378f',
        corpsecret  = 'E-69ZUSz-6ZizoXNoOLc0HEdiJ6VZb1AXJ5mGPSgjxDVKeMQ2h6YQfhLvWDxGwa9',
        sender      = 'manager3375',
        chatid      = 'chatc342986381ccae6028a690369580d9d0',
    },

    MAX_LOGINING = 10,
}

return conf
