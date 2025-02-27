---@meta _
---@class HappyButton : AceAddon
HappyButton = {}

--- 注册事件
---@param event string
---@param func function
function HappyButton:RegisterMessage(event, func) end

--- 发送事件
---@param event string
function HappyButton:SendMessage(event, ...) end


-- 注册命令
---@param commandName string 命令名称
---@param funcName string 命令函数
function HappyButton:RegisterChatCommand(commandName, funcName)end