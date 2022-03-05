local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

function MISC:CreateRM()
	if not R.db["Misc"]["RaidTool"] then return end

	local tinsert, strsplit, format = table.insert, string.split, string.format
	local next, pairs, mod = next, pairs, mod

	local header = CreateFrame("Button", nil, UIParent)
	header:SetSize(80, 36)
	header:SetFrameLevel(2)
	M.Mover(header, U["BattleResurrect"], "Battle Resurrect", R.Skins.RMPos)
	header:RegisterEvent("GROUP_ROSTER_UPDATE")
	header:RegisterEvent("PLAYER_ENTERING_WORLD")
	header:SetScript("OnEvent", function(self)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if IsInGroup() then
			self:Show()
		else
			self:Hide()
		end
	end)
  
	-- Battle resurrect
	local resFrame = CreateFrame("Frame", nil, header)
	resFrame:SetAllPoints()
	resFrame:SetAlpha(0)
	local res = CreateFrame("Frame", nil, resFrame)
	res:SetSize(31, 31)
	res:SetPoint("LEFT", 5, 0)
	M.PixelIcon(res, GetSpellTexture(20484))
	res.Count = M.CreateFS(res, 21, "0")
	res.Count:ClearAllPoints()
	res.Count:SetPoint("LEFT", res, "RIGHT", 3, -2)
	res.Timer = M.CreateFS(resFrame, 16, "00:00", false, "BOTTOMLEFT", 2, -16)

	res:SetScript("OnUpdate", function(self, elapsed)
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed > .1 then
			local charges, _, started, duration = GetSpellCharges(20484)
			if charges then
				local timer = duration - (GetTime() - started)
				if timer < 0 then
					self.Timer:SetText("0:0")
				else
					self.Timer:SetFormattedText("%d:%.2d", timer/60, timer%60)
				end
				self.Count:SetText(charges)
				if charges == 0 then
					self.Count:SetTextColor(1, 0, 0)
				else
					self.Count:SetTextColor(0, 1, 0)
				end
				resFrame:SetAlpha(1)
			else
				resFrame:SetAlpha(0)
			end

			self.elapsed = 0
		end
	end)
	res:SetScript("OnMouseDown", function(self)
	  local charges, _, started, duration = GetSpellCharges(20484)
	    if charges then
	        local timer = duration - (GetTime() - started)
				if timer < 0 then
					self.Timer:SetText("0:0")
				else
					self.Timer:SetFormattedText("%d:%.2d", timer/60, timer%60)
				end
		SendChatMessage(U["BattleResurrectCount"]..charges..U["BattleResurrectNext"]..self.Timer:GetText(), "YELL")
		else
		return
		end
	end)
	
	header:HookScript("OnShow", function(self)
		self:SetBackdropColor(0, 0, 0, .5)
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end)
end