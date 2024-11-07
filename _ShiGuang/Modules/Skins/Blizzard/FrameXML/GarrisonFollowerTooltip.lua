local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	-- Tooltip close buttons
	M.ReskinClose(ItemRefTooltip.CloseButton)
	M.ReskinClose(FloatingBattlePetTooltip.CloseButton)
	M.ReskinClose(FloatingPetBattleAbilityTooltip.CloseButton)

	if not R.db["Skins"]["BlizzardSkins"] then return end

	-- Tooltips
	function M:ReskinGarrisonTooltip()
		if self.Icon then M.ReskinIcon(self.Icon) end
		if self.CloseButton then M.ReskinClose(self.CloseButton) end
	end

	M.ReskinGarrisonTooltip(FloatingGarrisonMissionTooltip)
	M.ReskinGarrisonTooltip(GarrisonFollowerTooltip)
	M.ReskinGarrisonTooltip(FloatingGarrisonFollowerTooltip)
	M.ReskinGarrisonTooltip(GarrisonFollowerAbilityTooltip)
	M.ReskinGarrisonTooltip(FloatingGarrisonFollowerAbilityTooltip)
	M.ReskinGarrisonTooltip(GarrisonShipyardFollowerTooltip)
	M.ReskinGarrisonTooltip(FloatingGarrisonShipyardFollowerTooltip)

	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", function(tooltipFrame)
		-- Abilities
		if tooltipFrame.numAbilitiesStyled == nil then
			tooltipFrame.numAbilitiesStyled = 1
		end

		local numAbilitiesStyled = tooltipFrame.numAbilitiesStyled
		local abilities = tooltipFrame.Abilities
		local ability = abilities[numAbilitiesStyled]
		while ability do
			M.ReskinIcon(ability.Icon)

			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end

		tooltipFrame.numAbilitiesStyled = numAbilitiesStyled

		-- Traits
		if tooltipFrame.numTraitsStyled == nil then
			tooltipFrame.numTraitsStyled = 1
		end

		local numTraitsStyled = tooltipFrame.numTraitsStyled
		local traits = tooltipFrame.Traits
		local trait = traits[numTraitsStyled]
		while trait do
			M.ReskinIcon(trait.Icon)

			numTraitsStyled = numTraitsStyled + 1
			trait = traits[numTraitsStyled]
		end

		tooltipFrame.numTraitsStyled = numTraitsStyled
	end)
end)