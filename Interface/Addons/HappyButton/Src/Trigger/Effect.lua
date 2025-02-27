local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')


---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Effect: AceModule
local Effect = addon:NewModule("Effect")

-- 创建边框发光效果
---@param status nil | boolean
---@return EffectConfig
function Effect:NewBorderGlowEffect(status)
    ---@type EffectConfig
    local effect = {
        type = "borderGlow",
        attr = {},
        status = status
    }
    return effect
end


-- 创建图标隐藏效果
---@param status nil | boolean
---@return EffectConfig
function Effect:NewBtnHideEffect(status)
    ---@type EffectConfig
    local effect = {
        type = "btnHide",
        attr = {},
        status = status
    }
    return effect
end


-- 创建图标褪色⚫
---@param status nil | boolean
---@return EffectConfig
function Effect:NewBtnDesaturateEffect(status)
    ---@type EffectConfig
    local effect = {
        type = "btnDesaturate",
        attr = {},
        status = status
    }
    return effect
end

-- 创建图标透明
---@param status nil | boolean
---@return EffectConfig
function Effect:NewBtnAlphaEffect(status)
    ---@type EffectConfig
    local effect = {
        type = "btnAlpha",
        attr = {},
        status = status
    }
    return effect
end

-- 创建图标顶点红色🔴
---@param status nil | boolean
---@return EffectConfig
function Effect:NewBtnVertexColorEffect(status)
    ---@type EffectConfig
    local effect = {
        type = "btnVertexColor",
        attr = {},
        status = status
    }
    return effect
end
