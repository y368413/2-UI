-- Original authors: gmacro and Lombra's;
-- http://www.wowinterface.com/forums/showthread.php?t=55021
-- Modified by justinleaonsrm
-- https://bbs.nga.cn/read.php?tid=13777553&page=2#pid286621005Anchor
-- And then nestcoffee
--## Author:gmacro & justinleaonsrm & nestcoffee
--[[
CTMB_Settings = CTMB_Settings or {}
CTMB_Settings.loots = CTMB_Settings.loots or {}
--]]

local fontName, fontHeight = GameFontNormal:GetFont()
local ENTRY_HEIGHT, ENTRY_SPACING, CTMB_BUFFER, CTMB_WIDTH, header_desc_string, CTMB_Entrys = fontHeight + 4, 0, 10, 450, "", {}
local UnitExists, UnitClass, CreateFrame, SendChatMessage, ShowUIPanel, GameTooltip, GetMouseFoci, WorldFrame, GetGameTime, UnitInParty, player, RAID_CLASS_COLORS
=	  UnitExists, UnitClass, CreateFrame, SendChatMessage, ShowUIPanel, GameTooltip, GetMouseFoci, WorldFrame, GetGameTime, UnitInParty, ({UnitName("player")})[1], _G["RAID_CLASS_COLORS"]

local CTMB_CFG = {
		myself = false,			-- 是否记录自己的拾取，true 为记录，false则不记录
		maxloots = 20,			-- 记录列表的最大条目数，超出则自动删除最旧的条目
		untradable = false,		-- 是否记录不可交易的物品（比如别人ROLL的或任务物品），true为记录
		minquality = 3,			-- 装备的最低品质，比这高级的才被记录，对应关系见"Quality_List"表
		unequipable = false,		-- 是否记录不可穿戴的物品，设为true可记录材料、图纸等
		autoweakup = true,		-- 是否主动唤醒窗口，false则拾取物品时不会显示窗口，使用/CTMB可启用自动唤醒，右键点击关闭按钮可禁用自动唤醒
}

local Quality_List = {
	[0] = "破烂",
	[1] = "普通",
	[2] = "绿装",
	[3] = "蓝装",
	[4] = "紫装",
	[5] = "橙装",
	[6] = "传说",
	[7] = "传家宝",
}

header_desc_string = header_desc_string .. "自己的拾取：" .. (CTMB_CFG["myself"] and "是；" or "否；")
header_desc_string = header_desc_string .. "\032\032\032\032最大记录数：\032" .. CTMB_CFG["maxloots"] .. "；\n"
header_desc_string = header_desc_string .. "不可交易的：" .. (CTMB_CFG["untradable"] and "是；" or "否；")
header_desc_string = header_desc_string .. "\032\032\032\032最低稀有度：" .. Quality_List[CTMB_CFG["minquality"]] .. "；\n"
header_desc_string = header_desc_string .. "只记录装备：" .. (CTMB_CFG["unequipable"] and "是。" or "否。\n")

-- Shader for entrys --
local function color(unit)
	if not UnitExists(unit) then return ("\124cffff0000%s\124r"):format(unit) end
	local _, class = UnitClass(unit)
	local color = RAID_CLASS_COLORS[class]
	return ("\124cff%02x%02x%02x%s\124r"):format(color.r*255, color.g*255, color.b*255, unit)
end

-- Main Frame --
local CTMB = CreateFrame("Frame", "ComeToMyBag", UIParent,"BackdropTemplate")   -- |cff44CCFF原GMLM|r
--CTMB:Hide()
CTMB:SetClampedToScreen(true)
CTMB:SetFrameStrata("DIALOG")
CTMB:SetMovable(true)
CTMB:SetToplevel(true)
CTMB:SetUserPlaced(true)
CTMB:EnableMouse(true)
tinsert(UISpecialFrames, CTMB:GetName())

CTMB:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
CTMB:SetBackdropColor(.75, .75, .75)
CTMB:SetBackdropBorderColor(0, 1, 1, 1)

CTMB:RegisterEvent('PLAYER_LOGIN')
CTMB:RegisterForDrag("LeftButton")
CTMB:SetScript("OnDragStart", CTMB.StartMoving)
CTMB:SetScript("OnDragStop", CTMB.StopMovingOrSizing)

-- Objects in CTMB --
local close_btn = CreateFrame("Button", nil, CTMB, "UIPanelCloseButton")
close_btn:SetSize(15, 15)
close_btn:SetPoint("TOPRIGHT", -CTMB_BUFFER, -CTMB_BUFFER)
close_btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")

local header_desc = CTMB:CreateFontString()
header_desc:SetPoint("TOPLEFT", CTMB, "TOPLEFT", CTMB_BUFFER, -CTMB_BUFFER)
header_desc:SetFont(fontName, fontHeight)
header_desc:SetTextColor(0, 1, 1, 1)
header_desc:SetText(header_desc_string)
header_desc:SetJustifyH("LEFT")

local howto_desc = CTMB:CreateFontString()
howto_desc:SetPoint("BOTTOMLEFT", CTMB, "BOTTOMLEFT", CTMB_BUFFER, CTMB_BUFFER)
howto_desc:SetFont(fontName, fontHeight)
howto_desc:SetTextColor(0, 1, 1, 1)
howto_desc:SetText("单击装备:毛装")

local reset_desc = CTMB:CreateFontString()
reset_desc:SetPoint("BOTTOMRIGHT", CTMB, "BOTTOMRIGHT", -CTMB_BUFFER, CTMB_BUFFER)
reset_desc:SetFont(fontName, fontHeight)
reset_desc:SetTextColor(0, 1, 1, 1)
reset_desc:SetText("单击此处:重置")

local reset_btn = CreateFrame("Button", nil, CTMB)
reset_btn:SetPoint("BOTTOMRIGHT", reset_desc, "BOTTOMRIGHT", 0, 0)
reset_btn:SetSize(reset_desc:GetWidth() + 2, reset_desc:GetHeight() + 2)
reset_btn:SetHighlightTexture("Interface/QuestFrame/UI-QuestTitleHighlight")

-----------------------------------------------------------Main Function-----------------------------------------------------------
-- Reset List --
function CTMB:Init()
	CTMB_Entrys = {}
	for index = 1, CTMB_CFG["maxloots"] do
		self[index]:SetText("")
		self[index]:Hide()
	end
	self:SetSize(CTMB_WIDTH, CTMB_BUFFER * 4 + fontHeight * 5 + ((ENTRY_HEIGHT + ENTRY_SPACING) - ENTRY_SPACING))
	--print("ComeToMyBag" .. "记录已清除！")
end

-- LeftButton click the close_btn to close CTMB and RightButton click to clear & close --
function close_btn:OnClick(button,down)
	if button == "RightButton" then
		CTMB_CFG["autoweakup"] = false
		print("ComeToMyBag" .. "自动唤醒已\124cffff0000禁用\124r，用宏命令\"/CTMB\"开启。")
	end
	CTMB:Hide()
end

-- LeftButton click the reset_btn to clear list --
function reset_btn:OnClick(button,down)
	CTMB:Init()
end

-- Defines class of entrys --
local Entry = CreateFrame("Button", nil, CTMB)
function Entry:new(entry_obj, index)
	entry_obj = setmetatable(entry_obj or CreateFrame("Button", nil, CTMB), self)
	self.__index = self
	entry_obj.index = index
	entry_obj:SetPoint("TOPLEFT", index == 1 and header_desc or CTMB[index - 1], "BOTTOMLEFT", 0, index == 1 and -CTMB_BUFFER or -ENTRY_SPACING)
	entry_obj:SetPoint("RIGHT", -CTMB_BUFFER, 0)
	entry_obj:SetHeight(ENTRY_HEIGHT)
	entry_obj:SetNormalFontObject("GameFontNormal")
	entry_obj:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	entry_obj:SetScript("OnClick", self.OnClick)
	entry_obj:SetScript("OnEnter", self.OnEnter)
	entry_obj:SetScript("OnLeave", self.OnLeave)
	local text = entry_obj:CreateFontString(nil, nil, "GameFontNormal")
	text:SetAllPoints()
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	text:SetTextColor(1, 1, 1, 1)
	entry_obj:SetFontString(text)
	return entry_obj
end

function Entry:OnClick(button, down)
	SendChatMessage("亲！" .. CTMB_Entrys[self.index]["loot"] .. " 能赏我吗？谢谢！", "WHISPER", nil, CTMB_Entrys[self.index]["unit"])
end

function Entry:OnEnter()
	ShowUIPanel(GameTooltip)
	if not GameTooltip:IsShown() then
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
	end
	GameTooltip:SetHyperlink(CTMB_Entrys[self.index]["loot"])
end

function Entry:OnLeave()
	local focus = GetMouseFoci() and GetMouseFoci()[1] or WorldFrame
	if focus ~= GameTooltip and focus:GetParent() ~= GameTooltip then
		GameTooltip:Hide()
	end
end

-- 抄自这里： https://github.com/Kirri777/DoYouNeedThat/blob/main/Core.lua
local function kirriGetLink(message)
	local LOOT_ITEM_PATTERN = _G.LOOT_ITEM:gsub("%%s", "(.+)")
	local LOOT_ITEM_PUSHED_PATTERN = _G.LOOT_ITEM_PUSHED:gsub("%%s", "(.+)")
	local LOOT_ITEM_MULTIPLE_PATTERN = _G.LOOT_ITEM_MULTIPLE:gsub("%%s", "(.+)")
	local LOOT_ITEM_PUSHED_MULTIPLE_PATTERN = _G.LOOT_ITEM_PUSHED_MULTIPLE:gsub("%%s", "(.+)")
	
    local _, link = message:match(LOOT_ITEM_MULTIPLE_PATTERN)
    if not link then
        _, link = message:match(LOOT_ITEM_PUSHED_MULTIPLE_PATTERN)
        if not link then
            _, link = message:match(LOOT_ITEM_PATTERN)
            if not link then
                _, link = message:match(LOOT_ITEM_PUSHED_PATTERN)
                if not link then
                    return
                end
            end
        end
    end
	
	return link
end

-- Event handle of CTMB --
function CTMB:OnEvent(event, ...)
	local lootstring, _, _, _, unit = ...
	if not unit then return end
	--local desc, itemLink = lootstring:match("([^|]*)(|%x+|Hitem:.-|h.-|h|r)")
	--local isAdditional = lootstring:find("获得了额外奖励") and true or false
	-- 不知道为什么LOOT_ITEM等语言带有句号"。"，而聊天语句里没有
	local itemLink = kirriGetLink(lootstring .. "。")
	if not itemLink then return end
	local isAdditional = lootstring:find("获得了额外奖励") and true or false
	local _, _, quality, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, itemClassID, _, bindType, _, _, _ = C_Item.GetItemInfo(itemLink)
	local isEntry = (CTMB_CFG["myself"] or player ~= unit) and quality >= CTMB_CFG["minquality"] and (CTMB_CFG["unequipable"] or (itemClassID > 1 and itemClassID <= 4 )) and (CTMB_CFG["untradable"] or bindType == 2 or bindType == 3 or UnitInParty(unit) and not isAdditional or player == unit) and true or false
	--[[
	local output = unit .. (UnitInRaid(unit) and "[团队 | " or "[不在团队 | ") .. (UnitInParty(unit) and "小队] " or "不在小队] ") .. itemLink .. (isAdditional and " <额外 - " or " <") .. bindType .. "> " .. ((bindType == 2 or bindType == 3 or (UnitInRaid(unit) or UnitInParty(unit)) and not isAdditional or player == unit) and "pass" or "block")
	print(output)
	print("isEntry:", isEntry)
	CTMB_Settings.loots[#(CTMB_Settings.loots) + 1] = output
	--]]
	if isEntry then
		if #CTMB_Entrys >= CTMB_CFG["maxloots"] then
			table.remove(CTMB_Entrys, 1)
		end
		CTMB_Entrys[#CTMB_Entrys + 1] = {
			unit	= unit,
			loot	= itemLink,
			ilv		= C_Item.GetDetailedItemLevelInfo(itemLink),
			slot	= (_G[itemEquipLoc] ~= nil and _G[itemEquipLoc] ~= "") and _G[itemEquipLoc] or itemSubType
		}
		local numButtons, h, m = #CTMB_Entrys, GetGameTime()
		for index = 1, numButtons do
			self[index]:SetText(h .. ":".. m .. " " .. color(CTMB_Entrys[index]["unit"]) .. " " .. CTMB_Entrys[index]["loot"] .. "<" .. CTMB_Entrys[index]["ilv"].. "-" .. CTMB_Entrys[index]["slot"].. ">")
			self[index]:Show()
			self:SetSize(CTMB_WIDTH, CTMB_BUFFER * 4 + fontHeight * 5 + ((ENTRY_HEIGHT + ENTRY_SPACING) * numButtons - ENTRY_SPACING))
		end
		if CTMB_CFG["autoweakup"] then self:Show() end
	end
end

CTMB:SetScript("OnEvent", function(self, event, ...)
	for index = 1, CTMB_CFG["maxloots"] do
		self[index] = Entry:new(nil, index)
	end
	self:Init()
	self:UnregisterEvent(event)
	self:RegisterEvent('CHAT_MSG_LOOT')
	self:SetScript("OnEvent", self.OnEvent)
	close_btn:SetScript('OnClick', close_btn.OnClick)
	reset_btn:SetScript("OnClick", reset_btn.OnClick)
	print("ComeToMyBag" .. "自动唤醒已" .. (CTMB_CFG["autoweakup"] and "\124cff00ff00开启\124r。" or "\124cffff0000禁用\124r。").."宏命令\"/CTMB\"打开窗口、自动唤醒，右键关闭禁用自动唤醒。")
end)

-- Set Slash --
SLASH_CTMB1 = "/ctmb"
SLASH_CTMB2 = "/CTMB"
SlashCmdList["CTMB"] = function(args)
	if not CTMB:IsShown() then
		CTMB:ClearAllPoints()
		CTMB:SetPoint('CENTER',0,0)
		CTMB:Show()
	end
	if not CTMB_CFG["autoweakup"] then
		print("ComeToMyBag" .. "自动唤醒已\124cff00ff00开启\124r，右键点击关闭按钮可禁用自动唤醒。")
	end
	CTMB_CFG["autoweakup"] = true
end