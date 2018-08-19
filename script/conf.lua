local skynet = require "skynet"
local conf = {
    workspace = skynet.getenv('workspace'),

    proj_name = "login",
    gate = {
        host = "127.0.0.1",
        port = 8710,
        preload = 10,
    },
    webconsole = {
        host = "127.0.0.1",
        port = 8711,
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
    
    mysql = {
        host = "127.0.0.1",
        port = 3306,
        name = "test",
    },

    -- 通用节点
    clustername = {
        stop = "127.0.0.1:9999",
    },
    -- 本节点
    cluster = {
        name = "login",
        addr = "127.0.0.1:11120",
    },

    MAX_LOGINING = 10,
}

conf.clustername[conf.cluster.name] = conf.cluster.addr

return conf
