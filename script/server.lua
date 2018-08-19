local skynet = require "skynet.manager"
local cluster = require "skynet.cluster"
local mongo = require "db.mongo_helper"
local mysql = require "db.mysql_helper"
local conf = require "conf"
local util = require "util"
local json = require "cjson"
local errcode = require "def.errcode"

local table_insert = table.insert
local table_remove = table.remove
local table_sort   = table.sort

local auto_id = 1 -- todo redis创建 或 预先配置好

local M = {}
function M:start()
    cluster.reload(conf.clustername)
    cluster.open(conf.cluster.name)
    skynet.register "svr"

    self.nodes = {} -- node_id -> node {node_id, proj_name, host, port}
end

function M:auto_uid()
    local uid = mongo.get("auto_uid", 10000000) + 1
    mongo.set("auto_uid", uid)
    return uid
end

function M:stop()
    skynet.error("monitor will be stoped")
    skynet.timeout(100, function()
        skynet.abort()
    end)
end

-- c_name 节点名    game1
-- c_addr 节点地址  127.0.0.1:5555
function M:node_new(c_name, c_addr, proj_name, host, port)
    skynet.error(c_name, c_addr, proj_name, host, port)
    conf.clustername[c_name] = c_addr 
    cluster.reload(conf.clustername)
    
    local node_id = auto_id
    auto_id = auto_id + 1

    local node = {
        node_id = node_id,
        proj_name = proj_name,
        host = host,
        port = port,
    }
    self.nodes[node_id] = node
    return node.node_id
end

function M:node_ping(node_id)
    skynet.error(string.format("ping from %s online cout:%s", node_id, online))
    return util.NORET
end

return M
