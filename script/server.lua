local skynet = require "skynet.manager"
local cluster = require "skynet.cluster"
local db = require "db.mongo_helper"
local conf = require "conf"
local util = require "util"
local json = require "cjson"
local log = require "log"

local trace = log.trace("monitor")
local print = log.print("monitor")
local table_insert = table.insert
local table_remove = table.remove
local table_sort   = table.sort

local M = {}
function M:start()
    trace("monitor start!")
    cluster.reload(conf.clustername)
    cluster.open(conf.cluster.name)
    skynet.register "svr"

    self.nodes = {} -- addr -> node
end

function M:stop()
    trace("monitor will be stoped")
    skynet.timeout(100, function()
        skynet.abort()
    end)
end

-- c_name 节点名    game1
-- c_addr 节点地址  127.0.0.1:5555
function M:node_start(c_name, c_addr, proj_name, host, port)
    local addr = c_addr
    print(c_name, c_addr, proj_name, host, port)
    conf.clustername[c_name] = c_addr 
    cluster.reload(conf.clustername)

    self.nodes[addr] = {
        proj_name   = proj_name,
        c_name      = c_name,
        c_addr      = c_addr,
        host        = host,
        port        = port, 
        cpu         = 0,
        mem         = 0,
    }
end

function M:node_ping(addr, cpu, mem)
    trace("ping from %s %s %s", addr, cpu, mem)
    return util.NORET
end

function M:node_stop(addr)
    return util.NORET
end

return M
