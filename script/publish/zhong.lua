local util = require "util"
local conf = require "conf"
conf = util.clone(conf)
conf.remote_host = "zhong@dev.zhongfq.com"
conf.remote_port = 22
conf.remote_path = "/mnt/dev/home/zhong/server/monitor"
conf.etcname = "monitord"
conf.webconsole = {
    host = "dev.zhongfq.com",
    port = 8751,
}
conf.alert = true

return conf
