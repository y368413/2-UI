--## Author: Anase Skyrider
--## Version: 1.1
--TalentNotesDB = TalentNotesDB or {}

local TalentNotes = {}

function TalentNotes.defaultDB()
	if ShiGuangDB["editBoxes"] == nil then
		ShiGuangDB["editBoxes"] = {}

		for c=1, GetNumClasses() do
			local _, classFile = GetClassInfo(c)
			ShiGuangDB["editBoxes"][classFile] = {}
			for s=1, GetNumSpecializationsForClassID(c) do
				ShiGuangDB["editBoxes"][classFile][s] = {}
			end
		end
	end
end
function TalentNotes.createBaseFrame()
	local baseFrame = CreateFrame("Frame", "TalentNotesFrame", UIParent)
	baseFrame:SetAllPoints(UIParent)
	baseFrame:SetFrameStrata("BACKGROUND")

	--baseFrame.tooltip = CreateFrame("GameTooltip", "TalentNotesFrameTooltip", baseFrame, "GameTooltipTemplate")

	return baseFrame
end

function TalentNotes.createEditBoxes(baseFrame, talentFrame) -- Returns table containing editBoxes.
	local boxes = {}
	for r = 1, 7 do -- Iterate talent rows
		local row = "TalentRow"..r

		for c = 1, 3 do -- Iterate talent columns
			local col = "Talent"..c
			local tFrame = _G[talentFrame..row..col]
			tFrame = (tFrame.bg ~= nil and tFrame.bg) or tFrame
			local n = ((r-1)*3)+c -- The current talent number

			boxes[n] = CreateFrame("EditBox", "TalentNotesFrameEditBox"..n, baseFrame, BackdropTemplateMixin and "BackdropTemplate")
			local box = boxes[n]
			box.id = n
			box.row = r
			box.column = c
			box.currentSpecIndex = GetSpecialization()
			box.width = tFrame:GetWidth()+1
			box.height = 10

			box:SetFrameStrata("HIGH")
			box:SetSize(box.width, box.height)
			box:SetPoint("TOPLEFT", tFrame, "BOTTOMLEFT", 0, 0)
			box:SetAutoFocus(false)
			box:SetCursorPosition(0)

			box:SetBackdrop( {
					bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
					edgeFile = "Interface/buttons/white8x8", --"Interface/Tooltips/UI-Tooltip-Border", 
					edgeSize = 1, --14,
					insets = { left = 0, right = 0, top = 0, bottom = 0 } --{ left = 4, right = 4, top = 4, bottom = 4 }
			} )
			box:SetBackdropColor(0,0,0,0.5)
			box:SetBackdropBorderColor(0,0,0,0.75)
			box:SetTextInsets(2, 2, 0, 0)
			box:SetFont(STANDARD_TEXT_FONT, 10) -- "Fonts/FRIZQT__.TTF", 11
			--box:FontTemplate()
			
			-- Scripts and Functions
			function box:UpdateText(specIndex)
				local _, playerClass = UnitClass("player")
				local text = ShiGuangDB["editBoxes"][playerClass][specIndex][self.id] or "??"
				self:SetText(text)
			end
			function box:SaveText(specIndex)
				local _, playerClass = UnitClass("player")
				ShiGuangDB["editBoxes"][playerClass][specIndex][self.id] = self:GetText()
			end
			box:SetScript("OnEnterPressed", function(self) self:ClearFocus() self:SetCursorPosition(0) end)
			box:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetCursorPosition(0) end)
			box:SetScript("OnEditFocusLost",
				function(self)
					self:SaveText(self.currentSpecIndex)
					self:HighlightText(0,0)
				end
			)
			box:SetScript("OnTabPressed",
				function(self)
					if boxes[n+1] then
						boxes[n+1]:SetFocus()
					end
				end
			)
			box:SetScript("OnEnter",
				function(self)
					local tip = GameTooltip
					tip:SetOwner(self, "ANCHOR_RIGHT")
					tip:SetText("Talent Note", nil, nil, nil, nil, true)
					tip:AddLine(self:GetText(), 1, 1, 1, 1, true)
					tip:Show()
				end
			)
			box:SetScript("OnLeave",
				function(self)
					local tip = GameTooltip
					tip:Hide()
				end
			)
		end
	end
	return boxes
end

function TalentNotes.createSpecButtons(baseFrame, talentFrame)
	local buttons = {}
	buttons.rows = {}
	for r = 1, 7 do -- Iterate talent rows
		buttons.rows[r] = {}

		local row = "TalentRow"..r
		local specNum = GetNumSpecializations()
		for specIndex = 1, specNum do
			local rFrame = _G[talentFrame..row]
			local n = ((r-1)*specNum)+specIndex

			buttons.rows[r][specIndex] = CreateFrame("Button", "TalentNotesFrameSpecButtonRow"..r.."Button"..specIndex, baseFrame)
			local button = buttons.rows[r][specIndex]
			button.id = n
			button.row = r
			button.specIndex = specIndex

			local _,_,_,iconPath = GetSpecializationInfo(specIndex)
			local size = (rFrame:GetHeight()/specNum)
			button:SetSize(size, size)
			button:SetPoint("TOPRIGHT", rFrame, "TOPLEFT", 56, -(size*(specIndex-1)))
			button:SetFrameStrata("HIGH")
			button:SetNormalTexture(iconPath)
			--button:StyleButton()

			local pushTex = button:CreateTexture(nil, "ARTWORK")
			pushTex:SetTexture(iconPath)
			pushTex:SetSize(size, size)
			pushTex:SetPoint("CENTER", button, "CENTER", 1, -1)
			button:SetPushedTexture(pushTex)
			
			local disTex = button:CreateTexture(nil, "ARTWORK")
			disTex:SetTexture(iconPath)
			disTex:SetSize(size, size)
			disTex:SetAllPoints()
			disTex:SetDesaturated(true)
			button:SetDisabledTexture(disTex)

			if button.specIndex == GetSpecialization() then
				button:Disable()
			end

			button:RegisterForClicks("LeftButtonUp")

			--Scripts and Functions
			function button:UpdateAble(specIndex)
				if specIndex then
					if self.specIndex == specIndex then
						self:Disable()
					else
						self:Enable()
					end
				else
					if self.specIndex == GetSpecialization() then
						self:Disable()
					else
						self:Enable()
					end
				end
			end
			function button:UpdateButtonRow(specIndex)
				for k,v in pairs(buttons.rows[self.row]) do
					v:UpdateAble(specIndex)
				end
			end
			button:SetScript("OnClick",
				function(self, button, down)
					local editBoxes = self:GetParent().editBoxes
					for k,v in pairs(editBoxes) do
						if v.row == self.row then
							v.currentSpecIndex = self.specIndex
							v:UpdateText(self.specIndex)
						end
					end

					self:UpdateButtonRow(self.specIndex)
				end
			)
		end
	end

	return buttons
end

function TalentNotes.createTalentUI(baseFrame)
	LoadAddOn("Blizzard_TalentUI")
	local talentFrame = "PlayerTalentFrameTalents"

	local boxes = TalentNotes.createEditBoxes(baseFrame, talentFrame)
	local buttons = TalentNotes.createSpecButtons(baseFrame, talentFrame)

	return boxes, buttons
end

function TalentNotes.updateAllEditBoxText(editBoxes)
	if editBoxes == nil then return end
	
	local specIndex = GetSpecialization()
	for k,v in pairs(editBoxes) do
		v.currentSpecIndex = specIndex
		v:UpdateText(specIndex)
	end
end

function TalentNotes.updateAllSpecButtons(buttons)
	if buttons == nil then return end

	local specIndex = GetSpecialization()
	for rk,rv in pairs(buttons.rows) do
		for bk,bv in pairs(rv) do
			bv:UpdateAble(specIndex)
		end
	end
end

local TNotesUI = TalentNotes.createBaseFrame()

TNotesUI:SetScript("OnEvent",
	function(self, event, ...)
		if self[event] then
			return self[event](self, ...)
		end
	end
)
local events = {"PLAYER_LOGIN", "ADDON_LOADED", "ACTIVE_TALENT_GROUP_CHANGED"}
for k,v in pairs(events) do	TNotesUI:RegisterEvent(v) end

function TNotesUI:ADDON_LOADED(addon)
	if addon == "_ShiGuang" then
		TalentNotes.defaultDB()
	elseif addon == "Blizzard_TalentUI" then
		PlayerTalentFrameTalents:HookScript("OnShow",
			function(self)
				C_Timer.After(0.001, function() TNotesUI:SetShown(true) end)
			end
		)
		PlayerTalentFrameTalents:HookScript("OnHide",
			function(self)
				C_Timer.After(0.001, function() TNotesUI:SetShown(false) end)
			end
		)
		PlayerTalentFrameSpecialization:HookScript("OnShow",
			function(self)
				C_Timer.After(0.001, function() TNotesUI:SetShown(false) end)
			end
		)
		PlayerTalentFramePetSpecialization:HookScript("OnShow",
			function(self)
				C_Timer.After(0.001, function() TNotesUI:SetShown(false) end)
			end	
		)	
	end
end

function TNotesUI:PLAYER_LOGIN()
	TNotesUI.editBoxes, TNotesUI.specButtons = TalentNotes.createTalentUI(TNotesUI)
	TalentNotes.updateAllEditBoxText(TNotesUI.editBoxes)
	TNotesUI:SetShown(false)
end

function TNotesUI:ACTIVE_TALENT_GROUP_CHANGED()
	TalentNotes.updateAllEditBoxText(TNotesUI.editBoxes)
	TalentNotes.updateAllSpecButtons(TNotesUI.specButtons)
end