--- @class DialogKeyNS ## Version: v1.2.7 ## Author: Numy (previous verions by: Foxthorn, N01ch, FuriousProgrammer)
local DialogKeyNS = {}

if GetLocale() == "zhCN" then
  DialogKeyLocal = "|cffe6cc80[弹窗]|r快捷对话";
elseif GetLocale() == "zhTW" then
  DialogKeyLocal = "|cffe6cc80[弹窗]|r快捷对话";
else
  DialogKeyLocal = "DialogKey";
end

DialogKeyNS.configPanelName = DialogKeyLocal
DialogKeyNS.defaultOptions = {
    keys = {
        "SPACE",
    },
    ignoreDisabledButtons = false,
    ignoreWithModifier = false,
    showGlow = false,
    dialogBlacklist = {},
    customFrames = {},
    numKeysForGossip = true,
    numKeysForQuestRewards = true,
    dontClickSummons = true,
    dontClickDuels = true,
    dontClickRevives = true,
    dontClickReleases = true,
    dontAcceptInvite = true,
    useSoulstoneRez = true,
    handleCraftingOrders = true,
    handlePlayerChoice = true,
    numKeysForPlayerChoice = true,
    postAuctions = false,
}

--- @param dialogKey DialogKey
function DialogKeyNS:InitDB(dialogKey)
    for k, v in pairs(self.defaultOptions) do
        if dialogKey.db[k] == nil then dialogKey.db[k] = v end
    end
    if select(2, next(dialogKey.db.customFrames)) == true then -- unordered list
        local i = 1
        for k, _ in pairs(dialogKey.db.customFrames) do
            dialogKey.db.customFrames[k] = i
            i = i + 1
        end
    end

    -- check for gaps
    self:GuardAgainstGaps()
end

function DialogKeyNS:GuardAgainstGaps()
    local db = self.Core.db
    local count = 0
    for _, _ in pairs(db.customFrames) do
        count = count + 1
    end
    DialogKeyNS.orderedCustomFrames = tInvert(db.customFrames)
    local orderedCount = 0
    for _, _ in ipairs(DialogKeyNS.orderedCustomFrames) do -- ipairs stops at the first gap
        orderedCount = orderedCount + 1
    end
    if count ~= orderedCount then
        for i = 1, count do
            if DialogKeyNS.orderedCustomFrames[i] == nil then
                local j = i + 1
                while j < i+100 do -- exit after 100, to avoid infinite loops in case of issues
                    if DialogKeyNS.orderedCustomFrames[j] then
                        DialogKeyNS.orderedCustomFrames[i] = DialogKeyNS.orderedCustomFrames[j]
                        DialogKeyNS.orderedCustomFrames[j] = nil
                        db.customFrames[DialogKeyNS.orderedCustomFrames[i]] = i
                        break
                    end
                    j = j + 1
                end
            end
        end
        DialogKeyNS.orderedCustomFrames = tInvert(db.customFrames)
    end
end

function DialogKeyNS:RemoveFromWatchlist(frameName)
    local db = self.Core.db
    local index = db.customFrames[frameName]
    if not index then return end
    tremove(self.orderedCustomFrames, index)
    db.customFrames[frameName] = nil

    for i = index, #self.orderedCustomFrames do
        db.customFrames[self.orderedCustomFrames[i]] = i
    end
    self:RegisterOptions()
end

function DialogKeyNS:AddToWatchlist(frameName)
    local db = self.Core.db
    if db.customFrames[frameName] then return end
    tinsert(self.orderedCustomFrames, frameName)
    db.customFrames[frameName] = #self.orderedCustomFrames
    self:RegisterOptions()
end

local arrowNext = C_Texture.GetAtlasInfo('common-dropdown-icon-next')
local arrowBack = C_Texture.GetAtlasInfo('common-dropdown-icon-back')
local cross = C_Texture.GetAtlasInfo('Radial_Wheel_Icon_Close')
local search = C_Texture.GetAtlasInfo('common-search-magnifyingglass')
local width_multiplier = 170

-- only want this for toggles
local function wrapName(name)
    return "|cffffd100" .. name .. "|r"
end

------- hack to allow tooltips to work on nameless execute icons
local MAGIC_TOOLTIP_TEXTS = {
    up = 'DialogKey_Numy_MagicTooltipUp',
    down = 'DialogKey_Numy_MagicTooltipDown',
    remove = 'DialogKey_Numy_MagicTooltipRemove',
    glow = 'DialogKey_Numy_MagicTooltipGlow',
}
do
    local lastSetOwnerCall
    local ACDTooltip = LibStub("AceConfigDialog-3.0").tooltip
    hooksecurefunc(ACDTooltip, 'SetOwner', function(_, ...)
        lastSetOwnerCall = {...}
    end)
    hooksecurefunc(ACDTooltip, 'AddLine', function(tooltip, text, r, g, b, wrap)
        local title, desc
        if text == MAGIC_TOOLTIP_TEXTS.up then
            title = "上移"
            desc = "在优先级列表中将框架向上移动"
        elseif text == MAGIC_TOOLTIP_TEXTS.down then
            title = "下移"
            desc = "在优先级列表中将框架向下移动"
        elseif text == MAGIC_TOOLTIP_TEXTS.remove then
            title = "移除"
            desc = "从自定义监视列表中移除框架"
        elseif text == MAGIC_TOOLTIP_TEXTS.glow then
            title = "查找"
            desc = "在框架周围显示短暂的发光效果，使其更易找到"
        end
        if title then
            -- setting text to an empty string seems to clear the owner and effectively resets the tooltip :/
            tooltip:SetOwner(unpack(lastSetOwnerCall))
            tooltip:SetText(title, 1, .82, 0, true)
            tooltip:AddLine(desc, r, g, b, wrap)
        end
    end)
end

local initialized = false
function DialogKeyNS:RegisterOptions()
    if not initialized then
        initialized = true
        LibStub("AceConfig-3.0"):RegisterOptionsTable(self.configPanelName, function() return self:GetOptionsTable() end)
        LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.configPanelName)
    else
        LibStub("AceConfigRegistry-3.0"):NotifyChange(self.configPanelName)
    end
end

function DialogKeyNS:GetOptionsTable()
    local db = self.Core.db
    local function optionSetter(info, val) db[info[#info]] = val end
    local function optionGetter(info) return db[info[#info]] end
    local function swapWatchlistFrames(index1, index2)
        local frame1 = self.orderedCustomFrames[index1]
        local frame2 = self.orderedCustomFrames[index2]
        if not frame1 or not frame2 then return end

        self.orderedCustomFrames[index1] = frame2
        self.orderedCustomFrames[index2] = frame1
        db.customFrames[frame1] = index2
        db.customFrames[frame2] = index1

        self:RegisterOptions()
    end

    local increment = CreateCounter()
    local options = {
        type = "group",
        set = optionSetter,
        get = optionGetter,
        name = self.configPanelName,
        args = {
            header1 = {
                order = increment(),
                name = "主要按键绑定",
                type = "header",
            },
            key1 = {
                order = increment(),
                name = "",
                type = "keybinding",
                set = (function(_, val) db.keys[1] = val end),
                get = (function(_) return db.keys[1] end),
            },
            key2 = {
                order = increment(),
                name = "",
                type = "keybinding",
                set = (function(_, val) db.keys[2] = val end),
                get = (function(_) return db.keys[2] end),
            },
            header2 = {
                order = increment(),
                name = "选项",
                type = "header",
            },
            generalGroup = {
                order = increment(),
                name = "通用",
                desc = "设置基本的个人偏好选项",
                type = "group",
                args = {
                    showGlow = {
                        order = increment(),
                        name = wrapName("启用发光"),
                        desc = "当按钮被快捷点击时显示发光效果。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    ignoreWithModifier = {
                        order = increment(),
                        name = wrapName("忽略带有控制键的DialogKey"),
                        desc = "当任何控制键（Shift、Alt、Ctrl）被按下时禁用快捷点击。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    ignoreDisabledButtons = {
                        order = increment(),
                        name = wrapName("忽略禁用的按钮"),
                        desc = "不允许快捷点击禁用的（灰色的）按钮。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    numKeysForGossip = {
                        order = increment(),
                        name = wrapName("为对话选项设置数字键"),
                        desc = "使用数字键（1到0）从NPC对话窗口中选择对话选项或任务。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    numKeysForQuestRewards = {
                        order = increment(),
                        name = wrapName("为任务奖励设置数字键"),
                        desc = "当有多个任务奖励可供选择时，使用数字键（1到0）来选择任务奖励。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    postAuctions = {
                        order = increment(),
                        name = wrapName("拍卖邮件"),
                        desc = "拍卖邮件",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    handleCraftingOrders = {
                        order = increment(),
                        name = wrapName("制造订单"),
                        desc = "处理制造订单：启动、制作、完成。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    handlePlayerChoice = {
                        order = increment(),
                        name = wrapName("玩家选择"),
                        desc = "使用按键绑定来选择第一个玩家选择选项。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    numKeysForPlayerChoice = {
                        order = increment(),
                        name = wrapName("为对话选项设置数字键"),
                        desc = "使用数字键（1到0）来选择玩家选择选项。",
                        disabled = function() return not db.handlePlayerChoice end,
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                },
            },
            --priorityGroup = {
            --    order = increment(),
            --    name = "Priority",
            --    desc = "Advanced Options to control DialogKey button priority",
            --    type = "group",
            --    args = {
            -- todo: some way to set priority between built-in frames, not sure whether I'd like a list of all custom frames
            --       and built-in frames intermixed in that list, or have <custom watchlist frames> as an item in a "master" list
            --       the 2nd option is far far simpler, but also less flexible. but then again, do we *need* so much flexibility?
            --    },
            --},
            watchlistGroup = {
                order = increment(),
                name = "自定义监控列表",
                desc = "快捷对话插件尝试点击的自定义按钮列表。",
                type = "group",
                args = {
                    desc = {
                        order = increment(),
                        name = [[
你可以在这里添加自定义框架，以便使用你的按键绑定来“点击”。
只需输入要处理的框架的名称，或者将鼠标悬停在框架上并写下“/dialogkey add”即可在鼠标下的框架中添加。

如果你在寻找名称时遇到困难，尝试使用“/fstack”，按下ALT键直到你找到想要突出显示的框架。如果名称中包含随机的字母和数字(例如："GameMenuFrame.2722d8f518")，那么这个框架就不能被快捷点击。
]],
                        type = "description",
                        fontSize = "medium",
                    },
                    addFrame = {
                        order = increment(),
                        type = "input",
                        name = "添加一个框架到监控",
                        width = "full",
                        set = function(_, value)
                            self:AddToWatchlist(value)
                        end,
                    },
                    priority = self:CreateCustomFramesPriorityListOptions(increment(), swapWatchlistFrames),
                },
            },
            popupBlacklistGroup = {
                order = increment(),
                name = "弹出框黑名单",
                desc = "快捷对话完全忽略的弹出对话框列表。",
                type = "group",
                args = {
                    dontAcceptInvite = {
                        order = increment(),
                        name = wrapName("不接受组队邀请"),
                        desc = "不允许快捷点击接受团队/小队邀请。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    dontClickSummons = {
                        order = increment(),
                        name = wrapName("不接受召唤"),
                        desc = "不允许快捷点击接受召唤请求。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    dontClickDuels = {
                        order = increment(),
                        name = wrapName("不接受决斗"),
                        desc = "不允许快捷点击接受决斗邀请。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    dontClickRevives = {
                        order = increment(),
                        name = wrapName("不接受复活"),
                        desc = "不允许快捷点击接受复活。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    dontClickReleases = {
                        order = increment(),
                        name = wrapName("不要释放灵魂"),
                        desc = "不允许快捷点击释放灵魂。",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    useSoulstoneRez = {
                        order = increment(),
                        name = wrapName("使用职业专属复活"),
                        desc = "使用灵魂石/生命符/复生等职业专属复活。当这些复活可用时，不使用普通复活和战斗内复活。\n\n这个选项会|cffff0000忽略|r|cffffd100不接受复活|r 设置！",
                        descStyle = "inline", width = "full", type = "toggle",
                    },
                    desc = {
                        order = increment(),
                        name = [[
在这里，你可以创建一个自定义的弹出窗口列表，快捷对话将忽略这些窗口。
只需添加出现在弹出窗口中的（部分）文本，插件就会忽略它。
]],
                        type = "description",
                        fontSize = "medium",
                    },
                    addText = {
                        order = increment(),
                        type = "input",
                        name = "添加想忽略的文本",
                        width = "full",
                        set = function(_, value)
                            db.dialogBlacklist[value] = true
                        end,
                    },
                    removeText = {
                        order = increment(),
                        type = "select",
                        style = "dropdown",
                        name = "移除已忽略的文本",
                        width = "full",
                        values = function()
                            local tempTable = {}
                            if not next(db.dialogBlacklist) then
                                return { [''] = ' * 目前没有文本被忽略 *' }
                            end
                            for text, _ in pairs(db.dialogBlacklist) do
                                tempTable[text] = text
                            end
                            return tempTable
                        end,
                        get = function(_, _) return false end,
                        set = function(_, index, ...)
                            db.dialogBlacklist[index] = nil
                        end,
                    },
                    listOfTexts = {
                        order = increment(),
                        type = "description",
                        name = function()
                            local text = wrapName("目前被忽略的文本：") .. "\n"
                            for k, _ in pairs(db.dialogBlacklist) do
                                text = text .. " - " .. k .. "\n"
                            end
                            return text
                        end,
                    },
                },
            },
        },
    }

    return options
end

function DialogKeyNS:CreateCustomFramesPriorityListOptions(order, swapWatchlistFrames)
    local increment = CreateCounter()
    local options = {
        order = order,
        name = "管理目前监控的框架",
        type = "group",
        inline = true,
        args = {
            header = {
                order = increment(),
                name = "如果有多个框架可见，列表中位置最靠上的那个将被点击。",
                type = "description",
                width = "full",
            },
        },
    };
    if #self.orderedCustomFrames == 0 then
        options.args.noFrames = {
            order = increment(),
            name = " * 当前没有框架被监控。 * ",
            type = "description",
            fontSize = "medium",
            width = "full",
        };

        return options;
    end
    for i, frame in ipairs(self.orderedCustomFrames) do
        options.args["glow" .. i] = {
            order = increment(),
            name = "",
            desc = MAGIC_TOOLTIP_TEXTS.glow,
            disabled = function() return not self.Core:GetFrameByName(frame) end,
            type = "execute",
            func = function()
                local frameRef = self.Core:GetFrameByName(frame)
                if not frameRef then return end
                self.Core:Glow(frameRef, 0.25, true)
            end,
            image = search.file,
            imageWidth = 16,
            imageHeight = 16,
            imageCoords = {
                search.leftTexCoord, search.rightTexCoord, search.topTexCoord, search.bottomTexCoord,
            },
            width = 26 / width_multiplier,
        };
        options.args["name" .. i] = {
            order = increment(),
            name = frame,
            type = "description",
            fontSize = "medium",
            width = (400 - 30 * 3) / width_multiplier,
        };
        options.args["up" .. i] = {
            order = increment(),
            name = "",
            desc = MAGIC_TOOLTIP_TEXTS.up,
            type = "execute",
            disabled = function() return i == 1 end,
            func = function()
                swapWatchlistFrames(i, i - 1)
            end,
            image = arrowBack.file,
            imageWidth = 16,
            imageHeight = 16,
            imageCoords = {
                arrowBack.leftTexCoord, arrowBack.bottomTexCoord, -- UL
                arrowBack.rightTexCoord, arrowBack.bottomTexCoord, -- LL
                arrowBack.leftTexCoord, arrowBack.topTexCoord, -- UR
                arrowBack.rightTexCoord, arrowBack.topTexCoord, -- LR
            },
            width = 26 / width_multiplier,
        };
        options.args["down" .. i] = {
            order = increment(),
            type = "execute",
            name = "",
            desc = MAGIC_TOOLTIP_TEXTS.down,
            disabled = function() return i == #self.orderedCustomFrames end,
            func = function()
                swapWatchlistFrames(i, i + 1)
            end,
            image = arrowNext.file,
            imageWidth = 16,
            imageHeight = 16,
            width = 26 / width_multiplier,
            imageCoords = {
                arrowNext.leftTexCoord, arrowNext.bottomTexCoord, -- UL
                arrowNext.rightTexCoord, arrowNext.bottomTexCoord, -- LL
                arrowNext.leftTexCoord, arrowNext.topTexCoord, -- UR
                arrowNext.rightTexCoord, arrowNext.topTexCoord, -- LR
            },
        };
        options.args["delete" .. i] = {
            order = increment(),
            name = "",
            desc = MAGIC_TOOLTIP_TEXTS.remove,
            type = "execute",
            func = function()
                self:RemoveFromWatchlist(frame)
            end,
            image = cross.file,
            imageWidth = 16,
            imageHeight = 16,
            imageCoords = {
                cross.leftTexCoord, cross.rightTexCoord, cross.topTexCoord, cross.bottomTexCoord,
            },
            width = 26 / width_multiplier,
        };
    end

    return options;
end

local name = DialogKeyLocal

local GetMouseFoci = GetMouseFoci or function() return { GetMouseFocus() } end
local GetFrameMetatable = _G.GetFrameMetatable or function() return getmetatable(CreateFrame('FRAME')) end

_G.DialogKeyNS = DialogKeyNS -- expose ourselves to the world :)

--- @class DialogKey: AceAddon, AceEvent-3.0, AceHook-3.0
local DialogKey = LibStub("AceAddon-3.0"):NewAddon(name, "AceEvent-3.0", "AceHook-3.0")
DialogKeyNS.Core = DialogKey

local defaultPopupBlacklist = { -- If a popup dialog contains one of these strings, don't click it
    AREA_SPIRIT_HEAL, -- Prevents cancelling the resurrection
    TOO_MANY_LUA_ERRORS,
    END_BOUND_TRADEABLE, -- Probably quite reasonable to make the user click on this one
    ADDON_ACTION_FORBIDDEN, -- Don't disable and reload UI on errors
}

local function callFrameMethod(frame, method, ...)
    local functionRef = frame[method] or GetFrameMetatable().__index[method] or nop;
    local ok, result = pcall(functionRef, frame, ...);

    return ok and result or false
end
--- @return string?
local function getFrameName(frame)
    return callFrameMethod(frame, 'GetDebugName') ---@diagnostic disable-line: return-type-mismatch
        or callFrameMethod(frame, 'GetName')
end
---@return Frame?
function DialogKey:GetFrameByName(frameName)
    local frameTable = _G;

    for keyName in string.gmatch(frameName, "([^.]+)") do
        if not frameTable[keyName] then return nil; end

        frameTable = frameTable[keyName];
    end

    return frameTable;
end

--- @type Button[]
DialogKey.playerChoiceButtons = {}
DialogKey.activeOverrideBindings = {}

function DialogKey:OnInitialize()
    DialogKeyNumyDB = DialogKeyNumyDB or {}
    self.db = DialogKeyNumyDB
    DialogKeyNS:InitDB(self)

    self:InitGlowFrame()

    self:RegisterEvent("GOSSIP_SHOW")
    self:RegisterEvent("QUEST_GREETING")
    self:RegisterEvent("QUEST_COMPLETE")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("ADDON_LOADED")

    self:InitMainProxyFrame()

    self:SecureHook("QuestInfoItem_OnClick", "SelectItemReward")
    self:SecureHook(GossipFrame, "Update", "OnGossipFrameUpdate")

    DialogKeyNS:RegisterOptions()

    _G.SLASH_DIALOGKEY1 = '/dialogkey'
    _G.SLASH_DIALOGKEY2 = '/dkey'
    _G.SLASH_DIALOGKEY3 = '/dk'
    SlashCmdList['DIALOGKEY'] = function(msg)
        local func, args = strsplit(" ", msg, 2)
        if func == 'add' then
            self:AddFrame(args)
        elseif func == 'remove' then
            self:RemoveFrame(args)
        else
            Settings.OpenToCategory(DialogKeyNS.configPanelName)
        end
    end
end

function DialogKey:ADDON_LOADED(_, addon)
    if addon == 'Blizzard_PlayerChoice' then
        self:SecureHook(PlayerChoiceFrame, "TryShow", "OnPlayerChoiceShow")
        self:SecureHookScript(PlayerChoiceFrame, "OnHide", "OnPlayerChoiceHide")
    end
end

function DialogKey:QUEST_COMPLETE()
    self.itemChoice = (GetNumQuestChoices() > 1 and -1 or 1)
end

function DialogKey:GOSSIP_SHOW()
    RunNextFrame(function() self:EnumerateGossips(true) end)
end

function DialogKey:QUEST_GREETING()
    RunNextFrame(function() self:EnumerateGossips(false) end)
end

function DialogKey:PLAYER_REGEN_DISABLED()
    -- Disable DialogKey fully upon entering combat
    self.frame:SetPropagateKeyboardInput(true)
    self:ClearOverrideBindings()
end

function DialogKey:InitGlowFrame()
    self.glowFrame = CreateFrame("Frame", nil, UIParent)
    self.glowFrame:SetPoint("CENTER", 0, 0)
    self.glowFrame:SetFrameStrata("TOOLTIP")
    self.glowFrame:SetSize(50,50)
    self.glowFrame:SetScript("OnUpdate", function(...) self:GlowFrameUpdate(...) end)
    self.glowFrame:Hide()
    self.glowFrame.tex = self.glowFrame:CreateTexture()
    self.glowFrame.tex:SetAllPoints()
    self.glowFrame.tex:SetColorTexture(1,1,0,0.5)
end

function DialogKey:InitMainProxyFrame()
    local frame = CreateFrame("Button", "DialogKey_Numy_MainClickProxyFrame", UIParent, "InsecureActionButtonTemplate")
    frame:RegisterForClicks("AnyUp", "AnyDown")
    frame:SetAttribute("type", "click")
    frame:SetAttribute("typerelease", "click")
    frame:SetAttribute("pressAndHoldAction", "1")
    frame:SetScript("PreClick", function()
        if InCombatLockdown() then return end
        self:ClearOverrideBindings(frame)
        local clickButton = frame:GetAttribute("clickbutton")
        self:Glow(clickButton)
    end)
    frame:HookScript("OnClick", function()
        if InCombatLockdown() then return end
        frame:SetAttribute("clickbutton", nil)
        frame:SetPropagateKeyboardInput(true)
    end)
    frame:SetScript("OnKeyDown", function(_, ...) self:HandleKey(...) end)
    frame:SetFrameStrata("TOOLTIP") -- Ensure we receive keyboard events first
    frame:EnableKeyboard(true)
    frame:SetPropagateKeyboardInput(true)

    self.frame = frame
end

function DialogKey:OnPlayerChoiceShow()
    if not self.db.handlePlayerChoice then return end
    local frame = PlayerChoiceFrame;
    if not frame or not frame:IsVisible() then return end

    local choiceInfo = C_PlayerChoice.GetCurrentPlayerChoiceInfo()
    if not choiceInfo then return end
    local buttons = {}
    local i = 0
    for _, option in ipairs(choiceInfo.options) do
        for _, button in ipairs(option.buttons) do
            i = i + 1
            buttons[button.id] = i
        end
    end

    for option in frame.optionPools:EnumerateActive() do
        for button in option.buttons.buttonPool:EnumerateActive() do
            local key = buttons[button.buttonID]
            if self.db.numKeysForPlayerChoice then
                button.Text:SetText(key .. ' ' .. button.Text:GetText())
            end
            self.playerChoiceButtons[key] = button
        end
    end
end

function DialogKey:OnPlayerChoiceHide()
    self.playerChoiceButtons = {}
end

-- Prefix list of GossipFrame options with 1., 2., 3. etc.
--- @param gossipFrame GossipFrame
function DialogKey:OnGossipFrameUpdate(gossipFrame)
    if not self.db.numKeysForGossip then return end
    local scrollbox = gossipFrame.GreetingPanel.ScrollBox

    local n = 1
    for _, frame in scrollbox:EnumerateFrames() do
        local data = frame.GetElementData and frame:GetElementData()
        local tag
        if data.buttonType == GOSSIP_BUTTON_TYPE_OPTION then
            tag = "name"
        elseif data.buttonType == GOSSIP_BUTTON_TYPE_ACTIVE_QUEST or data.buttonType == GOSSIP_BUTTON_TYPE_AVAILABLE_QUEST then
            tag = "title"
        end
        if tag then
            frame:SetText((n % 10) .. ". " .. data.info[tag])
            frame:SetHeight(frame:GetFontString():GetHeight() + 2)
            n = n + 1
        end
        if n > 10 then break end
    end
    local oldScale = scrollbox:GetScale()
    scrollbox:SetScale(oldScale + 0.002) -- trigger OnSizeChanged
    RunNextFrame(function() scrollbox:SetScale(oldScale) end) -- OnSizeChanged only fires if the size actually changed at the end of the frame
end

--- @return StaticPopupTemplate|nil
function DialogKey:GetFirstVisiblePopup()
    for i = 1, 4 do
        local popup = _G["StaticPopup"..i]
        if popup and popup:IsVisible() then
            return popup
        end
    end
end

--- @param frame Button
function DialogKey:GuardDisabled(frame)
    if not self.db.ignoreDisabledButtons then return true; end

    return frame:IsEnabled() and frame:IsMouseClickEnabled();
end

--- @return Button|nil
function DialogKey:GetFirstVisibleCustomFrame()
    for _, frameName in ipairs(DialogKeyNS.orderedCustomFrames) do
        local frame = self:GetFrameByName(frameName)
        if frame and frame:IsVisible() and frame:IsObjectType('Button') and self:GuardDisabled(frame) then
            return frame ---@diagnostic disable-line: return-type-mismatch
        end
    end
end

--- @return Button|nil
function DialogKey:GetFirstVisibleCraftingOrderFrame()
    if not self.db.handleCraftingOrders then return; end
    local frames = {
        "ProfessionsFrame.OrdersPage.OrderView.OrderInfo.StartOrderButton",
        "ProfessionsFrame.OrdersPage.OrderView.CreateButton",
        "ProfessionsFrame.OrdersPage.OrderView.CompleteOrderButton",
    };
    for _, frameName in ipairs(frames) do
        --- @type Button?
        local frame = self:GetFrameByName(frameName) ---@diagnostic disable-line: assign-type-mismatch
        if frame and frame:IsVisible() and self:GuardDisabled(frame) then
            return frame
        end
    end
end

function DialogKey:ShouldIgnoreInput()
    if InCombatLockdown() then return true end

    if self.db.ignoreWithModifier and (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()) then return true end
    -- Ignore input while typing, unless at the Send Mail confirmation while typing into it!
    local focus = GetCurrentKeyBoardFocus()
    if focus and not (self:GetFirstVisiblePopup() and (focus:GetName() == "SendMailNameEditBox" or focus:GetName() == "SendMailSubjectEditBox")) then return true end

    if
        -- Ignore input if there's nothing for DialogKey to click
        not GossipFrame:IsVisible() and not QuestFrame:IsVisible() and not self:GetFirstVisiblePopup()
        -- Ignore input if the Auction House sell frame is not open
        and (not AuctionHouseFrame or not AuctionHouseFrame:IsVisible())
        and not self:GetFirstVisibleCraftingOrderFrame()
        -- Ignore input if no custom frames are visible
        and not self:GetFirstVisibleCustomFrame()
        -- Ignore input if no player choice buttons are visible
        and not next(self.playerChoiceButtons)
    then
        return true
    end

    return false
end

-- Primary functions --

-- Takes a global string like '%s has challenged you to a duel.' and converts it to a format suitable for string.find
local summon_match = CONFIRM_SUMMON:gsub("%%d", ".+"):format(".+", ".+", ".+")
local duel_match = DUEL_REQUESTED:format(".+")
local resurrect_match = RESURRECT_REQUEST_NO_SICKNESS:format(".+")
local groupinvite_match = INVITATION:format(".+")

--- @param popupFrame StaticPopupTemplate # One of the StaticPopup1-4 frames
--- @return Frame|nil|false # The button to click, nil if no button should be clicked, false if the text is empty and should be checked again later
function DialogKey:GetPopupButton(popupFrame)
    local text = popupFrame.text:GetText()

    -- Some popups have no text when they initially show, and instead get text applied OnUpdate (summons are an example)
    -- False is returned in that case, so we know to keep checking OnUpdate
    if not text or text == " " or text == "" then return false end

    -- Don't accept group invitations if the option is enabled
    if self.db.dontAcceptInvite and text:find(groupinvite_match) then return end

    -- Don't accept summons/duels/resurrects if the options are enabled
    if self.db.dontClickSummons and text:find(summon_match) then return end
    if self.db.dontClickDuels and text:find(duel_match) then return end

    -- If resurrect dialog has three buttons, and the option is enabled, use the middle one instead of the first one (soulstone, etc.)
    -- Located before resurrect/release checks/returns so it happens even if you have releases/revives disabled
    -- Also, Check if Button2 is visible instead of Button3 since Recap is always 3; 2 is hidden if you can't soulstone rez

    -- the ordering here means that a revive will be taken before a battle rez before a release.
    -- if revives are disabled but soulstone battlerezzes *aren't*, nothing will happen if both are available!
    local canRelease = popupFrame.button1:GetText() == DEATH_RELEASE
    if self.db.useSoulstoneRez and canRelease and popupFrame.button2:IsVisible() then
        return popupFrame.button2
    end

    if self.db.dontClickRevives and (text == RECOVER_CORPSE or text:find(resurrect_match)) then return end
    if self.db.dontClickReleases and canRelease then return end

    -- Ignore blacklisted popup dialogs!
    local lowerCaseText = text:lower()
    for blacklistText, _ in pairs(self.db.dialogBlacklist) do
        -- Prepend non-alphabetical characters with '%' to escape them
        blacklistText = blacklistText:gsub("%W", "%%%0"):gsub("%%%%s", ".+")
        if lowerCaseText:find(blacklistText:lower()) then return end
    end

    for _, blacklistText in pairs(defaultPopupBlacklist) do
        -- Prepend non-alphabetical characters with '%' to escape them
        -- Replace %s and %d with .+ to match any string or number
        -- Trim whitespaces
        blacklistText = blacklistText:gsub("%W", "%%%0"):gsub("%%%%s", ".+"):gsub("%%%%d", ".+"):gsub("^%s*(.-)%s*$", "%1")
        if lowerCaseText:find(blacklistText:lower()) then
            return
        end
    end

    return popupFrame.button1:IsVisible() and popupFrame.button1
end

-- Clears all override bindings associated with an owner, clears all override bindings if no owner is passed
--- @param owner Frame?
function DialogKey:ClearOverrideBindings(owner)
    if InCombatLockdown() then return end
    if not owner then
        for owner, _ in pairs(self.activeOverrideBindings) do
            self:ClearOverrideBindings(owner)
        end
        return
    end
    if not self.activeOverrideBindings[owner] then return end
    for key in pairs(self.activeOverrideBindings[owner]) do
        SetOverrideBinding(owner, false, key, nil)
    end
    self.activeOverrideBindings[owner] = nil
end

-- Set an override click binding, these bindings can safely perform secure actions
-- Override bindings, are temporary keybinds, which can only be modified out of combat; they are tied to an owner, and need to be cleared when the target is hidden
--- @param owner Frame
--- @param targetName string
--- @param keys string[]
function DialogKey:SetOverrideBindings(owner, targetName, keys)
    if InCombatLockdown() then return end
    self.activeOverrideBindings[owner] = {}
    for _, key in pairs(keys) do
        self.activeOverrideBindings[owner][key] = owner;
        SetOverrideBindingClick(owner, false, key, targetName, 'LeftButton');
    end
end

function DialogKey:SetClickbuttonBinding(frame, key)
    if InCombatLockdown() then return end
    self.frame:SetAttribute("clickbutton", frame)
    self:SetOverrideBindings(self.frame, self.frame:GetName(), {key})

    -- just in case something goes horribly wrong, we do NOT want to get the user stuck in a situation where the keyboard stops working
    RunNextFrame(function() self:ClearOverrideBindings(self.frame) end)
end

function DialogKey:HandleKey(key)
    if not InCombatLockdown() then self.frame:SetPropagateKeyboardInput(true) end
    local doAction = (key == self.db.keys[1] or key == self.db.keys[2])
    local keynum = doAction and 1 or tonumber(key)
    if key == "0" then
        keynum = 10
    end
    if not doAction and not keynum then return end
    if self:ShouldIgnoreInput() then return end
    -- DialogKey pressed, interact with popups, accepts..
    if doAction then
        -- Popups
        local popupFrame = self:GetFirstVisiblePopup()
        local popupButton = popupFrame and self:GetPopupButton(popupFrame)
        if popupButton then
            self:SetClickbuttonBinding(popupButton, key)
            return
        end

        -- Crafting Orders
        local craftingOrderFrame = self:GetFirstVisibleCraftingOrderFrame()
        if craftingOrderFrame then
            self:SetClickbuttonBinding(craftingOrderFrame, key)
            return
        end

        -- Custom Frames
        local customFrame = self:GetFirstVisibleCustomFrame()
        if customFrame then
            self:SetClickbuttonBinding(customFrame, key)
            return
        end

        -- Auction House
        if self.db.postAuctions and AuctionHouseFrame and AuctionHouseFrame:IsVisible() then
            if AuctionHouseFrame.displayMode == AuctionHouseFrameDisplayMode.CommoditiesSell then
                self:SetClickbuttonBinding(AuctionHouseFrame.CommoditiesSellFrame.PostButton, key)
                return
            elseif AuctionHouseFrame.displayMode == AuctionHouseFrameDisplayMode.ItemSell then
                self:SetClickbuttonBinding(AuctionHouseFrame.ItemSellFrame.PostButton, key)
                return
            end
        end

        -- Complete Quest
        if QuestFrameProgressPanel:IsVisible() then
            if not QuestFrameCompleteButton:IsEnabled() and self.db.ignoreDisabledButtons then
                -- click "Cencel" button when "Complete" is disabled on progress panel
                self:SetClickbuttonBinding(QuestFrameGoodbyeButton, key)
            else
                self:SetClickbuttonBinding(QuestFrameCompleteButton, key)
            end
            return
        -- Accept Quest
        elseif QuestFrameDetailPanel:IsVisible() then
            self:SetClickbuttonBinding(QuestFrameAcceptButton, key)
            return
        -- Take Quest Reward - using manual API
        elseif QuestFrameRewardPanel:IsVisible() then
            self.frame:SetPropagateKeyboardInput(false)
            if self.itemChoice == -1 and GetNumQuestChoices() > 1 then
                QuestChooseRewardError()
            else
                self:Glow(QuestFrameCompleteQuestButton)
                GetQuestReward(self.itemChoice)
            end
            return
        end
    end

    -- Player Choice
    if self.db.handlePlayerChoice and next(self.playerChoiceButtons) and (doAction or self.db.numKeysForPlayerChoice) then
        local button = self.playerChoiceButtons[keynum]
        if button and (not self.db.ignoreDisabledButtons or button:IsEnabled()) then
            self:SetClickbuttonBinding(button, key)
            return
        end
    end

    -- GossipFrame
    if (doAction or self.db.numKeysForGossip) and GossipFrame.GreetingPanel:IsVisible() then
        while keynum and keynum > 0 and keynum <= #self.frames do
            local choice = self.frames[keynum] and self.frames[keynum].GetElementData and self.frames[keynum].GetElementData()
            -- Skip grey quest (active but not completed) when pressing DialogKey
            if doAction and choice and choice.info and choice.info.questID and choice.activeQuestButton and not choice.info.isComplete and self.db.ignoreDisabledButtons then
                keynum = keynum + 1
            else
                self:SetClickbuttonBinding(self.frames[keynum], key)
                return
            end
        end
    end

    -- QuestFrame
    if (doAction or self.db.numKeysForGossip) and QuestFrameGreetingPanel:IsVisible() and self.frame then
        while keynum and keynum > 0 and keynum <= #self.frames do
            local _, is_complete = GetActiveTitle(keynum)
            if doAction and not is_complete and self.frames[keynum].isActive == 1 and self.db.ignoreDisabledButtons then
                keynum = keynum + 1
                if keynum > #self.frames then
                    doAction = false
                    keynum = 1
                end
            else
                self:SetClickbuttonBinding(self.frames[keynum], key)
                return
            end
        end
    end

    -- QuestReward Frame (select item)
    if self.db.numKeysForQuestRewards and keynum and keynum <= GetNumQuestChoices() and QuestFrameRewardPanel:IsVisible() then
        self.itemChoice = keynum
        self:SetClickbuttonBinding(GetClickFrame("QuestInfoRewardsFrameQuestInfoItem" .. key), key)
        return
    end
end

-- QuestInfoItem_OnClick secure handler
-- allows DialogKey to update the selected quest reward when clicked as opposed to using a keybind.
function DialogKey:SelectItemReward()
    for i = 1, GetNumQuestChoices() do
        if GetClickFrame("QuestInfoRewardsFrameQuestInfoItem" .. i):IsMouseOver() then
            self.itemChoice = i
            break
        end
    end
end

-- Prefix list of QuestGreetingFrame(!!) options with 1., 2., 3. etc.
-- Also builds DialogKey.frames, used to click said options
function DialogKey:EnumerateGossips(isGossipFrame)
    if not ( QuestFrameGreetingPanel:IsVisible() or GossipFrame.GreetingPanel:IsVisible() ) then return end

    self.frames = {}
    if isGossipFrame then
        for _, child in pairs{ GossipFrame.GreetingPanel.ScrollBox.ScrollTarget:GetChildren() } do
            if child:GetObjectType() == "Button" and child:IsVisible() then
                table.insert(self.frames, child)
            end
        end
    else
        if QuestFrameGreetingPanel and QuestFrameGreetingPanel.titleButtonPool then
            for tab in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do
                if tab:GetObjectType() == "Button" then
                    table.insert(self.frames, tab)
                end
            end
        elseif QuestFrameGreetingPanel and not QuestFrameGreetingPanel.titleButtonPool then
            for _, child in ipairs({ QuestGreetingScrollChildFrame:GetChildren() }) do
                if child:GetObjectType() == "Button" and child:IsVisible() then
                    table.insert(self.frames, child)
                end
            end
        else
            return
        end
    end

    table.sort(self.frames, function(a,b)
        if a.GetOrderIndex then
            return a:GetOrderIndex() < b:GetOrderIndex()
        else
            return a:GetTop() > b:GetTop()
        end
    end)

    if self.db.numKeysForGossip and not isGossipFrame then
        for i, frame in ipairs(self.frames) do
            if i > 10 then break end
            frame:SetText((i % 10) .. ". " .. frame:GetText())

            -- Make the button taller if the text inside is wrapped to multiple lines
            frame:SetHeight(frame:GetFontString():GetHeight() + 2)
        end
    end
end

-- Glow Functions --
--- @param frame Frame
--- @param speedModifier number # increasing this number will speed up the fade out of the glow
--- @param forceShow boolean # if true, the glow will be shown regardless of the showGlow setting
function DialogKey:Glow(frame, speedModifier, forceShow)
    if self.db.showGlow or forceShow then
        self.glowFrame:SetAllPoints(frame)
        self.glowFrame.tex:SetColorTexture(1,1,0,0.5)
        self.glowFrame:Show()
        self.glowFrame:SetAlpha(1)
        self.glowFrame.speedModifier = speedModifier or 1
    end
end

-- Fades out the glow frame
function DialogKey:GlowFrameUpdate(frame, delta)
    local alpha = frame:GetAlpha() - (delta * 3 * frame.speedModifier)
    if alpha < 0 then
        alpha = 0
    end
    frame:SetAlpha(alpha)
    if frame:GetAlpha() <= 0 then frame:Hide() end
end

function DialogKey:print(...)
    print("|cffd2b48c[快捷对话]|r ", ...)
end

function DialogKey:AddFrame(frameName)
    local frame
    if not frameName then
        frame, frameName = self:GetFrameUnderCursor()
    else
        frame = self:GetFrameByName(frameName)
    end

    if not frame then
        self:print("在你的鼠标下方没有找到可以点击的框架。尝试使用 /fstack 命令查找框架的名称，并使用 /dialogkey add <frameName> 手动添加它。")
        return
    end

    if self.db.customFrames[frameName] then
        self:print("该框架已经在监控列表中：", frameName)
        self:Glow(frame, 0.25, true)
        return
    end
    DialogKeyNS:AddToWatchlist(frameName)
    self:Glow(frame, 0.25, true)
    self:print("已添加框架：", frameName, "。你可以使用 /dialogkey remove 命令来移除它；或者在选项界面中进行操作。")
end

function DialogKey:RemoveFrame(frameName)
    local frame
    if not frameName then
        frame, frameName = self:GetFrameUnderCursor()
    else
        frame = self:GetFrameByName(frameName)
    end

    if not frame then
        self:print("在你的鼠标下方没有找到可以点击的框架。尝试使用 /fstack 命令来查找框架的名称，并使用 /dialogkey remove <frameName> 手动移除它。")
        return
    end
    local index = self.db.customFrames[frameName]
    if not index then
        self:print("鼠标下的可点击框架不在自定义监视列表中：", frameName)
        self:Glow(frame, 0.25, true)
        return
    end

    DialogKeyNS:RemoveFromWatchlist(frameName)
    self:Glow(frame, 0.25, true)
    self:print("已移除框架：", frameName)
end

--- Returns the first clickable frame that has mouse focus
--- @return Frame?, string? # The frame under the cursor, and its name; or nil
function DialogKey:GetFrameUnderCursor()
    for _, frame in ipairs(GetMouseFoci()) do
        if
            frame ~= WorldFrame
            and frame ~= UIParent
            and not callFrameMethod(frame, 'IsForbidden')
            and callFrameMethod(frame, 'HasScript', 'OnClick')
            and getFrameName(frame)
            and self:GetFrameByName(getFrameName(frame))
        then
            return frame, getFrameName(frame);
        end
    end
end
