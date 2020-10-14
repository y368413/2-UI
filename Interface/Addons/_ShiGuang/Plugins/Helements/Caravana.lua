-- Make Campfire = 312370   ## Author: gi2k15  ## Version: 0.1
-- Return to Camp = 312372

local Caravana = CreateFrame("Frame")
Caravana:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
Caravana:SetScript("OnEvent", function(self, event, ...)
	local _,_,spellID = ...
	if spellID == 312370 then
		local subzone, zone = GetSubZoneText(), GetZoneText()
		if subzone == "" then
			ShiGuangDB[Caravana] = zone
		else
			ShiGuangDB[Caravana] = string.format("%s, %s", subzone, zone)
		end
	end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local _,SpellID = self:GetSpell()
	if SpellID == 312372 and ShiGuangDB[Caravana] then
		self:AddLine("@ " .. ShiGuangDB[Caravana],0.94,0.9,0.55,true)
	end
end)