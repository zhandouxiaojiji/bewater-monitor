local util = require "util"
local conf = require "conf"
conf = util.clone(conf)
conf.remote_host = "localhost"
conf.remote_port = 22
conf.remote_path = "/home/huangjx/test_server/monitor"
conf.etcname = "monitord"
conf.clustername = "monitor"
conf.cluster = {
    monitor = "127.0.0.1:19900",
    share   = "127.0.0.1:19901",
}
conf.mongo = {
    host = "127.0.0.1",
    name = "test",
    port = 19999,
}
conf.redis = {
    host = "127.0.0.1",
    port = 19998,
}
conf.webconsole = {
    host = "www.kaizhan8.com",
    port = 8700,
}
return conf
