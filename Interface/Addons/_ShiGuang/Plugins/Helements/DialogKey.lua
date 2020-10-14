--## Author: Foxthorn  ## Version: 1.7.4

DialogKey = LibStub("AceAddon-3.0"):NewAddon("DialogKey", "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0")


local defaults = {								-- Default settings
	global = {
		keys = { "SPACE", },
		ignoreDisabledButtons = true,
		showGlow = false,
		shownBindWarning = false,
		additionalButtons = {},
		--dialogBlacklist = {},
		numKeysForGossip = true,
		numKeysForQuestRewards = true,
		--scrollQuests = false,
		dontClickSummons = true,
		dontClickDuels = true,
		dontClickRevives = true,
		dontClickReleases = true,
		soulstoneRez = false,
		keyCooldown = 0.8
	}
}

DialogKey.buttons = {							-- List of buttons to try and click
	--"StaticPopup1Button1",
	"QuestFrameCompleteButton",
	"QuestFrameCompleteQuestButton",
	"QuestFrameAcceptButton",
	"GossipTitleButton1",
	"QuestTitleButton1"
}

--DialogKey.scrollFrames = {						-- List of quest frames to try and scroll
--	QuestDetailScrollFrame,
--	QuestLogPopupDetailFrameScrollFrame,
--	QuestMapDetailsScrollFrame,
--	ClassicQuestLogDetailScrollFrame
--}

--DialogKey.builtinDialogBlacklist = {			-- If a confirmation dialog contains one of these strings, don't accept it
--	"Are you sure you want to go back to Shal'Aran?", -- Seems to bug out and not work if an AddOn clicks the confirm button?
--}

function DialogKey:OnInitialize()				-- Runs on addon initialization
	self.db = LibStub("AceDB-3.0"):New("DialogKeyDB", defaults, true)
	
	self.keybindMode = false
	self.keybindIndex = 0
	self.recentlyPressed = false
	
	self:RegisterChatCommand("dk", "ChatCommand")
	self:RegisterChatCommand("dkey", "ChatCommand")
	self:RegisterChatCommand("dialogkey", "ChatCommand")
	
	self:RegisterEvent("GOSSIP_SHOW",		  function() self:ScheduleTimer(self.EnumerateGossips_Gossip, 0.01) end)
	self:RegisterEvent("QUEST_GREETING",	  function() self:ScheduleTimer(self.EnumerateGossips_Quest, 0.01) end)
	--self:RegisterEvent("PLAYER_REGEN_ENABLED",function() self:ScheduleTimer(self.DisableQuestScrolling, 0.1) end) -- Since scrolling can't be disabled on closing a scrollframe in combat, wait til the end of combat to try disabling
	
	QuestInfoRewardsFrameQuestInfoItem1:HookScript("OnHide", function() GameTooltip:Hide() end) -- Hide GameTooltip when the quest is finished
	
	--for i,frame in pairs(DialogKey.scrollFrames) do
	--	frame:HookScript("OnShow", function() self:ScheduleTimer(self.EnableQuestScrolling, 0.01) end)
	--	frame:HookScript("OnHide", function() self:ScheduleTimer(self.DisableQuestScrolling, 0.1) end)
	--end
	
	--UIParent:HookScript("OnMouseWheel", self.HandleScroll)
	UIParent:EnableMouseWheel(false) -- Required since it's enabled upon hooking OnMouseWheel
	
	self.frame = CreateFrame("Frame", "DialogKeyFrame", UIParent)
	self.frame:EnableKeyboard(true)
	self.frame:SetPropagateKeyboardInput(true)
	self.frame:SetFrameStrata("TOOLTIP") -- Ensure we receive keyboard events first
	self.frame:SetScript("OnKeyDown", DialogKey.HandleKey)
	
	self.glowFrame = CreateFrame("Frame", "DialogKeyGlow", UIParent)
	self.glowFrame:SetPoint("CENTER", 0, 0)
	self.glowFrame:SetFrameStrata("TOOLTIP")
	self.glowFrame:SetSize(50,50)
	self.glowFrame:SetScript("OnUpdate", DialogKey.GlowFrameUpdate)
	self.glowFrame:Hide()
	self.glowFrame.tex = self.glowFrame:CreateTexture()
	self.glowFrame.tex:SetAllPoints()
	self.glowFrame.tex:SetColorTexture(1,1,0,0.5)
	
	self:ShowOldKeybindWarning()
	self:CreateOptionsFrame()
end

function DialogKey:ChatCommand(input)			-- Chat command handler
	local args = {strsplit(" ", input:trim())}
	
	if args[1] == "v" or args[1] == "ver" or args[1] == "version" then
		DialogKey:Print(GAME_VERSION_LABEL..": |cffffd7001.7.4|r")
	elseif args[1] == "add" or args[1] == "a" or args[1] == "watch" then
		if args[2] then
			DialogKey:WatchFrame(args[2])
		else
			DialogKey:AddMouseFocus()
		end
	elseif args[1] == "remove" or args[1] == "r" or args[1] == "unwatch" then
		if args[2] then
			DialogKey:UnwatchFrame(args[2])
		else
			DialogKey:RemoveMouseFocus()
		end
	else
		-- Twice, since the first call only succeeds in opening the options panel itself; the second call opens the correct category
		InterfaceOptionsFrame_OpenToCategory(self.options)
		InterfaceOptionsFrame_OpenToCategory(self.options)
	end
end

function DialogKey:Print(message,msgType)		-- Prefixed print function
	DEFAULT_CHAT_FRAME:AddMessage(DialogKey_TITLE..message.."|r")  --"|cffd2b48c[DialogKey]|r "
end

function DialogKey:ShowOldKeybindWarning()		-- Shows a popup warning the user that they've got old VEK binds
	if not self.db.global.shownBindWarning then
		self.db.global.shownBindWarning = true
		
		local key1 = GetBindingKey("ACCEPTDIALOG")
		local key2 = GetBindingKey("ACCEPTDIALOG_CHAT")
		
		-- Treat only having the second key bound as only having the first key bound for simplicity
		if key2 and not key1 then
			key1 = key2
			key2 = nil
		end
		
		local str
		if key1 then
			if key2 then
				str = "DialogKey is a replacement of Versatile Enter Key, which is now obsolete.\n\nYour '" .. GetBindingText(key1) .. "' and '" .. GetBindingText(key2) .. "' keys are still bound to Versatile Enter Key actions. You should rebind them to their original actions if they were originally bound to something important!"
			else
				str = "DialogKey is a replacement of Versatile Enter Key, which is now obsolete.\n\nYour '" .. GetBindingText(key1) .. "' key is still bound to a Versatile Enter Key action. You should rebind it to its original action if it was originally bound to something important!"
			end
		end
		
		if str then
			StaticPopupDialogs["DIALOGKEY_OLDBINDWARNING"] = {
				text = str,
				button1 = "Open Keybinds",
				button2 = OKAY,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				
				OnAccept = function()
					KeyBindingFrame_LoadUI()
					ShowUIPanel(KeyBindingFrame)
				end
			}
			StaticPopup_Show("DIALOGKEY_OLDBINDWARNING")
		end
	end
end

-- Misc. Lua functions --
function DialogKey:print_r ( t )				-- Recursively print a table
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end

function DialogKey:split(str, sep)				-- Splits str along sep
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	string.gsub(str, pattern, function(c) fields[#fields+1] = c end)
	return fields
end

function DialogKey:round(num, numDecimalPlaces)	-- Round a number to x decimal places
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


-- Chat handlers --
function DialogKey:AddMouseFocus()				-- Adds the button under the cursor to the list of additional buttons to click
	local frame = GetMouseFocus()
	if not frame or frame:GetObjectType() ~= "Button" then
		DialogKey:Print("|cffff3333The cursor must be over a button to track it|r")
		return
	end
	
	local name = frame:GetName()
	if not name then
		name = DialogKey:FindPathTo(frame)
		if not name then
			DialogKey:Print("|cffff3333The button cannot be tracked|r")
			return
		end
	end
	
	DialogKey:WatchFrame(name)
end

function DialogKey:FindPathTo(frame)			-- Returns a path to the frame in the form of NamedFrame.child[.child ...]
	local i = 1
	local path = {}
	
	local function path_to(frame)
		-- Failsafe, just in case
		if i > 30 then return false end
		
		local parent = frame:GetParent()
		for k,v in pairs(parent) do
			if v == frame then
				table.insert(path, 1, k)
				
				if parent:GetName() then
					-- This level's parent has a name, so add it to the path and return it
					table.insert(path, 1, parent:GetName())
					return path
				else
					-- This frame doesn't have a name either, so search another level up
					return path_to(parent, path, i+1)
				end
			end
		end
		
		-- This parent has no pointer to the child frame, and since we haven't found a parent with a name yet,
		-- the original frame cannot be located via a Named -> child [-> child...] path
		return false
	end
	
	path = path_to(frame)
	if not path then return end
	
	return table.concat(path, ".")
end

function DialogKey:GetFrameByName(name)			-- Returns a frame object by global name or path returned from DialogKey:FindPathTo()
	if name:find("%.") then
		local parts = DialogKey:split(name, ".")
		local tbl=_G[parts[1]]
		
		if not tbl then return false end -- happens in cases like binding to a frame from an unloaded addon/UI element (like shipyard)
		
		for i=2,#parts do
			tbl = tbl[parts[i]]
		end
		return tbl
	else
		return _G[name]
	end
end

function DialogKey:RemoveMouseFocus()			-- Removes the button under the cursor from the list of additional buttons to click
	local frame = GetMouseFocus()
	if not frame or frame:GetObjectType() ~= "Button" then
		DialogKey:Print("|cffff3333The cursor must be over a button to untrack it|r")
		return
	end
	
	local name = frame:GetName()
	if not name then
		name = DialogKey:FindPathTo(frame)
		if not name then
			DialogKey:Print("|cffff3333That button is not being tracked|r")
			return
		end
	end
	
	DialogKey:UnwatchFrame(name)
end

function DialogKey:WatchFrame(name)				-- Add given frame to the watch list
	for k,frameName in pairs(self.db.global.additionalButtons) do
		if frameName == name then
			DialogKey:Print("|cffff3333Already tracking |cffffd700"..name.."|r")
			return
		end
	end
	
	tinsert(self.db.global.additionalButtons, name)
	DialogKey:Print("Started tracking |cffffd700" .. name .. "|r")
	
	local frame = DialogKey:GetFrameByName(name)
	if frame and frame:IsVisible() then
		DialogKey:Glow(frame, "add")
	end
	
	--DialogKey:UpdateAdditionalFrames()
end

function DialogKey:UnwatchFrame(name)			-- Remove given frame from the watch list
	local removed = false
	for i,watchedframe in pairs(self.db.global.additionalButtons) do
		if watchedframe == name then
			removed = true
			tremove(self.db.global.additionalButtons, i)
		end
	end
	
	if removed then
		DialogKey:Print("Stopped tracking |cffffd700" .. name .. "|r")
	else
		DialogKey:Print("|cffff3333Not tracking |cffffd700" .. name .. "|r")
	end
	
	local frame = DialogKey:GetFrameByName(name)
	if frame and frame:IsVisible() then
		DialogKey:Glow(frame, "remove")
	end
	
	--DialogKey:UpdateAdditionalFrames()
end

-- Primary functions --
function DialogKey:HandleKey(key)				-- Run for every key hit ever; runs ClickButtons() if it's the bound one
	if DialogKey.keybindMode then
		DialogKey:HandleKeybind(key)
		return
	end
	
	if GetCurrentKeyBoardFocus() then return end -- Don't handle key if we're typing into something
	
	if key:find("^%d$") and (QuestFrameGreetingPanel:IsVisible() or GossipFrameGreetingPanel:IsVisible()) and DialogKey.db.global.numKeysForGossip then
		local num = 1
		local keynum = tonumber(key)
		for i=1,9 do
			local frame = _G["GossipTitleButton"..i]
			
			-- Try QuestTitleButton* instead if Gossip buttons aren't shown
			if not frame or not frame:IsVisible() then
				frame = _G["QuestTitleButton"..i]
			end
			
			-- If the frame isn't blank (blank frames are used to separate gossip and quests)
			if frame and frame:IsVisible() and frame:GetText() then
				if num == keynum then
					DialogKey:ClickFrame(frame)
					self:SetPropagateKeyboardInput(false)
					return
				end
				
				num = num+1
			end
		end
	
	-- If 1-9 was pressed, 'select quest rewards' option is enabled, quest rewards are visible, and the quest is ready to complete
	elseif key:find("^%d$") and QuestInfoRewardsFrameQuestInfoItem1:IsVisible() and QuestFrameCompleteQuestButton:IsVisible() and DialogKey.db.global.numKeysForQuestRewards then
		local frame = _G["QuestInfoRewardsFrameQuestInfoItem"..key]
		
		if frame and frame:IsVisible() and frame.type == "choice" then -- All buttons return true for IsVisible(), actually visible visible ones are type 'choice' (others are type 'reward') ()
			if not GetCurrentKeyBoardFocus() then
				DialogKey:ClickFrame(frame)
				self:SetPropagateKeyboardInput(false)
				
				GameTooltip:SetOwner(frame, "ANCHOR_NONE")
				GameTooltip:SetQuestItem("choice", tonumber(key))
				GameTooltip:SetPoint("TOPLEFT", frame, "BOTTOMLEFT")
				GameTooltip_ShowCompareItem()
				GameTooltip:Show()
				ShoppingTooltip1:Show()
				
				return
			end
		end
	end
	
	-- If the dialog key was pressed (default space), try to hit a bound button and if one was found, don't propagate it
	if key == DialogKey.db.global.keys[1] or key == DialogKey.db.global.keys[2] then
		if DialogKey:ClickButtons() then		-- If we did hit a watched button, suppress keys for a second and don't propagate the keypress (e.g. don't jump)
			if DialogKey.db.global.keyCooldown > 0 then
				DialogKey.recentlyPressed = true
				DialogKey:ScheduleTimer(function() DialogKey.recentlyPressed = false end, DialogKey.db.global.keyCooldown)
			end
			
			self:SetPropagateKeyboardInput(false)
		elseif DialogKey.recentlyPressed then	-- If we didn't hit a button and the suppress timer is active, don't propagate the keypress (e.g. don't jump)
			self:SetPropagateKeyboardInput(false)
		else									-- If we didn't hit a button and the suppress timer isn't running, allow the keypress (e.g. jump)
			self:SetPropagateKeyboardInput(true)
		end
	else										-- If the pressed button wasn't even bound to DialogKey, allow the keypress (don't handle it)
		self:SetPropagateKeyboardInput(true)
	end
end

function DialogKey:ClickButtons()				-- Main function to click on dialog buttons when the bound key is pressed. Return true to mark the keypress as handled and block input (like jumping)
	for i,framename in pairs(DialogKey.buttons) do
		-- Workaround for BFA: we can't select individual gossip frames anymore, so we have to use these functions instead
		if framename == "QuestTitleButton1" and QuestFrame:IsVisible() then
			-- If there's any active quests, click the first completed one
			-- If none are completed, we'll move on to looking at available quests instead
			if GetNumActiveQuests() > 0 then -- If there's any quests to turn in, select the first one
				for i=1,GetNumActiveQuests() do
					local title,complete = GetActiveTitle(i)
					if complete then
						DialogKey:GlowQuestIndex(i)
						SelectActiveQuest(i)
						PlaySound(SOUNDKIT.IG_QUEST_LIST_SELECT)
						return true
					end
				end
			end
			
			-- If there's any available quests, click the first one
			if GetNumAvailableQuests() > 0 then
				DialogKey:GlowQuestIndex(GetNumActiveQuests() + 1)
				SelectAvailableQuest(1)
				PlaySound(SOUNDKIT.IG_QUEST_LIST_SELECT)
				return true
			end
			
			-- SET BACK TO FALSE
			return false -- We're done handling the QuestTitleButton1 frame, so exit the function
		
		-- Workaround for selecting first COMPLETED quest, even if it's not the first gossip option
		elseif framename == "GossipTitleButton1" and GossipFrame:IsVisible() then
			-- Try clicking the first gossip option with a completed quest icon -- also check if it's visible, since frames are reused and it might get stuck trying to click a leftover, invisible active quest button
			for i=1,9 do
				if _G["GossipTitleButton"..i.."GossipIcon"]:IsVisible() and (
					_G["GossipTitleButton"..i.."GossipIcon"]:GetTexture() == "Interface\\GossipFrame\\ActiveQuestIcon" or
					_G["GossipTitleButton"..i.."GossipIcon"]:GetTexture() == "Interface\\GossipFrame\\ActiveLegendaryQuestIcon") then
					return DialogKey:ClickFrameName("GossipTitleButton"..i)
				end
			end
			
			-- If none were found, just click the first one
			return DialogKey:ClickFrameName("GossipTitleButton1")
		
		elseif DialogKey:ClickFrameName(framename) then
			return true
		end
	end
	
	for i,framename in pairs(self.db.global.additionalButtons) do
		if DialogKey:ClickFrameName(framename) then
			return true
		end
	end
	
	if DialogKey.recentlyPressed then
		return true
	end
end

function DialogKey:ClickFrame(frame)			-- Attempts to click a passed frame
	-- If the frame doesn't exist, definitely don't do anything (unless it's QuestTitleButton1, we handle that specially)
	if not frame then
		return false
	end
	
	-- If we're typing into an editbox, don't do anything, except if it's during sending mail
	if StaticPopup1:IsVisible() and GetCurrentKeyBoardFocus() and (GetCurrentKeyBoardFocus():GetName() == "SendMailNameEditBox" or GetCurrentKeyBoardFocus():GetName() == "SendMailSubjectEditBox") then
		GetCurrentKeyBoardFocus():ClearFocus()
		DialogKey:Glow(frame, "click")
		frame:Click()
		return true
	elseif GetCurrentKeyBoardFocus() then
		return false
	end
	
	if frame:IsVisible() and (not self.db.global.ignoreDisabledButtons or (self.db.global.ignoreDisabledButtons and frame:IsEnabled())) then
		-- Don't accept summons/duels/resurrects if the options are enabled
		-- Takes a global string like '%s has challenged you to a duel.' and converts it to a format suitable for string.find
		local summon_match = CONFIRM_SUMMON:gsub("%%s", ".+"):gsub("%%d", ".+")
		if self.db.global.dontClickSummons and StaticPopup1:IsVisible() and StaticPopup1Text:GetText():find(summon_match)   then return end
		
		local duel_match = DUEL_REQUESTED:gsub("%%s",".+")
		if self.db.global.dontClickDuels   and StaticPopup1:IsVisible() and StaticPopup1Text:GetText():find(duel_match)     then return end
		
		-- If resurrect dialog has three buttons, and the option is enabled, use the middle one instead of the first one (soulstone, etc.)
		-- Located before resurrect/release checks/returns so it happens even if you have releases/revives disabled
		-- Also, Check if Button2 is visible instead of Button3 since Recap is always 3; 2 is hidden if you can't soulstone rez
		if StaticPopup1Button1Text:GetText() == DEATH_RELEASE and StaticPopup1Button2:IsVisible() and self.db.global.soulstoneRez then
			StaticPopup1Button2:Click()
			return
		end
		
		local resurrect_match = RESURRECT_REQUEST_NO_SICKNESS:gsub("%%s", ".+")
		if self.db.global.dontClickRevives and StaticPopup1:IsVisible() and (StaticPopup1Text:GetText() == RECOVER_CORPSE or StaticPopup1Text:GetText():find(resurrect_match)) then return end
		
		if self.db.global.dontClickReleases and StaticPopup1Button1:IsVisible() and StaticPopup1Button1Text:GetText() == DEATH_RELEASE then return end
		
		-- Don't click OK if the dialog box's text matches a blacklist line
		--for i=1,#self.db.global.dialogBlacklist do
			--if StaticPopup1Button1:IsVisible() and StaticPopup1Text:GetText():lower():find(self.db.global.dialogBlacklist[i]:lower()) then return end
		--end
		
		-- Don't click OK if the dialog box's text matches a BUILT-IN blacklisted string
		-- (e.g. the Withered Army Training exit dialog - will never work because of taint issues with it casting a teleport spell
		--for i=1,#DialogKey.builtinDialogBlacklist do
			--if StaticPopup1Button1:IsVisible() and StaticPopup1Text:GetText():lower():find(DialogKey.builtinDialogBlacklist[i]:lower()) then
				--DialogKey:Print("|cffff3333This dialog casts a spell and does not work with DialogKey. Sorry!|r")
				--return
			--end
		--end
		
		DialogKey:Glow(frame, "click")
		frame:Click()
		return true
	end
end

function DialogKey:ClickFrameName(framename)	-- Attempts to click a frame by name (or path)
	return DialogKey:ClickFrame(DialogKey:GetFrameByName(framename))
end

function DialogKey:GetQuestButtons()			-- Return sorted list of quest button frames
	-- TODO: fix order being wrong on first load?
	local frames = {}
	
	if QuestFrameGreetingPanel.titleButtonPool then
		for f,unknown in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do
			table.insert(frames,{
				top      = f:GetTop(),
				frame    = f,
				name     = f:GetText()
			})
		end
		
		table.sort(frames,function(a,b)
			if a.top > b.top then
				return 1
			elseif a.top < b.top then
				return -1
			end
			
			return 0
		end)
	elseif QuestTitleButton1:IsVisible() then
		for i=1,10 do
			local frame = _G["QuestTitleButton"..i]
			
			if frame:IsVisible() and frame:GetText() ~= "" then
				table.insert(frames, {
					top   = frame:GetTop(),
					frame = frame,
					name  = frame:GetText()
				})
			end
		end
	end
	
	return frames
end

function DialogKey:EnumerateGossips_Gossip()	-- Prefixes 1., 2., etc. to NPC options
	if not DialogKey.db.global.numKeysForGossip then return end
	if not GossipFrameGreetingPanel:IsVisible() and not QuestFrameGreetingPanel:IsVisible() then return end
	
	local num = 1
	for i=1,9 do
		local frame
		if GossipFrame:IsVisible() then
			frame = _G["GossipTitleButton"..i]
		else
			frame = _G["QuestTitleButton"..i]
		end
		
		if frame:IsVisible() and frame:GetText() then
			if not frame:GetText():find("^"..num.."\. ") then
				frame:SetText(num .. ". " .. frame:GetText())
			end
			
			num = num+1
		end
	end
end

function DialogKey:EnumerateGossips_Quest()		-- Prefixes 1., 2., etc. to NPC options
	if not DialogKey.db.global.numKeysForGossip then return end
	if not GossipFrameGreetingPanel:IsVisible() and not QuestFrameGreetingPanel:IsVisible() then return end
	
	local frames = DialogKey:GetQuestButtons()
	
	local num = 1
	for i,f in pairs(frames) do
		local frame = f.frame
		if frame:IsVisible() and frame:GetText() then
			if not frame:GetText():find("^"..num.."\. ") then
				frame:SetText(num .. ". " .. frame:GetText())
			end
			
			num = num+1
		end
	end
	
	--[[
	local num = 1
	for i=1,9 do
		local frame
		if GossipFrame:IsVisible() then
			frame = _G["GossipTitleButton"..i]
		else
			frame = _G["QuestTitleButton"..i]
		end
		
		if frame:IsVisible() and frame:GetText() then
			if not frame:GetText():find("^"..num.."\. ") then
				frame:SetText(num .. ". " .. frame:GetText())
			end
			
			num = num+1
		end
	end
	]]
end

function DialogKey:Glow(frame, mode)			-- Show the glow frame over a frame. Mode is "click", "add", or "remove"
	if mode == "click" then
		if DialogKey.db.global.showGlow then
			self.glowFrame:SetAllPoints(frame)
			self.glowFrame.tex:SetColorTexture(1,1,0,0.5)
			self.glowFrame:Show()
			self.glowFrame:SetAlpha(1)
		end
	elseif mode == "add" then
		self.glowFrame:SetAllPoints(frame)
		self.glowFrame.tex:SetColorTexture(0,1,0,0.5)
		self.glowFrame:Show()
		self.glowFrame:SetAlpha(1)
	elseif mode == "remove" then
		self.glowFrame:SetAllPoints(frame)
		self.glowFrame.tex:SetColorTexture(1,0,0,0.5)
		self.glowFrame:Show()
		self.glowFrame:SetAlpha(1)
	end
end

function DialogKey:GlowQuestIndex(i)			-- Show the glow frame over a specific quest button
	if not DialogKey.db.global.showGlow then return end
	
	local frames = DialogKey:GetQuestButtons()
	
	--DialogKey:print_r(frames)
	
	self.glowFrame:SetAllPoints(frames[i].frame)
	self.glowFrame.tex:SetColorTexture(1,1,0,0.5)
	self.glowFrame:Show()
	self.glowFrame:SetAlpha(1)
end

function DialogKey:GlowFrameUpdate(delta)		-- Fades out the glow frame
	-- Use delta (time since last frame) so animation takes same amount of time regardless of framerate
	self:SetAlpha(self:GetAlpha() - delta*3)
	if self:GetAlpha() <= 0 then self:Hide() end
end

--[[ Scroll functions --
function DialogKey:EnableQuestScrolling()		-- Traps the mouse wheel input if the option's enabled and the quest details frame can scroll
	if not DialogKey.db.global.scrollQuests then return end
	if InCombatLockdown() == 1 then return end
	
	for i,frame in pairs(DialogKey.scrollFrames) do
		if frame:IsVisible() and frame:GetVerticalScrollRange() > 0 then
			UIParent:EnableMouseWheel(true)
		end
	end
end

function DialogKey:DisableQuestScrolling()		-- Frees up mouse wheel input again when a scroll frame is hidden, or when leaving combat
	local found = false
	
	for i,frame in pairs(DialogKey.scrollFrames) do
		if frame:IsVisible() and frame:GetVerticalScrollRange() > 0 then
			found = true
		end
	end
	
	if not found then UIParent:EnableMouseWheel(false) end
end

function DialogKey:HandleScroll(delta)			-- Run when the mouse wheel is trapped and the user scrolls it
	if not DialogKey.db.global.scrollQuests then return end
	
	local scrollFrame
	
	for i,frame in pairs(DialogKey.scrollFrames) do
		if frame:IsVisible() and frame:GetVerticalScrollRange() > 0 then
			scrollFrame = frame
			local scrollAmount = frame:GetVerticalScroll()+(-185.5*delta)
			scrollAmount = min(max(scrollAmount, 0), frame:GetVerticalScrollRange())
			frame:SetVerticalScroll(scrollAmount)
			
			if delta > 0 then
				DialogKey:Glow(_G[scrollFrame:GetName().."ScrollBarScrollUpButton"], "click")
			else
				DialogKey:Glow(_G[scrollFrame:GetName().."ScrollBarScrollDownButton"], "click")
			end
		end
	end
end]]


function DialogKey:CreateOptionsFrame()		-- Constructs the options frame
	self.options = CreateFrame("Frame")
	
	--[[ scroll frame
	local scrollFrame = CreateFrame("ScrollFrame", nil, self.options)
	scrollFrame:SetPoint("TOPLEFT", 5, -5)
	scrollFrame:SetPoint("BOTTOMRIGHT", -25, 5)
	scrollFrame:EnableMouse(true)
	scrollFrame:EnableMouseWheel(true)
	
	scrollFrame:SetScript("OnMouseWheel", function(self, delta)
		local current = self.scrollBar:GetValue()
		local minV, maxV = self.scrollBar:GetMinMaxValues()
			
		if delta < 0 and current >= minV then
			self.scrollBar:SetValue(math.min(maxV, current+30))
		elseif delta > 0 and current <= maxV then
			self.scrollBar:SetValue(math.max(minV, current-30))
		end
	end)
	
	-- scroll frame's slider
	local scrollBar = CreateFrame("slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
	scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 4, -16)
	scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 4, 16)
	--scrollBar:SetMinMaxValues(1,200)  --315
	--scrollBar:SetValueStep(1)
	--scrollBar.scrollStep = 1
	scrollBar:SetValue(0)
	scrollBar:SetWidth(16)
	scrollFrame.scrollBar = scrollBar
	
	-- slider texture
	local scrollbg = scrollBar:CreateTexture(nil, "BACKGROUND") 
	scrollbg:SetAllPoints(scrollBar) 
	scrollbg:SetColorTexture(0, 0, 0, 0.4) 
	self.options.scrollBar = scrollBar]]
	
	-- options frame
	local optionsContent = CreateFrame("Frame", nil, self.options)
	optionsContent:SetPoint("TOPLEFT", 5, -5)
	--optionsContent:SetPoint("BOTTOMRIGHT", -25, 5)
	optionsContent:SetSize(128, 128)
	self.options.content = optionsContent
	--scrollFrame:SetScrollChild(optionsContent)
	
	local title = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetFont(STANDARD_TEXT_FONT, 16)
	title:SetText("DialogKey")
	title:SetPoint("TOPLEFT", 16, -16)
	
	local subtitle = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetFont(STANDARD_TEXT_FONT, 10)
	subtitle:SetText("Version 1.7.4")
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 4, -8)
	
	optionsContent.keybindButtons = {}
	
	local button1 = CreateFrame("Button", nil, optionsContent, "UIPanelButtonTemplate")
	button1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 4,-64)
	button1:SetWidth(120)
	button1:SetHeight(26)
	button1:SetText(GetBindingText(self.db.global.keys[1]))
	button1:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	
	button1:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			DialogKey:EnableKeybindMode(1)
		else
			DialogKey:ClearBind(1)
		end
	end)
	
	button1:SetScript("OnHide", DialogKey.DisableKeybindMode)
	optionsContent.keybindButtons[1] = button1
	
	local button2 = CreateFrame("Button", nil, optionsContent, "UIPanelButtonTemplate")
	button2:SetPoint("LEFT", button1, "RIGHT", 30,0)
	button2:SetWidth(120)
	button2:SetHeight(26)
	button2:SetText(GetBindingText(DialogKey.db.global.keys[2]))
	button2:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	
	button2:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			DialogKey:EnableKeybindMode(2)
		else
			DialogKey:ClearBind(2)
		end
	end)
	
	button2:SetScript("OnHide", DialogKey.DisableKeybindMode)
	optionsContent.keybindButtons[2] = button2
	
	local keybindOr = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	keybindOr:SetFont(STANDARD_TEXT_FONT, 12)
	keybindOr:SetTextColor(1,1,1,1)
	keybindOr:SetText("or")
	keybindOr:SetPoint("LEFT", button1, "RIGHT", 0, 2)
	keybindOr:SetPoint("RIGHT", button2, "LEFT", 0, 2)
	
	local keybindTitle = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	keybindTitle:SetFont(STANDARD_TEXT_FONT, 12)
	keybindTitle:SetTextColor(1,1,1,1)
	keybindTitle:SetJustifyH("LEFT")
	keybindTitle:SetWidth(500)
	keybindTitle:SetWordWrap(true)
	keybindTitle:SetText("Click the button to set the key used to accept quests, confirm dialogs, etc. Right-click a button to unbind a key. The key will perform its usual action if there's nothing to accept or confirm.")
	keybindTitle:SetPoint("BOTTOMLEFT", button1, "TOPLEFT", 0, 4)
	
	local keybindReminder = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	keybindReminder:SetFont(STANDARD_TEXT_FONT, 10)
	keybindReminder:SetTextColor(1,1,1,1)
	keybindReminder:SetText("Press any key...")
	keybindReminder:SetPoint("LEFT", button2, "RIGHT", 4, 0)
	keybindReminder:Hide()
	optionsContent.keybindReminder = keybindReminder
	
	-- NOTE: a lot of these are reversed (option = not self:GetChecked()) because the options were originally "don't <action>" instead of "<action>"
	-- and it's just easier to rename them and reverse than try to convert users' settings
	
	-- Don't click greyed-out buttons
	local ignoreCheckbox = CreateFrame("CheckButton", "DialogKeyOptIgnore", optionsContent, "UICheckButtonTemplate")
	ignoreCheckbox:SetPoint("TOPLEFT", button1, "BOTTOMLEFT", -3, -20)
	_G["DialogKeyOptIgnoreText"]:SetText("忽略无法选择的选项")  --Don't try to click on greyed-out buttons
	ignoreCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.ignoreDisabledButtons) end)
	ignoreCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.ignoreDisabledButtons = self:GetChecked() end)
	ignoreCheckbox:SetChecked(DialogKey.db.global.ignoreDisabledButtons)

		
	-- Glow buttons
	local glowCheckbox = CreateFrame("CheckButton", "DialogKeyOptGlow", optionsContent, "UICheckButtonTemplate")
	glowCheckbox:SetPoint("TOPLEFT", ignoreCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptGlowText"]:SetText("按下DialogKey按钮闪烁")  --Make buttons clicked by DialogKey glow
	glowCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.showGlow) end)
	glowCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.showGlow = self:GetChecked() end)
	glowCheckbox:SetChecked(DialogKey.db.global.showGlow)
	
	-- Select quest rewards
	local numQuestRewardsCheckbox = CreateFrame("CheckButton", "DialogKeyOptNumQuestRewards", optionsContent, "UICheckButtonTemplate")
	numQuestRewardsCheckbox:SetPoint("TOPLEFT", glowCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptNumQuestRewardsText"]:SetText("用1-6数字键编码任务奖励")  --1-6 keys select quest rewards
	numQuestRewardsCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.numKeysForQuestRewards) end)
	numQuestRewardsCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.numKeysForQuestRewards = self:GetChecked() end)
	numQuestRewardsCheckbox:SetChecked(DialogKey.db.global.numKeysForQuestRewards)
		
	-- Select gossip
	local numGossipCheckbox = CreateFrame("CheckButton", "DialogKeyOptNumGossip", optionsContent, "UICheckButtonTemplate")
	numGossipCheckbox:SetPoint("TOPLEFT", numQuestRewardsCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptNumGossipText"]:SetText("用1-9数字键编码对话和任务") --1-9 keys select conversations/quests
	numGossipCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.numKeysForGossip) end)
	numGossipCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.numKeysForGossip = self:GetChecked() end)
	numGossipCheckbox:SetChecked(DialogKey.db.global.numKeysForGossip)

	
	--[[ Scroll quests
	local scrollQuestsCheckbox = CreateFrame("CheckButton", "DialogKeyOptScrollQuests", optionsContent, "UICheckButtonTemplate")
	scrollQuestsCheckbox:SetPoint("TOPLEFT", numGossipCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptScrollQuestsText"]:SetText("鼠标滚轮始终滚动任务对话框, 而不考虑光标位置")  --Mouse wheel always scrolls quest dialogs regardless of cursor position
	scrollQuestsCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.scrollQuests) end)
	scrollQuestsCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.scrollQuests = self:GetChecked() end)
	scrollQuestsCheckbox:SetChecked(DialogKey.db.global.scrollQuests)]]
	
	-- Don't accept revives
	local dontClickRevivesCheckbox = CreateFrame("CheckButton", "DialogKeyOptDontClickRevives", optionsContent, "UICheckButtonTemplate")
	dontClickRevivesCheckbox:SetPoint("TOPLEFT", ignoreCheckbox, "TOPLEFT", 300, 0)
	_G["DialogKeyOptDontClickRevivesText"]:SetText("接受复活")  --Accept revives
	dontClickRevivesCheckbox:SetScript("OnShow", function(self) self:SetChecked(not DialogKey.db.global.dontClickRevives) end)
	dontClickRevivesCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.dontClickRevives = not self:GetChecked() end)
	dontClickRevivesCheckbox:SetChecked(not DialogKey.db.global.dontClickRevives)
		
	-- Don't accept summons
	local dontClickSummonsCheckbox = CreateFrame("CheckButton", "DialogKeyOptDontClickSummons", optionsContent, "UICheckButtonTemplate")
	dontClickSummonsCheckbox:SetPoint("TOPLEFT", dontClickRevivesCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptDontClickSummonsText"]:SetText("接受召唤请求")  --Accept summon requests
	dontClickSummonsCheckbox:SetScript("OnShow", function(self) self:SetChecked(not DialogKey.db.global.dontClickSummons) end)
	dontClickSummonsCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.dontClickSummons = not self:GetChecked() end)
	dontClickSummonsCheckbox:SetChecked(not DialogKey.db.global.dontClickSummons)
	
	-- Don't accept duels
	local dontClickDuelsCheckbox = CreateFrame("CheckButton", "DialogKeyOptDontClickDuels", optionsContent, "UICheckButtonTemplate")
	dontClickDuelsCheckbox:SetPoint("TOPLEFT", dontClickSummonsCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptDontClickDuelsText"]:SetText("接受决斗请求")  --Accept duel requests
	dontClickDuelsCheckbox:SetScript("OnShow", function(self) self:SetChecked(not DialogKey.db.global.dontClickDuels) end)
	dontClickDuelsCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.dontClickDuels = not self:GetChecked() end)
	dontClickDuelsCheckbox:SetChecked(not DialogKey.db.global.dontClickDuels)

	
	-- Don't accept releases
	local dontClickReleasesCheckbox = CreateFrame("CheckButton", "DialogKeyOptDontClickReleases", optionsContent, "UICheckButtonTemplate")
	dontClickReleasesCheckbox:SetPoint("TOPLEFT", dontClickDuelsCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptDontClickReleasesText"]:SetText("接受精神释放")  --Accept spirit releases
	dontClickReleasesCheckbox:SetScript("OnShow", function(self) self:SetChecked(not DialogKey.db.global.dontClickReleases) end)
	dontClickReleasesCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.dontClickReleases = not self:GetChecked() end)
	dontClickReleasesCheckbox:SetChecked(not DialogKey.db.global.dontClickReleases)
	
	-- Use soulstone rezzes instead
	local soulstoneRezCheckbox = CreateFrame("CheckButton", "DialogKeyOptSoulstoneRez", optionsContent, "UICheckButtonTemplate")
	soulstoneRezCheckbox:SetPoint("TOPLEFT", dontClickReleasesCheckbox, "BOTTOMLEFT", 0, 0)
	_G["DialogKeyOptSoulstoneRezText"]:SetText("使用灵魂石复活(如果有)")  --Use soulstone resurrect when possible
	soulstoneRezCheckbox:SetScript("OnShow", function(self) self:SetChecked(DialogKey.db.global.soulstoneRez) end)
	soulstoneRezCheckbox:SetScript("OnClick", function(self) DialogKey.db.global.soulstoneRez = self:GetChecked() end)
	soulstoneRezCheckbox:SetChecked(DialogKey.db.global.soulstoneRez)
	
	-- Key cooldown title
	local cooldownTitle = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	cooldownTitle:SetFont(STANDARD_TEXT_FONT, 14)
	cooldownTitle:SetTextColor(1,.75,0,1)
	cooldownTitle:SetJustifyH("LEFT")
	cooldownTitle:SetText("按键响应间隔") --Keypress cooldown
	cooldownTitle:SetPoint("TOPLEFT", numGossipCheckbox, "BOTTOMLEFT", 10, -10)  --"TOPLEFT", blacklistScroll, "BOTTOMLEFT", -4, -20
	
	--[[ Key cooldown description
	local cooldownDesc = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	cooldownDesc:SetFont(STANDARD_TEXT_FONT, 11)
	cooldownDesc:SetTextColor(1,1,1,1)
	cooldownDesc:SetJustifyH("LEFT")
	cooldownDesc:SetText("How long to block normal input after a dialog button has been pressed by the bound key,\nto avoid jumping after spamming the dialog key (e.g. picking up quests).\nOnly suppresses game input (like jumping), not dialog key presses.")
	cooldownDesc:SetPoint("TOPLEFT", cooldownTitle, "BOTTOMLEFT", 0, -6)]]
	
	-- Key cooldown slider
	local cooldownSlider = CreateFrame("Slider", "DialogKeyCooldownSlider", optionsContent, "OptionsSliderTemplate")
	cooldownSlider:SetWidth(210)
	cooldownSlider:SetHeight(21)
	cooldownSlider:SetPoint("TOPLEFT", cooldownTitle, "BOTTOMLEFT", 8, -21)
	cooldownSlider:SetOrientation('HORIZONTAL')
	DialogKeyCooldownSliderLow:SetText("0s")
	DialogKeyCooldownSliderHigh:SetText("2s")
	cooldownSlider:SetMinMaxValues(0,2)
	cooldownSlider:SetValueStep(0.05)
	cooldownSlider:SetStepsPerPage(0.2)
	cooldownSlider:SetValue(DialogKey.db.global.keyCooldown)
	
	DialogKeyCooldownSliderText:SetText(DialogKey:ValueToString(DialogKey.db.global.keyCooldown))
	
	cooldownSlider:SetScript("OnValueChanged", function(self,value)
		-- Fix for slider:SetValueStep not actually working; do a SetValue to properly snap values
		if not self._onsetting then
			self._onsetting = true
			self:SetValue(self:GetValue())
			value = self:GetValue()
			self._onsetting = false
		else return end
		
		value = DialogKey:round(value*20,0)/20
		DialogKeyCooldownSliderText:SetText(DialogKey:ValueToString(value))
		DialogKey.db.global.keyCooldown = value
	end)
		
	--[[ Additional buttons to click
	local additionalScroll = CreateFrame("ScrollFrame", "DialogKeyScrollFrame", optionsContent, "InputScrollFrameTemplate")
	additionalScroll:SetSize(300,150)
	additionalScroll:SetPoint("TOPLEFT", cooldownSlider, "BOTTOMLEFT", 9, -50)
	additionalScroll.CharCount:Hide()
	optionsContent.additionalScroll = additionalScroll
	
	-- to scroll the options frame if we're hovered over this scrollbox and scroll the mouse wheel
	additionalScroll:EnableMouseWheel(true)
	additionalScroll:SetScript("OnMouseWheel", function(self, delta)
		local scrollBar = self:GetParent():GetParent().scrollBar
		
		local current = scrollBar:GetValue()
		local minV, maxV = scrollBar:GetMinMaxValues()
			
		if delta < 0 and current >= minV then
			scrollBar:SetValue(math.min(maxV, current+30))
		elseif delta > 0 and current <= maxV then
			scrollBar:SetValue(math.max(minV, current-30))
		end
	end)
	
	local newvalue = table.concat(self.db.global.additionalButtons, "\n")
	additionalScroll.EditBox.previousText = newvalue
	additionalScroll.EditBox:SetText(newvalue)
	additionalScroll.EditBox:SetMaxLetters(0)
	additionalScroll.EditBox:SetWidth(additionalScroll:GetWidth())
	additionalScroll.EditBox:Enable()
	additionalScroll.EditBox:SetFont(STANDARD_TEXT_FONT, 16)
	
	additionalScroll.EditBox:SetScript("OnEnterPressed", nil)
	
	additionalScroll.EditBox:SetScript("OnTextChanged", function(self)
		if self.previousText ~= self:GetText() then
			DialogKey.options.content.additionalSave:Show()
		end
		
		self.previousText = self:GetText()
	end)
	
	local additionalSave = CreateFrame("Button", nil, optionsContent, "UIPanelButtonTemplate")
	additionalSave:SetPoint("BOTTOMRIGHT", optionsContent.additionalScroll, "TOPRIGHT", 7,4)
	additionalSave:SetWidth(50)
	additionalSave:SetHeight(20)
	additionalSave:SetText("Save")
	additionalSave:SetScript("OnClick", DialogKey.SaveAdditionalButtons)
	additionalSave:Hide()
	optionsContent.additionalSave = additionalSave
	
	local additionalTitle = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	additionalTitle:SetFont(STANDARD_TEXT_FONT, 12)
	additionalTitle:SetTextColor(1,1,1,1)
	additionalTitle:SetJustifyH("LEFT")
	additionalTitle:SetText("Additional buttons to click")
	additionalTitle:SetPoint("BOTTOMLEFT", optionsContent.additionalScroll, "TOPLEFT", -4, 6)
	
	local additionalExplanation = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	additionalExplanation:SetFont(STANDARD_TEXT_FONT, 10)
	additionalExplanation:SetTextColor(1,1,1,1)
	additionalExplanation:SetJustifyH("LEFT")
	additionalExplanation:SetWordWrap(true)
	additionalExplanation:SetWidth(240)
	additionalExplanation:SetText("Type a button's name here to track it. DialogKey will attempt to click on any tracked buttons when you hit the bound key. Note: not all buttons can be tracked.\n\nTo track a new button, hover over it and type \n|cffffff00/dialogkey add|r\nTo untrack a button, hover over it and type \n|cffffff00/dialogkey remove|r")
	additionalExplanation:SetPoint("TOPLEFT", optionsContent.additionalScroll, "TOPRIGHT", 15, 0)
	
	
	-- Dialog blacklist
	local blacklistScroll = CreateFrame("ScrollFrame", "DialogKeyScrollFrame", optionsContent, "InputScrollFrameTemplate")
	blacklistScroll:SetSize(300,150)
	blacklistScroll:SetPoint("TOPLEFT", additionalScroll, "BOTTOMLEFT", 0, -40)
	blacklistScroll.CharCount:Hide()
	optionsContent.blacklistScroll = blacklistScroll
	
	-- to scroll the options frame if we're hovered over this scrollbox and scroll the mouse wheel
	blacklistScroll:EnableMouseWheel(true)
	blacklistScroll:SetScript("OnMouseWheel", function(self, delta)
		local scrollBar = self:GetParent():GetParent().scrollBar
		
		local current = scrollBar:GetValue()
		local minV, maxV = scrollBar:GetMinMaxValues()
			
		if delta < 0 and current >= minV then
			scrollBar:SetValue(math.min(maxV, current+30))
		elseif delta > 0 and current <= maxV then
			scrollBar:SetValue(math.max(minV, current-30))
		end
	end)
	
	local blacklistValue = table.concat(self.db.global.dialogBlacklist, "\n")
	blacklistScroll.EditBox.previousText = blacklistValue
	blacklistScroll.EditBox:SetText(blacklistValue)
	blacklistScroll.EditBox:SetMaxLetters(0)
	blacklistScroll.EditBox:SetWidth(blacklistScroll:GetWidth())
	blacklistScroll.EditBox:Enable()
	blacklistScroll.EditBox:SetFont(STANDARD_TEXT_FONT, 16)
	
	blacklistScroll.EditBox:SetScript("OnEnterPressed", nil)
	
	blacklistScroll.EditBox:SetScript("OnTextChanged", function(self)
		if self.previousText ~= self:GetText() then
			DialogKey.options.content.blacklistSave:Show()
		end
		
		self.previousText = self:GetText()
	end)
	
	local blacklistSave = CreateFrame("Button", nil, optionsContent, "UIPanelButtonTemplate")
	blacklistSave:SetPoint("BOTTOMRIGHT", optionsContent.blacklistScroll, "TOPRIGHT", 7,4)
	blacklistSave:SetWidth(50)
	blacklistSave:SetHeight(20)
	blacklistSave:SetText("Save")
	blacklistSave:SetScript("OnClick", DialogKey.SaveBlacklist)
	blacklistSave:Hide()
	optionsContent.blacklistSave = blacklistSave
	
	-- Blacklist title
	local blacklistTitle = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	blacklistTitle:SetFont(STANDARD_TEXT_FONT, 12)
	blacklistTitle:SetTextColor(1,1,1,1)
	blacklistTitle:SetJustifyH("LEFT")
	blacklistTitle:SetText("Confirmation dialog blacklist")
	blacklistTitle:SetPoint("BOTTOMLEFT", optionsContent.blacklistScroll, "TOPLEFT", -4, 6)
	
	-- Blacklist description
	local blacklistExplanation = optionsContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	blacklistExplanation:SetFont(STANDARD_TEXT_FONT, 10)
	blacklistExplanation:SetTextColor(1,1,1,1)
	blacklistExplanation:SetJustifyH("LEFT")
	blacklistExplanation:SetWordWrap(true)
	blacklistExplanation:SetWidth(240)
	blacklistExplanation:SetText("Type strings of text here, one per line, to blacklist any confirmation dialog containing the text. If a dialog is blacklisted, DialogKey won't attempt to click any button in it. For example, enter\n\n|cffffff00invites you to a group|r\n\nand DialogKey won't accept group invites.")
	blacklistExplanation:SetPoint("TOPLEFT", optionsContent.blacklistScroll, "TOPRIGHT", 15, 0)]]

	
	self.options.name = DialogKey_TITLE
	InterfaceOptions_AddCategory(self.options)
end

-- Binding mode --
function DialogKey:EnableKeybindMode(index)	-- Enables keybinding mode in the options frame
	--self.options.content.additionalScroll.EditBox:ClearFocus()
	
	if self.keybindMode then
		return
	end
	
	-- Disable all other keybind buttons
	for i,button in pairs(self.options.content.keybindButtons) do
		if i ~= index then
			button:Disable()
		end
	end
	
	self.keybindMode = true
	self.keybindIndex = index
	self.options.content.keybindReminder:Show()
	self.frame:SetPropagateKeyboardInput(false)
end

function DialogKey:DisableKeybindMode()		-- Disables keybinding mode in the options frame
	DialogKey.keybindMode = false
	DialogKey.options.content.keybindReminder:Hide()
	
	-- Enable all keybind buttons
	for i,button in pairs(DialogKey.options.content.keybindButtons) do
		button:Enable()
	end
	
	DialogKey.timer = DialogKey:ScheduleTimer(function()
		DialogKey.frame:SetPropagateKeyboardInput(true)
	end, 0.1)
end

function DialogKey:HandleKeybind(key)		-- Run for a keypress during binding mode; saves that key as the bound one
	self.options.content.keybindButtons[self.keybindIndex]:SetText(GetBindingText(key))
	self.db.global.keys[self.keybindIndex] = key
	DialogKey:DisableKeybindMode()
	
	-- Clear this assignment from other options so you don't have both options set to SPACE or whatever; not necessary, but clean
	for i,thiskey in pairs(self.db.global.keys) do
		if i ~= self.keybindIndex and thiskey == key then
			self.db.global.keys[i] = nil
			self.options.content.keybindButtons[i]:SetText("")
		end
	end
end

function DialogKey:ClearBind(index)			-- Clears the keybind from the given binding button
	DialogKey.db.global.keys[index] = nil
	DialogKey.options.content.keybindButtons[index]:SetText("")
end

-- Options frame helpers --
function DialogKey:SaveAdditionalButtons()	-- Save the button names in the additional input to the saved settings
	self:Hide()
	--local editbox = DialogKey.options.content.additionalScroll.EditBox
	--editbox:ClearFocus()
	
	local final = {}
	for i,name in pairs({strsplit("\n",editbox:GetText())}) do
		name = strtrim(name)
		if name:len() > 0 then
			tinsert(final, name)
		end
	end
	
	DialogKey.db.global.additionalButtons = final
end

--[[function DialogKey:UpdateAdditionalFrames()	-- Updates the "Additional buttons" textbox with the latest settings
	local editbox = self.options.content.additionalScroll.EditBox
	local newvalue = table.concat(self.db.global.additionalButtons, "\n")
	editbox.previousText = newvalue
	editbox:SetText(newvalue)
end

function DialogKey:SaveBlacklist()			-- Save the button names in the additional input to the saved settings
	self:Hide()
	local editbox = DialogKey.options.content.blacklistScroll.EditBox
	editbox:ClearFocus()
	
	local final = {}
	for i,name in pairs({strsplit("\n",editbox:GetText())}) do
		name = strtrim(name)
		if name:len() > 0 then
			tinsert(final, name)
		end
	end
	
	DialogKey.db.global.dialogBlacklist = final
end

function DialogKey:UpdateBlacklist()		-- Updates the "Additional buttons" textbox with the latest settings
	local editbox = self.options.content.blacklistScroll.EditBox
	local newvalue = table.concat(self.db.global.dialogBlacklist, "\n")
	editbox.previousText = newvalue
	editbox:SetText(newvalue)
end]]

function DialogKey:ValueToString(value)		-- Returns 'Disabled' for 0, '1 second' for 1, 'x seconds' for anything else
	if value == 0 then
		return "XXX"
	else
		return value .. " s"
	end
end
