local skynet        = require "skynet.manager"
local cluster       = require "skynet.cluster"
local clusterinfo   = require "clusterinfo"
local db            = require "db.mongo_helper"
local conf          = require "conf"
local util          = require "util"
local json          = require "cjson"
local sname         = require "sname"
local log           = require "log"

local trace = log.trace("monitor")
local print = log.print("monitor")
local table_insert = table.insert
local table_remove = table.remove
local table_sort   = table.sort

local TIMEOUT = 2

local M = {}
function M:start()
    trace("monitor start!")
    cluster.reload(conf.cluster)
    cluster.open(clusterinfo.clustername)
    skynet.register "svr"

    self.nodes = {} -- addr -> node

    skynet.fork(function()
        while true do
            for addr, node in pairs(self.nodes) do
                if not node.istimeout and os.time() - node.timestamp > TIMEOUT  then
                    trace("node %s is timeout", addr)
                    node.istimeout = true 
                    if conf.alert and conf.alert.enable then
                        skynet.send(sname.ALERT, "lua", "node_dead", node.proj, node.c_name, node.pnet_addr, 
                            node.inet_addr, node.pid, node.cpu, node.mem)
                    end
                end
            end
            skynet.sleep(10)
        end
    end)
end

function M:stop()
    trace("monitor will be stoped")
    skynet.timeout(100, function()
        skynet.abort()
    end)
end

function M:get_nodes()
    return self.nodes
end

-- c_name 节点名    game1
-- c_addr 节点地址  127.0.0.1:5555
function M:node_start(c_name, c_addr, proj, pnet_addr, inet_addr, pid, webconsole)
    local addr = c_addr
    print(c_name, c_addr, proj, pnet_addr, inet_addr)
    conf.cluster[c_name] = c_addr 
    cluster.reload(conf.cluster)

    self.nodes[addr] = {
        proj        = proj,
        c_name      = c_name,
        c_addr      = c_addr,
        pnet_addr   = pnet_addr,
        inet_addr   = inet_addr, 
        cpu         = 0,
        mem         = 0,
        pid         = pid,
        webconsole  = webconsole,
        timestamp   = os.time(),
    }
end

function M:node_ping(addr, cpu, mem)
    trace("ping from %s %s %s", addr, cpu, mem)
    local node = self.nodes[addr]
    if not node then
        return
    end
    node.timestamp = os.time() 
    node.cpu = cpu
    node.mem = mem
    return util.NORET
end

function M:node_stop(addr)
    return util.NORET
end

return M
