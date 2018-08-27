local errcode = {}                                                                                                                                                                                                                       
local code2describe = {}
local name2errcode = {}

local function REG(err_name, code, describe)
    assert(not code2describe[code], string.format("errcode 0x%x exist", code))
    name2errcode[err_name] = code
    code2describe[code] = string.format("%s", describe)
end

function errcode.describe(code)
    return code2describe[code]
end

setmetatable(errcode, {__index = function (_, name)
    return assert(name2errcode[name], name)
end})


REG("OK",                   0x0000, "执行成功")
REG("LoginBusy",            0x0001, "服务器忙！")
REG("ServerNotLaunch",      0x0002, "服役器未启动！")
REG("AccountExist",         0x0003, "该账号已经注册！")
REG("SignError",            0x0004, "签名错误")

REG("Traceback",            0xa000, "服务器报错！")

return errcode
