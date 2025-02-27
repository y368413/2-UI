local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Api: AceModule
local Api = addon:GetModule("Api")


---@class AttachFrameCache: AceModule
---@field cache table<string, Frame>
local AttachFrameCache = addon:NewModule("AttachFrameCache")


function AttachFrameCache:Initial()
    AttachFrameCache.cache = {}
end

---@param frameName string
---@param frame Frame
function AttachFrameCache:Add(frameName, frame)
    if AttachFrameCache.cache[frameName] ~= frame and frameName ~= const.ATTACH_FRAME.UIParent then
        AttachFrameCache.cache[frameName] = frame
        frame:HookScript("OnShow", function(_)
            addon:SendMessage(const.EVENT.HB_FRAME_CHANGE, frameName)
        end)
        frame:HookScript("OnHide", function(_)
            addon:SendMessage(const.EVENT.HB_FRAME_CHANGE, frameName)
        end)
    end
end