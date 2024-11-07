--## Version: 1.6.1  ## Author: Meatbag
--Thanks Dridzt for various bits of info and guidance :)
--create the main frame
local ChatLoot = CreateFrame("FRAME", "ChatLoot", UIParent)
ChatLoot:RegisterEvent("ADDON_LOADED")
ChatLoot:SetFrameStrata("MEDIUM")
ChatLoot:SetScript("OnEvent", function(self, event, ...) self:OnEvent(event, ...) end)
ChatLoot:Show()

--starts here
function ChatLoot:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		local info = ...
		if info == "_ShiGuang" then
			self:UnregisterEvent("ADDON_LOADED")
			
			self.defaults = {
				char = {
					tabName = ROLL, --Loot History "拾取"  CHAT_MSG_LOOT = "战利品";
				},
				global = {
					alert = true,
					tooltip = false,
					loadDelay = 0,
				},
			}

				self.settings = self:CopyTable(self.defaults.global, false, true)
				self.charSettings = self:CopyTable(self.defaults.char, false, true)

			if IsLoggedIn() then
				self:LoadSetup()
			else
				self:RegisterEvent("PLAYER_LOGIN")
			end
		end
	
	elseif event == "PLAYER_LOGIN" then
		self:UnregisterEvent("PLAYER_LOGIN")
		self:LoadSetup()
	
	elseif event == "START_LOOT_ROLL" then
		self:FlashOnLoot()
	elseif event == "LOOT_HISTORY_AUTO_SHOW" then
		self:FlashOnLoot()
	end
end

function ChatLoot:SlashCommands(msg)
	msg = strlower(msg)
	local msg, msgInfo = strsplit(" ", msg, 2)
	
	--reset the loot window
	if msg == "reset" then
		FCF_Close(self.chatFrame)
	
	--reload the loot window
	elseif msg == "install" then
		self:LoadFrame()
	
	--toggle chat tab alerts
	elseif msg == "alert" then
		self.settings.alert = not self.settings.alert
		if self.settings.alert then
			self:RegisterEvent("START_LOOT_ROLL")
			self:RegisterEvent("LOOT_HISTORY_AUTO_SHOW")
		else
			self:UnregisterEvent("START_LOOT_ROLL")
			self:UnregisterEvent("LOOT_HISTORY_AUTO_SHOW")
		end
		print("|cFFFF0000Alert: |r"..(self.settings.alert and "On" or "Off"))
		if not DEFAULT_CHAT_FRAME:IsVisible() then
			FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
		end
	
	--toggle tooltip display method
	elseif msg == "tooltip" then
		self.settings.tooltip = not self.settings.tooltip
		print("|cFFFF0000Tooltips: |r"..(self.settings.tooltip and "Click" or "Mouseover"))
		if not DEFAULT_CHAT_FRAME:IsVisible() then
			FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
		end
	
	--set/disable the delay time
	elseif msg == "delay" then
		if tonumber(msgInfo) then
			--a number was given, confirm it and save
			local delayTime = math.floor(tonumber(msgInfo))
			
			if delayTime < 0 then
				delayTime = 0
			end
			
			if delayTime > 20 then
				delayTime = 20
			end
			
			self.settings.loadDelay = delayTime
			
			if delayTime > 0 then
				print("|cFFFF0000Load Delay: |r"..(self.settings.loadDelay).."s")
			else
				print("|cFFFF0000Load Delay: |rDisabled")
			end
		else
			--no number, tell player to give one between range
			print("|cFFFF0000/loot delay <num>|r Replace <num> with a number between 0 and 20.")
		end
		if not DEFAULT_CHAT_FRAME:IsVisible() then
			FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
		end
	
	--no command, show the loot tab
	elseif msg == "" then
		if self.chatFrame and not self:IsVisible() and _G[self.chatFrame:GetName().."Tab"]:IsVisible() then
			FCF_SelectDockFrame(self.chatFrame)
		end
		
		if self.reset then
			if LootHistoryFrame:IsVisible() then
				LootHistoryFrame:Hide()
			else
				LootHistoryFrame:Show()
			end
		end
	
	--anything else, show help list
	else
		print("|cFFFF0000Chat Loot Help|r" )
		print("|cFFFFCC33/loot|r to show the loot tab." )
		print("|cFFFFCC33/loot alert|r to toggle tab flash." )
		print("|cFFFFCC33/loot tooltip|r to toggle between click or mouseover to show tooltips." )
		print("|cFFFFCC33/loot delay <0-20>|r to add a delay to the loading of the addon." )
		print("|cFFFFCC33/loot reset|r to reset the frame to its original size for uninstall." )
		
		if not DEFAULT_CHAT_FRAME:IsVisible() then
			FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
		end
	end
end

--apply delay otherwise load the assets
function ChatLoot:LoadSetup()
	if self.settings.loadDelay then
		if self.settings.loadDelay > 0 then
			self:ApplyDelay()
		else
			self:C_AddOns.LoadAddOn()
		end
	else
		self:C_AddOns.LoadAddOn()
	end
end

--apply user set delay length
function ChatLoot:ApplyDelay()
	if not self.delayTimer then
		self.delayTimer = self:CreateAnimationGroup()
		self.delayTimer:SetLooping("NONE")
		self.delayTimer.t1 = self.delayTimer:CreateAnimation()
		self.delayTimer.t1:SetScript("OnFinished", function() self:C_AddOns.LoadAddOn() end)
		self.delayTimer.t1:SetDuration(self.settings.loadDelay)
	end
	self.delayTimer:Play()
end

--load the frame and chat commands
function ChatLoot:C_AddOns.LoadAddOn()
	self:LoadFrame()
	self:LoadSlashCommands()
end

--wait till chat is loaded then create a tab and prep it for loot info
function ChatLoot:LoadFrame()
	if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
		if not self:ChatWindowCheck() then
			self.charSettings.tabName = self.defaults.char.tabName
			FCF_OpenNewWindow(self.charSettings.tabName)
		end
		self.chatFrame = _G["ChatFrame"..self:ChatWindowCheck()]
		
		if self.chatFrame then
			self.reset = nil
			ChatFrame_RemoveAllMessageGroups(self.chatFrame)
				
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", self.chatFrame, "TOPLEFT", 0, 18)
			self:SetPoint("BOTTOMRIGHT", self.chatFrame, "BOTTOMRIGHT", 0, 0)
			self:SetParent(self.chatFrame)
			self:SetScript("OnShow", function() self:LootWindowSize() end)
			self:SetScript("OnSizeChanged", function() self:LootWindowSize() end)
			
			LootHistoryFrame:SetParent(self)
			self:LootWindowSize()
			
			local children = {
				"CloseButton",
				"DragButton",
				"ResizeButton",
				"Divider",
				"LootIcon",
				"Label",
				"Background",
				"BorderTopLeft",
				"BorderTopRight",
				"BorderBottomRight",
				"BorderBottomLeft",
				"BorderTop",
				"BorderRight",
				"BorderBottom",
				"BorderLeft",
				}
			for _, child in pairs(children) do
				LootHistoryFrame[child]:Hide()
			end
			LootHistoryFrameScrollFrame.ScrollBarBackground:Hide()
			
			LootHistoryFrame:Show()
			
			if self.settings.alert then
				self:RegisterEvent("START_LOOT_ROLL")
				self:RegisterEvent("LOOT_HISTORY_AUTO_SHOW")
			end
			
			if not self.hooked then
				hooksecurefunc("LootHistoryFrame_FullUpdate", function(frame) self:LHF_FullUpdate(frame) end)
				hooksecurefunc("FCF_SetWindowName", function(frame, name, doNotSave) self:TabRename(frame, name, doNotSave) end)
				hooksecurefunc("FCF_Close", function(frame, fallback) self:TabClose(frame) end)
				self.hooked = true
			end
			
			if not DEFAULT_CHAT_FRAME:IsVisible() then
				FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
			end

		end
	end
end

--setup slash commands for chatbox
function ChatLoot:LoadSlashCommands()
	SLASH_CHATLOOT1 = "/chatloot"
	SlashCmdList.CHATLOOT = function(msg) ChatLoot:SlashCommands(msg) end
end

--the check for if a chat frame already exists
function ChatLoot:ChatWindowCheck()
	for id = 1, FCF_GetNumActiveChatFrames(), 1 do
		if _G["ChatFrame"..id].name == self.charSettings.tabName then
			return id
		end
	end
	return false
end

--anchor history frame to chat tab
function ChatLoot:LootWindowSize()
	LootHistoryFrame:Show()
	
	LootHistoryFrame:ClearAllPoints()
	LootHistoryFrame:SetAllPoints(ChatLoot)
	
	self:FixFrameSize(LootHistoryFrame)
end

--adjust item frame player list to proper width
function ChatLoot:FixFrameSize(frame)
	local frameWidth = frame:GetWidth()
	
	local childCount = C_LootHistory.GetNumItems()
	for id = 1, childCount do
		frame.itemFrames[id]:SetWidth(frameWidth - 40)
		frame.itemFrames[id].ActiveHighlight:SetWidth(frameWidth - 92)
		frame.itemFrames[id].Divider:Hide()
		
		if not frame.itemFrames[id].tooltipHooked then
			frame.itemFrames[id]:HookScript("OnEnter", function() self:TooltipOnEnter(frame.itemFrames[id]) end)
			frame.itemFrames[id]:HookScript("OnClick", function() self:TooltipOnClick(frame.itemFrames[id]) end)
			frame.itemFrames[id].tooltipHooked = true
		end
	end
	
	local playerFrameCount = #frame.usedPlayerFrames
	for id = 1, playerFrameCount do
		frame.usedPlayerFrames[id]:SetWidth(frameWidth - 40)
	end
end

--create and run the custom alert aniimation for the tab
function ChatLoot:FlashCreate(frame, start)
	if not frame.glow.alertAnim then
		frame.glow.alertAnim = frame.glow:CreateAnimationGroup()
		frame.glow.alertAnim:SetLooping("REPEAT")
		frame.glow.alertAnim.parent = frame.glow
		frame.glow.alertAnim.a1 = frame.glow.alertAnim:CreateAnimation("Alpha")
		--frame.glow.alertAnim.a1:SetChange(-1) -- decrease alpha
		frame.glow.alertAnim.a1:SetDuration(1) -- over 1 sec
		frame.glow.alertAnim.a1:SetOrder(1) -- run first
		frame.glow.alertAnim.a1:SetSmoothing("IN_OUT")
		frame.glow.alertAnim.a2 = frame.glow.alertAnim:CreateAnimation("Alpha")
		--frame.glow.alertAnim.a2:SetChange(0.7) -- increase alpha
		frame.glow.alertAnim.a2:SetDuration(1) -- over 1 sec
		frame.glow.alertAnim.a2:SetOrder(2) -- runs after 1 finishes; combined = "pulse" effect.
		frame.glow.alertAnim.a2:SetSmoothing("IN_OUT")
	end
	if frame.glow.alertAnim then
		if start then
			frame.glow.alertAnim:Play()
			frame.alerting = true
			frame.glow:Show()
			FCFTab_UpdateAlpha(self.chatFrame)
		else
			if frame.glow.alertAnim:IsPlaying() then
				frame.glow.alertAnim:Stop()
			end
			frame.alerting = false
			frame.glow:Hide()
			FCFTab_UpdateAlpha(self.chatFrame)
		end
	end
end

--make the tab flash if loot is acquired
function ChatLoot:FlashOnLoot()
	if self.chatFrame and not self:IsVisible() and self.settings.alert then
		local chatTab = _G[self.chatFrame:GetName().."Tab"]
		self:FlashCreate(chatTab, true)
		if not chatTab.alertHooked then
			chatTab:HookScript("OnClick", function() self:FlashCreate(chatTab) end)
			chatTab.alertHooked = true
		end
	end
end

--set the history frame back to its original size.  log and disable addon to complete uninstall 
function ChatLoot:ResetFrameSize()
	LootHistoryFrame:SetUserPlaced(true)
	LootHistoryFrame:ClearAllPoints()
	LootHistoryFrame:SetParent(UIParent)
	LootHistoryFrame:SetPoint("BOTTOM", UIParent, "CENTER")
	LootHistoryFrame:SetWidth(210)
	LootHistoryFrame:SetHeight(175)
	
	self:SetScript("OnShow", nil)
	self:SetScript("OnSizeChanged", nil)
	
	local children = {
		"CloseButton",
		"DragButton",
		"ResizeButton",
		"Divider",
		"LootIcon",
		"Label",
		"Background",
		"BorderTopLeft",
		"BorderTopRight",
		"BorderBottomRight",
		"BorderBottomLeft",
		"BorderTop",
		"BorderRight",
		"BorderBottom",
		"BorderLeft",
		}
	for _, child in pairs(children) do
		LootHistoryFrame[child]:Show()
	end
	LootHistoryFrameScrollFrame.ScrollBarBackground:Show()
	
	self:FixFrameSize(LootHistoryFrame)
	
	FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
	
	self.charSettings.tabName = self.defaults.char.tabName
	self.chatFrame = nil
	self.reset = true
	
	print("|cFFFF0000The loot history frame has been reset.|r")
	print("|cFFFFCC33/loot install|r or reload the UI to reinstall.|r" )
end

--hooked to adjust history frames children on update
function ChatLoot:LHF_FullUpdate(frame)
	--fix frame width
	if self.chatFrame then
		self:FixFrameSize(frame)
	end
end

--hooked to save name of the tab when you rename it
function ChatLoot:TabRename(frame, name, doNotSave)
	if self.chatFrame == frame then
		self.charSettings.tabName = frame.name
	end
end

--hooked to clean up the loot window and reset it properly
function ChatLoot:TabClose(frame)
	if self.chatFrame == frame then
		self:ResetFrameSize()
	end
end

--hooked to hide tooltip on itemframes when necessary
function ChatLoot:TooltipOnEnter(frame)
	if frame then
		if self.settings.tooltip then
			GameTooltip_Hide()
		end
	end
end

--hooked to show tooltip on itemframes when necessary
function ChatLoot:TooltipOnClick(frame)
	if frame then
		if self.settings.tooltip and not IsModifiedClick() and frame.itemLink then
			GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
			GameTooltip:SetHyperlink(frame.itemLink)
			GameTooltip:Show()
		end
	end
end

--copy a table
function ChatLoot:CopyTable(oldTable, meta, deep)
	local result = {}

	for key, value in pairs(oldTable) do
		if type(value) == "table" and deep then
			result[key] = self:CopyTable(value, meta, deep)
		else
			result[key] = value
		end
	end

    -- copy the metatable, if there is one
	if meta then
		setmetatable(result, getmetatable(oldTable))
	end
	
	return result
end