local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("Chat")

local maxLines = 2048
local maxWidth, maxHeight = UIParent:GetWidth(), UIParent:GetHeight()
local tostring, pairs, ipairs, strsub, strlower = tostring, pairs, ipairs, string.sub, string.lower
local IsInGroup, IsInRaid, IsPartyLFG, IsInGuild, IsShiftKeyDown, IsControlKeyDown = IsInGroup, IsInRaid, IsPartyLFG, IsInGuild, IsShiftKeyDown, IsControlKeyDown
local ChatEdit_UpdateHeader, GetChannelList, GetCVar, SetCVar, Ambiguate = ChatEdit_UpdateHeader, GetChannelList, GetCVar, SetCVar, Ambiguate
local GetNumGuildMembers, GetGuildRosterInfo, IsGuildMember, UnitIsGroupLeader, UnitIsGroupAssistant = GetNumGuildMembers, GetGuildRosterInfo, IsGuildMember, UnitIsGroupLeader, UnitIsGroupAssistant
local CanCooperateWithGameAccount, BNInviteFriend, BNFeaturesEnabledAndConnected = CanCooperateWithGameAccount, BNInviteFriend, BNFeaturesEnabledAndConnected
local C_BattleNet_GetAccountInfoByID = C_BattleNet.GetAccountInfoByID
local InviteToGroup = C_PartyInfo.InviteUnit

function module:TabSetAlpha(alpha)
	if alpha ~= 1 and (not self.isDocked or GeneralDockManager.selected:GetID() == self:GetID()) then
		self:SetAlpha(1)
	elseif alpha < .2 then
		self:SetAlpha(.2)
	end
end

local isScaling = false
function module:UpdateChatSize()
	if not MaoRUIPerDB["Chat"]["Lock"] then return end
	if isScaling then return end
	isScaling = true

	if ChatFrame1:IsMovable() then
		ChatFrame1:SetUserPlaced(true)
	end
	if ChatFrame1.FontStringContainer then
		ChatFrame1.FontStringContainer:SetOutside(ChatFrame1)
	end
	if ChatFrame1:IsShown() then
		ChatFrame1:Hide()
		ChatFrame1:Show()
	end
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 21)
	ChatFrame1:SetWidth(MaoRUIPerDB["Chat"]["ChatWidth"])
	ChatFrame1:SetHeight(MaoRUIPerDB["Chat"]["ChatHeight"])
	local bg = ChatFrame1.gradientBG
	if bg then
		bg:SetHeight(MaoRUIPerDB["Chat"]["ChatHeight"] + 30)
	end
	isScaling = false
end

function module:SkinChat()
	if not self or (self and self.styled) then return end

	local name = self:GetName()
	local fontStyle, fontSize, _= self:GetFont()
	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetMaxResize(maxWidth, maxHeight)
	self:SetMinResize(120, 60)
	if MaoRUIPerDB["Chat"]["Outline"] then
	  self:SetFont(I.Font[1], fontSize, "OUTLINE")
	else
	  self:SetFont(fontStyle, fontSize)
	  self:SetShadowOffset(1, -1)
	end
	self:SetShadowColor(0, 0, 0, 0)
	self:SetClampRectInsets(0, 0, 0, 0)
	self:SetClampedToScreen(false)
	if self:GetMaxLines() < maxLines then
		self:SetMaxLines(maxLines)
	end

	local eb = _G[name.."EditBox"]
	eb:SetAltArrowKeyMode(false)
	eb:ClearAllPoints()
	eb:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 2, 21)
	eb:SetPoint("TOPRIGHT", self, "TOPRIGHT", -12, 43)
	M.SetBD(eb)
	for i = 3, 8 do
		select(i, eb:GetRegions()):SetAlpha(0)
	end

	local lang = _G[name.."EditBoxLanguage"]
	lang:GetRegions():SetAlpha(0)
	lang:SetPoint("TOPLEFT", eb, "TOPRIGHT", 2, 0)
	lang:SetPoint("BOTTOMRIGHT", eb, "BOTTOMRIGHT", 21, 0)
	M.SetBD(lang)

	local tab = _G[name.."Tab"]
	tab:SetAlpha(0.2)
	local tabFs = tab:GetFontString()
	tabFs:SetFont(I.Font[1], I.Font[2]+2, I.Font[3])
	tabFs:SetShadowColor(0, 0, 0, 0)
	tabFs:SetTextColor(1, .8, 0)
	M.StripTextures(tab, 0)
	hooksecurefunc(tab, "SetAlpha", module.TabSetAlpha)

	--if MaoRUIPerDB["Chat"]["Lock"] then M.StripTextures(self) end
	M.HideObject(self.buttonFrame)
	M.HideObject(self.ScrollBar)
	M.HideObject(self.ScrollToBottomButton)

	self.oldAlpha = self.oldAlpha or 0 -- fix blizz error, need reviewed

	self.styled = true
end

-- Swith channels by Tab
local cycles = {
	{ chatType = "SAY", use = function() return 1 end },
    { chatType = "PARTY", use = function() return IsInGroup() end },
    { chatType = "RAID", use = function() return IsInRaid() end },
    { chatType = "INSTANCE_CHAT", use = function() return IsPartyLFG() end },
    { chatType = "GUILD", use = function() return IsInGuild() end },
	{ chatType = "CHANNEL", use = function(_, editbox)
		if GetCVar("portal") ~= "CN" then return false end
		local channels, inWorldChannel, number = {GetChannelList()}
		for i = 1, #channels do
			if channels[i] == "大脚世界频道" then
				inWorldChannel = true
				number = channels[i-1]
				break
			end
		end
		if inWorldChannel then
			editbox:SetAttribute("channelTarget", number)
			return true
		else
			return false
		end
	end },
    { chatType = "SAY", use = function() return 1 end },
}

function module:UpdateTabChannelSwitch()
	if strsub(tostring(self:GetText()), 1, 1) == "/" then return end
    local currChatType = self:GetAttribute("chatType")
    for i, curr in ipairs(cycles) do
        if curr.chatType == currChatType then
            local h, r, step = i+1, #cycles, 1
            if IsShiftKeyDown() then h, r, step = i-1, 1, -1 end
            for j = h, r, step do
                if cycles[j]:use(self, currChatType) then
                    self:SetAttribute("chatType", cycles[j].chatType)
                    ChatEdit_UpdateHeader(self)
                    return
                end
            end
        end
    end
end
hooksecurefunc("ChatEdit_CustomTabPressed", module.UpdateTabChannelSwitch)

-- Quick Scroll
function module:QuickMouseScroll(dir)
	if dir > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			self:ScrollUp()
			self:ScrollUp()
		end
	else
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			self:ScrollDown()
			self:ScrollDown()
		end
	end
end
hooksecurefunc("FloatingChatFrame_OnMouseScroll", module.QuickMouseScroll)

-- Autoinvite by whisper
local whisperList = {}
function module:UpdateWhisperList()
	M.SplitList(whisperList, MaoRUIPerDB["Chat"]["Keyword"], true)
end

function module:IsUnitInGuild(unitName)
	if not unitName then return end
	for i = 1, GetNumGuildMembers() do
		local name = GetGuildRosterInfo(i)
		if name and Ambiguate(name, "none") == Ambiguate(unitName, "none") then
			return true
		end
	end

	return false
end

function module.OnChatWhisper(event, ...)
	local msg, author, _, _, _, _, _, _, _, _, _, guid, presenceID = ...
	for word in pairs(whisperList) do
		if (not IsInGroup() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and strlower(msg) == strlower(word) then
			if event == "CHAT_MSG_BN_WHISPER" then
				local accountInfo = C_BattleNet_GetAccountInfoByID(presenceID)
				if accountInfo then
					local gameAccountInfo = accountInfo.gameAccountInfo
					local gameID = gameAccountInfo.gameAccountID
					if gameID then
						local charName = gameAccountInfo.characterName
						local realmName = gameAccountInfo.realmName
						if CanCooperateWithGameAccount(accountInfo) and (not MaoRUIPerDB["Chat"]["GuildInvite"] or module:IsUnitInGuild(charName.."-"..realmName)) then
							BNInviteFriend(gameID)
						end
					end
				end
			else
				if not MaoRUIPerDB["Chat"]["GuildInvite"] or IsGuildMember(guid) then
					InviteToGroup(author)
				end
			end
		end
	end
end

function module:WhisperInvite()
	if not MaoRUIPerDB["Chat"]["Invite"] then return end
	self:UpdateWhisperList()
	M:RegisterEvent("CHAT_MSG_WHISPER", module.OnChatWhisper)
	M:RegisterEvent("CHAT_MSG_BN_WHISPER", module.OnChatWhisper)
end

-- Sticky whisper
function module:ChatWhisperSticky()
	if MaoRUIPerDB["Chat"]["Sticky"] then
		ChatTypeInfo["WHISPER"].sticky = 1
		ChatTypeInfo["BN_WHISPER"].sticky = 1
	else
		ChatTypeInfo["WHISPER"].sticky = 0
		ChatTypeInfo["BN_WHISPER"].sticky = 0
	end
end

function module:UpdateTabColors(selected)
	if selected then
		self:GetFontString():SetTextColor(1, .8, 0)
	else
		self:GetFontString():SetTextColor(.5, .5, .5)
	end
end

function module:ChatFrameBackground()
	if not MaoRUIPerDB["Chat"]["Lock"] then return end
	if not MaoRUIPerDB["Skins"]["ChatLine"] then return end

	local cr, cg, cb = 0, 0, 0
	if MaoRUIPerDB["Skins"]["ClassLine"] then cr, cg, cb = I.r, I.g, I.b end

	local Linfobar = CreateFrame("Frame", nil, UIParent)
	Linfobar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 3)
	M.CreateGF(Linfobar, 450, ChatFrame1:GetHeight() + 30, "Horizontal", 0, 0, 0, .5, 0)
	local Linfobar1 = CreateFrame("Frame", nil, Linfobar)
	Linfobar1:SetPoint("BOTTOM", Linfobar, "TOP")
	M.CreateGF(Linfobar1, 450, R.mult, "Horizontal", cr, cg, cb, .7, 0)
	local Linfobar2 = CreateFrame("Frame", nil, Linfobar)
	Linfobar2:SetPoint("BOTTOM", Linfobar, "BOTTOM", 0, 18)
	M.CreateGF(Linfobar2, 450, R.mult, "Horizontal", cr, cg, cb, .7, 0)
	local Linfobar3 = CreateFrame("Frame", nil, Linfobar)
	Linfobar3:SetPoint("TOP", Linfobar, "BOTTOM")
	M.CreateGF(Linfobar3, 450, R.mult, "Horizontal", cr, cg, cb, .7, 0)
	ChatFrame1.gradientBG = Linfobar
end
	
function module:OnLogin()
	for i = 1, NUM_CHAT_WINDOWS do
		self.SkinChat(_G["ChatFrame"..i])
	end

	hooksecurefunc("FCF_OpenTemporaryWindow", function()
		for _, chatFrameName in next, CHAT_FRAMES do
			local frame = _G[chatFrameName]
			if frame.isTemporary then
				self.SkinChat(frame)
			end
		end
	end)

	hooksecurefunc("FCFTab_UpdateColors", self.UpdateTabColors)

	-- Font size
	for i = 1, 15 do
		CHAT_FONT_HEIGHTS[i] = i + 9
	end

	-- Default
	SetCVar("chatStyle", "classic")
	M.HideOption(InterfaceOptionsSocialPanelChatStyle)
	CombatLogQuickButtonFrame_CustomTexture:SetTexture(nil)

	-- Add Elements
	self:ChatWhisperSticky()
	self:ChatFilter()
	self:ChannelRename()
	self:Chatbar()
	self:UrlCopy()
	self:WhisperInvite()
	self:ChatFrameBackground()

	-- Lock chatframe
	if MaoRUIPerDB["Chat"]["Lock"] then
		self:UpdateChatSize()
		hooksecurefunc("FCF_SavePositionAndDimensions", self.UpdateChatSize)
		M:RegisterEvent("UI_SCALE_CHANGED", self.UpdateChatSize)
	end

	-- ProfanityFilter
	if not BNFeaturesEnabledAndConnected() then return end
	if MaoRUIPerDB["Chat"]["Freedom"] then
		if GetCVar("portal") == "CN" then
			ConsoleExec("portal TW")
		end
		SetCVar("profanityFilter", 0)
	else
		SetCVar("profanityFilter", 1)
	end
end