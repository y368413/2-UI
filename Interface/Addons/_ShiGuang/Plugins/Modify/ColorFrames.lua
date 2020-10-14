--[[ Begin
local function OnPlayerLogin(self, event, ...)
    _G.RaidWarningFrame.slot1:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    _G.RaidWarningFrame.slot2:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    _G.RaidBossEmoteFrame.slot1:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    _G.RaidBossEmoteFrame.slot2:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    
    _G.AchievementFont_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.AchievementFont_Small:SetShadowColor(0, 0, 0)
    _G.AchievementFont_Small:SetShadowOffset(1, -1)
    _G.CoreAbilityFont:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
    _G.CoreAbilityFont:SetShadowColor(0, 0, 0)
    _G.CoreAbilityFont:SetShadowOffset(1, -1)
    _G.DestinyFontHuge:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
    _G.DestinyFontHuge:SetShadowColor(0, 0, 0)
    _G.DestinyFontHuge:SetShadowOffset(1, -1)
    _G.DestinyFontLarge:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
    _G.DestinyFontLarge:SetShadowColor(0, 0, 0)
    _G.DestinyFontLarge:SetShadowOffset(1, -1)
    _G.FriendsFont_Normal:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.FriendsFont_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.FriendsFont_Large:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.FriendsFont_UserText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.GameFont_Gigantic:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
    _G.GameTooltipHeader:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.GameTooltipHeader:SetShadowColor(0, 0, 0)
    _G.GameTooltipHeader:SetShadowOffset(1, -1)
    _G.InvoiceFont_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.InvoiceFont_Small:SetShadowColor(0, 0, 0)
    _G.InvoiceFont_Small:SetShadowOffset(1, -1)
    _G.InvoiceFont_Med:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.InvoiceFont_Med:SetShadowColor(0, 0, 0)
    _G.InvoiceFont_Med:SetShadowOffset(1, -1)
    _G.MailFont_Large:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.NumberFont_GameNormal:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.NumberFont_OutlineThick_Mono_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.NumberFont_Outline_Huge:SetFont(STANDARD_TEXT_FONT, 30, "OUTLINE")
    _G.NumberFont_Outline_Large:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.NumberFont_Outline_Med:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.NumberFont_Shadow_Med:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.NumberFont_Shadow_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.QuestFont_Shadow_Small:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.QuestFont_Large:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    _G.QuestFont_Large:SetShadowColor(0, 0, 0)
    _G.QuestFont_Large:SetShadowOffset(1, -1)
    --_G.QuestFont_Shadow_Huge:SetFont(STANDARD_TEXT_FONT, 17, "OUTLINE")
    --_G.QuestFont_Huge:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
    _G.QuestFont_Super_Huge:SetFont(STANDARD_TEXT_FONT, 24, "OUTLINE")
    _G.QuestFont_Super_Huge:SetShadowColor(0, 0, 0)
    _G.QuestFont_Super_Huge:SetShadowOffset(1, -1)
    _G.ReputationDetailFont:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    --_G.SpellFont_Small:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    --_G.SpellFont_Small:SetShadowColor(0, 0, 0)
    --_G.SpellFont_Small:SetShadowOffset(1, -1)
    _G.SystemFont_InverseShadow_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.SystemFont_Large:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.SystemFont_Large:SetShadowColor(0, 0, 0)
    _G.SystemFont_Large:SetShadowOffset(1, -1)
    _G.SystemFont_Huge1:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    _G.SystemFont_Huge1:SetShadowColor(0, 0, 0)
    _G.SystemFont_Huge1:SetShadowOffset(1, -1)
    _G.SystemFont_Med1:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.SystemFont_Med1:SetShadowColor(0, 0, 0)
    _G.SystemFont_Med1:SetShadowOffset(1, -1)
    --_G.SystemFont_Med2:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    --_G.SystemFont_Med2:SetShadowColor(0, 0, 0)
    --_G.SystemFont_Med2:SetShadowOffset(1, -1)
    _G.SystemFont_Med3:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.SystemFont_Med3:SetShadowColor(0, 0, 0)
    _G.SystemFont_Med3:SetShadowOffset(1, -1)
    _G.SystemFont_OutlineThick_WTF:SetFont(STANDARD_TEXT_FONT, 32, "THICKOUTLINE")
    _G.SystemFont_OutlineThick_Huge2:SetFont(STANDARD_TEXT_FONT, 22, "THICKOUTLINE")
    _G.SystemFont_OutlineThick_Huge4:SetFont(STANDARD_TEXT_FONT, 26, "THICKOUTLINE")
    _G.SystemFont_Outline_Small:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.SystemFont_Outline:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    _G.SystemFont_Shadow_Large:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.SystemFont_Shadow_Large_Outline:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.SystemFont_Shadow_Large2:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
    _G.SystemFont_Shadow_Med1:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.SystemFont_Shadow_Med1_Outline:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.SystemFont_Shadow_Med2:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
    _G.SystemFont_Shadow_Med3:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    _G.SystemFont_Shadow_Outline_Huge2:SetFont(STANDARD_TEXT_FONT, 22, "OUTLINE")
    _G.SystemFont_Shadow_Huge1:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
    _G.SystemFont_Shadow_Huge2:SetFont(STANDARD_TEXT_FONT, 24, "OUTLINE")
    _G.SystemFont_Shadow_Huge3:SetFont(STANDARD_TEXT_FONT, 25, "OUTLINE")
    _G.SystemFont_Shadow_Small:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    _G.SystemFont_Shadow_Small2:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    --_G.SystemFont_Small:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    --_G.SystemFont_Small:SetShadowColor(0, 0, 0)
    --_G.SystemFont_Small:SetShadowOffset(1, -1)
    --_G.SystemFont_Small2:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    --_G.SystemFont_Small2:SetShadowColor(0, 0, 0)
    --_G.SystemFont_Small2:SetShadowOffset(1, -1)
    _G.SystemFont_Tiny:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    _G.SystemFont_Tiny:SetShadowColor(0, 0, 0)
    _G.SystemFont_Tiny:SetShadowOffset(1, -1)
    _G.Tooltip_Med:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
    _G.Tooltip_Med:SetShadowColor(0, 0, 0)
    _G.Tooltip_Med:SetShadowOffset(1, -1)
    _G.Tooltip_Small:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    _G.Tooltip_Small:SetShadowColor(0, 0, 0)
    _G.Tooltip_Small:SetShadowOffset(1, -1)
    
    -- Why?
    _G.HelpFrameKnowledgebaseNavBarHomeButtonText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    _G.WorldMapFrameNavBarHomeButtonText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    
    -- Extra
    _G.PaperDollTitlesPane:HookScript("OnShow", function(titles)
        for x, object in next, titles.buttons do
            object:DisableDrawLayer("BACKGROUND")
            object.text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
        end
    end)
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
----◊÷ÃÂ√Ë±ﬂ
for i = 1, 7 do
   local m, r = _G["ChatFrame"..i]:GetFont()
   _G["ChatFrame"..i]:SetFont(m, r, "OUTLINE")
   _G["ChatFrame"..i]:SetShadowOffset(0, 0)
   _G["ChatFrame"..i]:SetShadowColor(0, 0, 0, 0)
end]]
----------------------------------------------------------------------
local daftFrameHue_Custom = false;
local daftFrameHue_R = 0.2;
local daftFrameHue_G = 0.2;
local daftFrameHue_B = 0.2;
local daftFrameHue_classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("player"))];

local daftFrameHue = CreateFrame("Frame", "daftFrameHue", UIParent);
daftFrameHue:RegisterEvent("ADDON_LOADED");
local function ColorFrames()
	for i, texture in pairs({
		-- select(1, BurningEmbersBarFrame:GetRegions()),
		-- select(1, BurningEmbersBarFrameEmber1:GetRegions()),
		-- select(1, BurningEmbersBarFrameEmber2:GetRegions()),
		-- select(1, BurningEmbersBarFrameEmber3:GetRegions()),
		-- select(1, BurningEmbersBarFrameEmber4:GetRegions()),
		-- select(5, ShardBarFrameShard1:GetRegions()),
		-- select(5, ShardBarFrameShard2:GetRegions()),
		-- select(5, ShardBarFrameShard3:GetRegions()),
		-- select(5, ShardBarFrameShard4:GetRegions()),
		--ArenaEnemyFrame1PetFrameTexture,
		--ArenaEnemyFrame1SpecBorder,
		--ArenaEnemyFrame1Texture,
		--ArenaEnemyFrame2PetFrameTexture,
		--ArenaEnemyFrame2SpecBorder,
		--ArenaEnemyFrame2Texture,
		--ArenaEnemyFrame3PetFrameTexture,
		--ArenaEnemyFrame3SpecBorder,
		--ArenaEnemyFrame3Texture, 
		--ArenaEnemyFrame4PetFrameTexture, 
		--ArenaEnemyFrame4SpecBorder,
		--ArenaEnemyFrame4Texture,
		--ArenaEnemyFrame5PetFrameTexture,
		--ArenaEnemyFrame5SpecBorder,
		--ArenaEnemyFrame5Texture,
		--ArenaPrepFrame1SpecBorder,
		--ArenaPrepFrame1Texture,
		--ArenaPrepFrame2SpecBorder,
		--ArenaPrepFrame2Texture,
		--ArenaPrepFrame3SpecBorder,
		--ArenaPrepFrame3Texture,
		--ArenaPrepFrame4SpecBorder,
		--ArenaPrepFrame4Texture,
		--ArenaPrepFrame5SpecBorder,
		--ArenaPrepFrame5Texture,
		--Boss1TargetFrameSpellBarBorder,
		--Boss1TargetFrameTextureFrameTexture,
		--Boss2TargetFrameSpellBarBorder,
		--Boss2TargetFrameTextureFrameTexture,
		--Boss3TargetFrameSpellBarBorder,
		--Boss3TargetFrameTextureFrameTexture,
		--Boss4TargetFrameSpellBarBorder,
		--Boss4TargetFrameTextureFrameTexture,
		--Boss5TargetFrameSpellBarBorder,
		--Boss5TargetFrameTextureFrameTexture,
		CastingBarFrameBorder,
		CharacterFrameBg,
		CharacterFrame.TitleBg,
		WorldMapFrameBg,
		WorldMapFrame.BorderFrame.TitleBg,
		FriendsFrameBg,
		FriendsFrame.TitleBg,
		PVEFrameBg,
		PVEFrame.TitleBg,
		SpellBookFrame.TitleBg,
		PlayerTalentFrameBg,
		PlayerTalentFrameInsetBg,
		PlayerTalentFrameTitleBg,
		CommunitiesFrameBg,
		CommunitiesFrameBgTitleBg,
		GuildFrameBg,
		GuildFrameTitleBg,
		ClassicQuestLogBg,
		--ClassicQuestLog.TitleBg,
		TradeSkillFrameBg,
		TradeSkillFrameTitleBg,
		CombuctorInventoryFrame1Bg,
		CombuctorInventoryFrameTitleBg,
		CombuctorBankFrame1Bg,
		CombuctorBankFrameTitleBg,
		CompactRaidFrameManagerBg,
		FocusFrameSpellBarBorder,
		FocusFrameTextureFrameTexture,
		FocusFrameToTTextureFrameTexture,
		MainMenuBarLeftEndCap,
		MainMenuBarRightEndCap, 
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
		MainMenuMaxLevelBar0,
		MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuXPBarTextureLeftCap,
		MainMenuXPBarTextureMid,
		MainMenuXPBarTextureRightCap,
		MiniMapTrackingButtonBorder,
		MinimapBorder,
		MinimapBorderTop,
		ObjectiveTrackerBlocksFrame.QuestHeader.Background,
		ObjectiveTrackerBlocksFrame.ScenarioHeader.Background,
		ObjectiveTrackerBlocksFrame.AchievementHeader.Background,
		BONUS_OBJECTIVE_TRACKER_MODULE.Header.Background,
		WORLD_QUEST_TRACKER_MODULE.Header.Background,
		PaladinPowerBarBG,
		PaladinPowerBarBankBG,
		--PartyMemberFrame1PetFrameTexture,
		--PartyMemberFrame1Texture,
		--PartyMemberFrame2PetFrameTexture,
		--PartyMemberFrame2Texture,
		--PartyMemberFrame3PetFrameTexture,
		--PartyMemberFrame3Texture,
		--PartyMemberFrame4PetFrameTexture,
		--PartyMemberFrame4Texture,
		--PetFrameTexture,
		PlayerFrameTexture,
		ReputationWatchBarTexture0,
		ReputationWatchBarTexture1,
		ReputationWatchBarTexture2,
		ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
		ReputationXPBarTexture1,
		ReputationXPBarTexture2,
		ReputationXPBarTexture3,
		RuneButtonIndividual1BorderTexture,
		RuneButtonIndividual2BorderTexture,
		RuneButtonIndividual3BorderTexture,
		RuneButtonIndividual4BorderTexture,
		RuneButtonIndividual5BorderTexture,
		RuneButtonIndividual6BorderTexture,
		SlidingActionBarTexture0,
		SlidingActionBarTexture1,
		StanceBarLeft,
		StanceBarMiddle,
		StanceBarRight,
		TargetFrameSpellBarBorder,
		--TargetFrameTextureFrameTexture,
		TargetFrameToTTextureFrameTexture,
		}) do
		if daftFrameHue_Custom then
			texture:SetVertexColor(daftFrameHue_R, daftFrameHue_G, daftFrameHue_B, 1);
		else
			texture:SetVertexColor(daftFrameHue_classcolor.r, daftFrameHue_classcolor.g, daftFrameHue_classcolor.b, 1);
		end;
	end;
end;

daftFrameHue:SetScript("OnEvent", function(self, event) 	
	if event == "ADDON_LOADED" then ColorFrames(); end
end)