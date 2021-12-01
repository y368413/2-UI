local defaults_settings = {
	profile = {
		disableFX = false,
		conduitTooltipRank = true,
		soulbindScale = 0.8,
	}
}

local SoulbindsTalents = LibStub("AceAddon-3.0"):NewAddon("SoulbindsTalents")

LibStub("AceEvent-3.0"):Embed(SoulbindsTalents)
LibStub("AceHook-3.0"):Embed(SoulbindsTalents)

local SOULBIND_TAB = 4

local CONDUIT_RANKS = {
	[1] = C_Soulbinds.GetConduitItemLevel(0, 1),
	[2] = C_Soulbinds.GetConduitItemLevel(0, 2),
	[3] = C_Soulbinds.GetConduitItemLevel(0, 3),
	[4] = C_Soulbinds.GetConduitItemLevel(0, 4),
	[5] = C_Soulbinds.GetConduitItemLevel(0, 5),
	[6] = C_Soulbinds.GetConduitItemLevel(0, 6),
	[7] = C_Soulbinds.GetConduitItemLevel(0, 7),
	[8] = C_Soulbinds.GetConduitItemLevel(0, 8),
}

function SoulbindsTalents:OnEnable()
	self.db = LibStub("AceDB-3.0"):New("SoulbindsTalentsDB", defaults_settings, true)
	self.settings = self.db.profile

	self:SetupOptions()

	self:RegisterEvent("ADDON_LOADED")

	self:SecureHookScript(GameTooltip, 'OnTooltipSetItem', 'TooltipHook')
	self:SecureHookScript(ItemRefTooltip, 'OnTooltipSetItem', 'TooltipHook')
	self:SecureHookScript(EmbeddedItemTooltip, 'OnTooltipSetItem', 'TooltipHook')

	local _, playerClass = UnitClass("player");
	if (playerClass == "HUNTER") then
		self.petTab = true
	end

	self.previousTab = 1
end

function SoulbindsTalents:SetupOptions()
	self.options = {
		type = "group",
		set = function(info, val) self.db.profile[info[#info]] = val end,
		get = function(info) return self.db.profile[info[#info]] end,
		args = {
			author = {
				type = "description",
				name = "|cffffd100Author: |r Kygo @ EU-Hyjal",
				order = 1
			},
			version = {
				type = "description",
				name = "|cffffd100Version: 1.0.7|r",
				order = 2
			},
			title = {
				type = "description",
				fontSize = "large",
				name = "\n\n|cffffd100Options :|r\n\n",
				order = 3
			},
			disableFX = {
				name = "Disable FX",
				desc = "Disable all FXs (Improves FPS when opened).",
				width = "full",
				type = "toggle",
				order = 10,
			},
			conduitTooltipRank = {
				name = "Show Conduit Rank on Tooltip",
				desc = "Replace Item Level of Conduits by its Rank",
				type = "toggle",
				width = "full",
				order = 11,
			},
			soulbindScale = {
				type = "range",
				isPercent = true,
				name = "Soulbind Frame Scale",
				desc = "Set the scale of the Soulbind Frame",
				min = 0.5,
				max = 1.5,
				step = 0.05,
				order = 12,
			},
		}
	}

	LibStub("AceConfig-3.0"):RegisterOptionsTable("SoulbindsTalents", self.options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SoulbindsTalents", "SoulbindsTalents")
end

function SoulbindsTalents:PlayerTalentFrame_Refresh()
	if not self.created then
		PlayerTalentFrameTab4 = CreateFrame("Button", "$parentTab4", PlayerTalentFrame, "PlayerTalentTabTemplate", SOULBIND_TAB)
		PlayerTalentFrameTab4:SetPoint("LEFT", self.petTab and PlayerTalentFrameTab3 or PlayerTalentFrameTab2, "RIGHT", -15, 0)
		PlayerTalentFrameTab4:SetText(COVENANT_PREVIEW_SOULBINDS)
		PanelTemplates_TabResize(PlayerTalentFrameTab4, 0, nil, 36, PlayerTalentFrameTab4:GetParent().maxTabWidth or 88);

		PanelTemplates_SetNumTabs(PlayerTalentFrame, 4)

		if ElvUI then
			local Engine = unpack(ElvUI)
			Engine:GetModule('Skins'):HandleTab(PlayerTalentFrameTab4)
		end
		self.created = true
	end

	if C_Soulbinds.GetActiveSoulbindID() == 0 then
		PlayerTalentFrameTab4:SetEnabled(false)
		PlayerTalentFrameTab4Text:SetFormattedText("|cff808080%s|r", COVENANT_PREVIEW_SOULBINDS)
	else
		PlayerTalentFrameTab4:SetEnabled(true)
		PlayerTalentFrameTab4Text:SetText(COVENANT_PREVIEW_SOULBINDS)
	end

	local selectedTab = PanelTemplates_GetSelectedTab(PlayerTalentFrame);

	if InCombatLockdown() then
		PlayerTalentFrameTab4:SetEnabled(false)
		PlayerTalentFrameTab4Text:SetFormattedText("|cff808080%s|r", COVENANT_PREVIEW_SOULBINDS)
		self:RegisterEvent("PLAYER_REGEN_ENABLED", function(event)
			PlayerTalentFrameTab4:SetEnabled(true)
			PlayerTalentFrameTab4Text:SetText(COVENANT_PREVIEW_SOULBINDS)
			self:UnregisterEvent(event)
		end)
	end

	if (selectedTab == SOULBIND_TAB) then
		if UIParentLoadAddOn("Blizzard_Soulbinds") then
			if InCombatLockdown() then
				PanelTemplates_SetTab(PlayerTalentFrame, self.previousTab)
				return;
			end
			HideUIPanel(PlayerTalentFrame)
			SoulbindViewer:Open()
		end
	end
	self.previousTab = selectedTab
end

function SoulbindsTalents:PlayerTalentFrame_Toggle()
	local selectedTab = PanelTemplates_GetSelectedTab(PlayerTalentFrame);
	if selectedTab == SOULBIND_TAB then
		if SoulbindViewer:IsShown() and not self.checked then
			HideUIPanel(SoulbindViewer)
			self.checked = true
			return
		end
		self.checked = false
	end
end

function SoulbindsTalents:SoulbindViewer_ChangeTab()
	if C_Soulbinds.HasAnyPendingConduits() then
		local onConfirm = function()
			UIPanelCloseButton_OnClick(SoulbindViewer.CloseButton);
			ShowUIPanel(PlayerTalentFrame)
		end;
		StaticPopup_Show("SOULBIND_CONDUIT_NO_CHANGES_CONFIRMATION", nil, nil, onConfirm);
	else
		UIPanelCloseButton_OnClick(SoulbindViewer.CloseButton);
		ShowUIPanel(PlayerTalentFrame)
	end
end

function SoulbindsTalents:SoulbindViewer_OnOpen()
	if not self.created2 then
		SoulbindAnchor = CreateFrame("Frame", "$parentTabAnchor", UIParent)
		SoulbindAnchor:SetPoint("BOTTOMLEFT", SoulbindViewer, "BOTTOMLEFT")
		SoulbindAnchor:SetSize(1, 1)
		SoulbindAnchor:Show()

		SoulbindViewerTab1 = CreateFrame("Button", "$parentTab1", SoulbindAnchor, "PlayerTalentTabTemplate", 1)
		SoulbindViewerTab1:SetPoint("TOPLEFT", SoulbindAnchor, "BOTTOMLEFT", 15, 5)
		SoulbindViewerTab1:SetText(SPECIALIZATION)
		PanelTemplates_TabResize(SoulbindViewerTab1, 0, nil, 36, SoulbindViewerTab1:GetParent().maxTabWidth or 88);

		SoulbindViewerTab1:HookScript("OnClick", function()
			SoulbindsTalents:SoulbindViewer_ChangeTab()
		end)

		SoulbindViewerTab2 = CreateFrame("Button", "$parentTab2", SoulbindAnchor, "PlayerTalentTabTemplate", 2)
		SoulbindViewerTab2:SetPoint("LEFT", SoulbindViewerTab1, "RIGHT", -15, 0)
		SoulbindViewerTab2:SetText(TALENTS)
		PanelTemplates_TabResize(SoulbindViewerTab2, 0, nil, 36, SoulbindViewerTab2:GetParent().maxTabWidth or 88);

		SoulbindViewerTab2:HookScript("OnClick", function()
			SoulbindsTalents:SoulbindViewer_ChangeTab()
		end)

		if self.petTab then
			SoulbindViewerTab3 = CreateFrame("Button", "$parentTab3", SoulbindAnchor, "PlayerTalentTabTemplate", 3)
			SoulbindViewerTab3:SetPoint("LEFT", SoulbindViewerTab2, "RIGHT", -15, 0)
			SoulbindViewerTab3:SetText(PET)
			PanelTemplates_TabResize(SoulbindViewerTab3, 0, nil, 36, SoulbindViewerTab3:GetParent().maxTabWidth or 88);

			SoulbindViewerTab3:HookScript("OnClick", function()
				SoulbindsTalents:SoulbindViewer_ChangeTab()
			end)

			SoulbindViewerTab4 = CreateFrame("Button", "$parentTab4", SoulbindAnchor, "PlayerTalentTabTemplate", 4)
			SoulbindViewerTab4:SetPoint("LEFT", SoulbindViewerTab3, "RIGHT", -15, 0)
			SoulbindViewerTab4:SetText(COVENANT_PREVIEW_SOULBINDS)
			PanelTemplates_TabResize(SoulbindViewerTab4, 0, nil, 36, SoulbindViewerTab4:GetParent().maxTabWidth or 88);
			PanelTemplates_SetNumTabs(SoulbindAnchor, 4)
			PanelTemplates_SetTab(SoulbindAnchor, 4)
		else
			SoulbindViewerTab3 = CreateFrame("Button", "$parentTab3", SoulbindAnchor, "PlayerTalentTabTemplate", 3)
			SoulbindViewerTab3:SetPoint("LEFT", SoulbindViewerTab2, "RIGHT", -15, 0)
			SoulbindViewerTab3:SetText(COVENANT_PREVIEW_SOULBINDS)
			PanelTemplates_TabResize(SoulbindViewerTab3, 0, nil, 36, SoulbindViewerTab3:GetParent().maxTabWidth or 88);
			PanelTemplates_SetNumTabs(SoulbindAnchor, 3)
			PanelTemplates_SetTab(SoulbindAnchor, 3)
		end

		if ElvUI then
			local Engine = unpack(ElvUI)
			local Skin = Engine:GetModule('Skins')

			Skin:HandleTab(SoulbindViewerTab1)
			Skin:HandleTab(SoulbindViewerTab2)
			Skin:HandleTab(SoulbindViewerTab3)
			Skin:HandleTab(SoulbindViewerTab4)
		end
		self.created2 = true
	end
	if PlayerTalentFrame:IsShown() then
		HideUIPanel(PlayerTalentFrame)
	end
	SoulbindViewer:SetScale(self.settings.soulbindScale)

	SoulbindAnchor:Show()
end

function SoulbindsTalents:SoulbindViewer_OnHide()
	SoulbindAnchor:Hide()
end

function SoulbindsTalents:SoulbindViewer_OnCloseButtonClicked()
	self.checked = true
end

local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")

function SoulbindsTalents:ConduitTooltip_Rank(tooltip, rank)
	local text, level
	local textLeft = tooltip.textLeft
	if not textLeft then
		local tooltipName = tooltip:GetName()
		textLeft = setmetatable({}, { __index = function(t, i)
			local line = _G[tooltipName .. "TextLeft" .. i]
			t[i] = line
			return line
		end })
		tooltip.textLeft = textLeft
	end
	for i = 3, 5 do
		if _G[tooltip:GetName() .. "TextLeft" .. i] then
			local line = textLeft[i]
			text = _G[tooltip:GetName() .. "TextLeft" .. i]:GetText() or ""
			level = string.match(text, ItemLevelPattern)
			if (level) then
				line:SetFormattedText("%s (Rank %d)", text, rank);
				return ;
			end
		end
	end
end

function SoulbindsTalents:TooltipHook(tooltip)
	if not self.settings.conduitTooltipRank then return end

	local name, itemLink = tooltip:GetItem()
	if not name then return end

	if C_Soulbinds.IsItemConduitByItemInfo(itemLink) then
		local itemLevel = select(4, GetItemInfo(itemLink))

		for rank, level in pairs(CONDUIT_RANKS) do
			if itemLevel == level then
				self:ConduitTooltip_Rank(tooltip, rank);
			end
		end
	end
end

function SoulbindsTalents:ConduitRank(conduit, conduitData)
	local itemID = conduitData.conduitItemID;
	local item = Item:CreateFromItemID(itemID);
	local itemCallback = function()
		conduit.ConduitName:SetSize(150, 30);
		conduit.ConduitName:SetText(item:GetItemName());
		conduit.ConduitName:SetHeight(conduit.ConduitName:GetStringHeight());

		local yOffset = conduit.ConduitName:GetNumLines() > 1 and -6 or 0;
		conduit.ConduitName:ClearAllPoints();
		conduit.ConduitName:SetPoint("BOTTOMLEFT", conduit.Icon, "RIGHT", 10, yOffset);
		conduit.ConduitName:SetWidth(150);

		conduit.ItemLevel:SetPoint("TOPLEFT", conduit.ConduitName, "BOTTOMLEFT", 0, 0);
		conduit.ItemLevel:SetFormattedText("%s (Rank %d)", conduitData.conduitItemLevel, conduitData.conduitRank);
		conduit.ItemLevel:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
	end;
	item:ContinueOnItemLoad(itemCallback);

	local conduitSpecName = conduitData.conduitSpecName;
	if conduitSpecName then
		local specIDs = C_SpecializationInfo.GetSpecIDs(conduitData.conduitSpecSetID);

		local isCurrentSpec = C_SpecializationInfo.MatchesCurrentSpecSet(conduitData.conduitSpecSetID);
		if isCurrentSpec then
			conduit.Spec.stateAlpha = 1;
			conduit.Spec.stateAtlas = "soulbinds_collection_specborder_primary";
			conduit.ItemLevel:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
		else
			conduit.Spec.stateAlpha = .4;
			conduit.Spec.stateAtlas = "soulbinds_collection_specborder_secondary";
			conduit.ItemLevel:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
		end
		conduit.Spec.Icon:SetAlpha(conduit.Spec.stateAlpha);

		conduit.Spec:Show();
	else
		conduit.ItemLevel:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
		conduit.Spec:Hide();
		conduit.Spec:SetScript("OnEnter", nil);
		conduit.Spec:SetScript("OnLeave", nil);
		conduit.Spec.stateAlpha = 1;
		conduit.Spec.stateAtlas = "soulbinds_collection_specborder_primary";
	end

	conduit:Update();
end

function SoulbindsTalents:AnimationFX(viewer)
	if self.settings.disableFX then
		viewer.ForgeSheen.Anim:SetPlaying(false);
		viewer.GridSheen.Anim:SetPlaying(false);
		viewer.BackgroundRuneLeft.Anim:SetPlaying(false);
		viewer.BackgroundRuneRight.Anim:SetPlaying(false);
	end
end

function SoulbindsTalents:NodeFX(viewer)
	if self.settings.disableFX then
		viewer.FlowAnim1:Stop();
		viewer.FlowAnim2:Stop();
		viewer.FlowAnim3:Stop();
		viewer.FlowAnim4:Stop();
		viewer.FlowAnim5:Stop();
		viewer.FlowAnim6:Stop();
	end
end

function SoulbindsTalents:ADDON_LOADED(_, addon)
	if addon == "Blizzard_TalentUI" then
		self:SecureHook('PlayerTalentFrame_Refresh')
		self:SecureHook('PlayerTalentFrame_Toggle')
	elseif addon == "Blizzard_Soulbinds" then
		if UIParentLoadAddOn("Blizzard_TalentUI") then
			self:SecureHook(SoulbindViewer, "Open", "SoulbindViewer_OnOpen")
			self:SecureHook(ConduitListConduitButtonMixin, "Init", "ConduitRank")
			self:SecureHook(SoulbindViewer, "SetSheenAnimationsPlaying", "AnimationFX")
			self:SecureHook(SoulbindTreeNodeLinkMixin, "SetState", "NodeFX")
			self:SecureHookScript(SoulbindViewer, "OnHide", "SoulbindViewer_OnHide")
			self:SecureHookScript(SoulbindViewer.CloseButton, "OnMouseDown", function()
				self.checked = true
			end)
		end
	end
end
