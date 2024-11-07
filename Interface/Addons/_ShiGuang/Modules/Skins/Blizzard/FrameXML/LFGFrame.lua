local _, ns = ...
local M, R, U, I = unpack(ns)

local function styleRewardButton(button)
	if not button or button.styled then return end

	local buttonName = button:GetName()
	local icon = _G[buttonName.."IconTexture"]
	local shortageBorder = _G[buttonName.."ShortageBorder"]
	local count = _G[buttonName.."Count"]
	local nameFrame = _G[buttonName.."NameFrame"]
	local border = button.IconBorder

	button.bg = M.ReskinIcon(icon)
	local bg = M.CreateBDFrame(button, .25)
	bg:SetPoint("TOPLEFT", button.bg, "TOPRIGHT", 1, 0)
	bg:SetPoint("BOTTOMRIGHT", button.bg, "BOTTOMRIGHT", 105, 0)

	if shortageBorder then shortageBorder:SetAlpha(0) end
	if count then count:SetDrawLayer("OVERLAY") end
	if nameFrame then nameFrame:SetAlpha(0) end
	if border then M.ReskinIconBorder(border) end

	button.styled = true
end

local function reskinDialogReward(button)
	if button.styled then return end

	local border = _G[button:GetName().."Border"]
	button.texture:SetTexCoord(unpack(I.TexCoord))
	border:SetColorTexture(0, 0, 0)
	border:SetDrawLayer("BACKGROUND")
	border:SetOutside(button.texture)
	button.styled = true
end

local function styleRewardRole(roleIcon)
	if roleIcon and roleIcon:IsShown() then
		M.ReskinSmallRole(roleIcon.texture, roleIcon.role)
	end
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end
	-- LFDFrame
	hooksecurefunc("LFGDungeonListButton_SetDungeon", function(button)
		if not button.expandOrCollapseButton.styled then
			M.ReskinCheck(button.enableButton)
			M.ReskinCollapse(button.expandOrCollapseButton)

			button.expandOrCollapseButton.styled = true
		end

		button.enableButton:GetCheckedTexture():SetAtlas("checkmark-minimal")
		local disabledTexture = button.enableButton:GetDisabledCheckedTexture()
		disabledTexture:SetAtlas("checkmark-minimal")
		disabledTexture:SetDesaturated(true)
	end)

	M.StripTextures(LFDParentFrame)
	LFDQueueFrameBackground:Hide()
	M.SetBD(LFDRoleCheckPopup)
	LFDRoleCheckPopup.Border:Hide()
	M.Reskin(LFDRoleCheckPopupAcceptButton)
	M.Reskin(LFDRoleCheckPopupDeclineButton)
	M.ReskinTrimScroll(LFDQueueFrameSpecific.ScrollBar)
	M.ReskinTrimScroll(LFDQueueFrameRandomScrollFrame.ScrollBar)
	M.ReskinDropDown(LFDQueueFrameTypeDropdown)
	M.Reskin(LFDQueueFrameFindGroupButton)
	M.Reskin(LFDQueueFramePartyBackfillBackfillButton)
	M.Reskin(LFDQueueFramePartyBackfillNoBackfillButton)
	M.Reskin(LFDQueueFrameNoLFDWhileLFRLeaveQueueButton)
	styleRewardButton(LFDQueueFrameRandomScrollFrameChildFrameMoneyReward)

	-- LFGFrame
	hooksecurefunc("LFGRewardsFrame_SetItemButton", function(parentFrame, _, index)
		local parentName = parentFrame:GetName()
		styleRewardButton(parentFrame.MoneyReward)

		local button = _G[parentName.."Item"..index]
		styleRewardButton(button)
		styleRewardRole(button.roleIcon1)
		styleRewardRole(button.roleIcon2)
	end)

	hooksecurefunc("LFGDungeonReadyDialogReward_SetMisc", function(button)
		reskinDialogReward(button)
		button.texture:SetTexture("Interface\\Icons\\inv_misc_coin_02")
	end)

	hooksecurefunc("LFGDungeonReadyDialogReward_SetReward", function(button, dungeonID, rewardIndex, rewardType, rewardArg)
		reskinDialogReward(button)

		local texturePath
		if rewardType == "reward" then
			texturePath = select(2, GetLFGDungeonRewardInfo(dungeonID, rewardIndex))
		elseif rewardType == "shortage" then
			texturePath = select(2, GetLFGDungeonShortageRewardInfo(dungeonID, rewardArg, rewardIndex))
		end
		if texturePath then
			button.texture:SetTexture(texturePath)
		end
	end)

	M.StripTextures(LFGDungeonReadyDialog, 0)
	M.SetBD(LFGDungeonReadyDialog)
	M.StripTextures(LFGInvitePopup)
	M.SetBD(LFGInvitePopup)
	M.StripTextures(LFGDungeonReadyStatus)
	M.SetBD(LFGDungeonReadyStatus)

	M.Reskin(LFGDungeonReadyDialogEnterDungeonButton)
	M.Reskin(LFGDungeonReadyDialogLeaveQueueButton)
	M.Reskin(LFGInvitePopupAcceptButton)
	M.Reskin(LFGInvitePopupDeclineButton)
	M.ReskinClose(LFGDungeonReadyDialogCloseButton)
	M.ReskinClose(LFGDungeonReadyStatusCloseButton)

	local roleButtons = {
		-- tank
		LFDQueueFrameRoleButtonTank,
		LFDRoleCheckPopupRoleButtonTank,
		RaidFinderQueueFrameRoleButtonTank,
		LFGInvitePopupRoleButtonTank,
		LFGListApplicationDialog.TankButton,
		LFGDungeonReadyStatusGroupedTank,
		-- healer
		LFDQueueFrameRoleButtonHealer,
		LFDRoleCheckPopupRoleButtonHealer,
		RaidFinderQueueFrameRoleButtonHealer,
		LFGInvitePopupRoleButtonHealer,
		LFGListApplicationDialog.HealerButton,
		LFGDungeonReadyStatusGroupedHealer,
		-- dps
		LFDQueueFrameRoleButtonDPS,
		LFDRoleCheckPopupRoleButtonDPS,
		RaidFinderQueueFrameRoleButtonDPS,
		LFGInvitePopupRoleButtonDPS,
		LFGListApplicationDialog.DamagerButton,
		LFGDungeonReadyStatusGroupedDamager,
		-- leader
		LFDQueueFrameRoleButtonLeader,
		RaidFinderQueueFrameRoleButtonLeader,
		LFGDungeonReadyStatusRolelessReady,
	}
	for _, roleButton in pairs(roleButtons) do
		M.ReskinRole(roleButton)
	end

	hooksecurefunc("SetCheckButtonIsRadio", function(button)
		button:SetNormalTexture(0)
		button:SetHighlightTexture(I.bdTex)
		button:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		button:GetCheckedTexture():SetTexCoord(0, 1, 0, 1)
		button:SetPushedTexture(0)
		button:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		button:GetDisabledCheckedTexture():SetTexCoord(0, 1, 0, 1)
	end)

	-- RaidFinder
	RaidFinderFrameBottomInset:Hide()
	RaidFinderFrameRoleBackground:Hide()
	RaidFinderFrameRoleInset:Hide()
	RaidFinderQueueFrameBackground:Hide()
	-- this fixes right border of second reward being cut off
	RaidFinderQueueFrameScrollFrame:SetWidth(RaidFinderQueueFrameScrollFrame:GetWidth()+1)

	M.ReskinTrimScroll(RaidFinderQueueFrameScrollFrame.ScrollBar)
	M.ReskinDropDown(RaidFinderQueueFrameSelectionDropdown)
	M.Reskin(RaidFinderFrameFindRaidButton)
	M.Reskin(RaidFinderQueueFrameIneligibleFrameLeaveQueueButton)
	M.Reskin(RaidFinderQueueFramePartyBackfillBackfillButton)
	M.Reskin(RaidFinderQueueFramePartyBackfillNoBackfillButton)
	styleRewardButton(RaidFinderQueueFrameScrollFrameChildFrameMoneyReward)
end)