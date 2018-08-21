--
-- $id: opcode.lua 🐔 $
--
-- 协议号规范
-- 0x0000 ~ 0x00ff 客户端自已给自己发
-- 0x0100 ~ 0x0fff 服务器给客户端发
-- 0x1000 ~ 0x4fff 与游戏服之间的rpc
-- 0x5000 ~ 0x9fff 与国战服之间的rpc
-- 0xa000 ~ 0xbfff 与登陆服之间的rpc
-- 0xb000 ~ 0xcfff 玩家离线操作

local opcode = {}
local code2name = {}
local code2module = {}
local code2simplename = {}
local code2no_session = {}
local code2urlrequest = {}

local NOSESSION = true
local function REG(code, message_name, urlrequest, no_session)
    assert(not code2name[code], string.format("code 0x%x exist", code))

    local namespace = opcode
    for v in string.gmatch(message_name, "([^.]+)[.]") do
        namespace[v] = rawget(namespace, v) or setmetatable({}, {
            __index = function(_, k) error(k) end})
        namespace = namespace[v]
    end

    namespace[string.match(message_name, "[%w_]+$")] = code
    code2name[code] = message_name
    code2urlrequest[code] = urlrequest
    code2no_session[code] = no_session 
    code2module[code] = string.lower(string.match(message_name, "^[^.]+"))
    code2simplename[code] = string.match(message_name, "[^.]+$")
end

function opcode.toname(code)
    return code2name[code]
end

function opcode.tomodule(code)
    return code2module[code]
end

function opcode.tosimplename(code)
    return code2simplename[code]
end

function opcode.has_session(code)
    return not code2no_session[code]
end

function opcode.urlrequest(code)
    return code2urlrequest[code]
end

return opcode
