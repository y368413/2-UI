local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("Settings")
local pairs, wipe = pairs, table.wipe

-- Addon Info
print("<<<--|cFFFFFF00 2|r|cFFFF0000 UI|r v"..GetAddOnMetadata("_ShiGuang", "Version").."["..GetAddOnMetadata("_ShiGuang", "X-StatsVersion").."]" .." For "..GetAddOnMetadata("_ShiGuang", "X-Support").." --")
print("  ---|cffC495DD 特别感谢|r|cff3399ffSiweia|r|cffC495DD,向他学到了好多.|r---  ")
print("----------------- 有你们的魔兽,才是世界 -->>>")

-- Tuitorial
local function DefaultSettings()
	SetCVar("scriptErrors", 0)     --0是屏蔽错误1是不屏蔽错误
	SetCVar("autoQuestWatch", 1)  
	SetCVar("synchronizeSettings", 1)
	SetCVar("synchronizeMacros", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("showTutorials", 0)
	SetCVar("overrideArchive", 0)
	SetCVar("showQuestTrackingTooltips", 1)
	--SetCVar("fstack_preferParentKeys", 0)
	SetCVar("missingTransmogSourceInItemTooltips", 1)
	--setglobal("MAX_EQUIPMENT_SETS_PER_PLAYER",100)
	PlayerFrame:SetScale(R.db["UFs"]["PlayerFrameScale"]) 
	TargetFrame:SetScale(R.db["UFs"]["PlayerFrameScale"])
end

local function ForceDefaultSettings()
  --/console cvar_defaul
  local PlayerFrame = _G["PlayerFrame"]
  if (PlayerFrame and not PlayerFrame_IsAnimatedOut(PlayerFrame)) then
  PlayerFrame:ClearAllPoints() PlayerFrame:SetPoint("RIGHT",UIParent,"CENTER", -150, -250) PlayerFrame:SetUserPlaced(true)  --PlayerFrame:SetScale(0.8) 
  end
  local TargetFrame = _G["TargetFrame"]
  if (TargetFrame) then
  TargetFrame:ClearAllPoints() TargetFrame:SetPoint("LEFT",UIParent,"CENTER", 150, -250) TargetFrame:SetUserPlaced(true)  --TargetFrame:SetScale(0.8) 
  end
  TargetFrameToT:ClearAllPoints() TargetFrameToT:SetPoint("LEFT",TargetFrame,"BOTTOMRIGHT", -43, 21)
  TargetFrameToTTextureFrameName:ClearAllPoints() TargetFrameToTTextureFrameName:SetPoint("LEFT",TargetFrameToT,"Top", -8, -43)
  PetFrameHealthBarText:SetPoint("BOTTOMRIGHT", PetFrame, "LEFT", 3,-6)  
  PetFrameManaBarText:SetPoint("TOPRIGHT", PetFrame, "LEFT", 3, -6)
  PetFrameManaBarText:SetTextColor(0, 1, 1)
  local FocusFrame = _G["FocusFrame"]
  if (FocusFrame) then
  FocusFrame:SetScript("OnMouseDown", function(self, elapsed) if IsShiftKeyDown() and (not InCombatLockdown()) then FocusFrame:StartMoving(); end end)
  FocusFrame:SetScript("OnMouseUp", function(self, elapsed) FocusFrame:StopMovingOrSizing(); end)
  --FocusFrame:SetClampedToScreen(1)
  end
  SetCVar("nameplateSelectedScale", 1.25)
  SetCVar("nameplateLargerScale", 1.25)
	SetCVar("autoLootDefault", 1)
	SetCVar("alwaysCompareItems", 1)
	SetCVar("lootUnderMouse", 1)
	SetCVar("autoSelfCast", 1)
	SetCVar("nameplateShowSelf", 0)
	--SetCVar("guildMemberNotify", 0)--公会成员提示
  --SetCVar("showToastBroadcast", 0)--通告更新
  --SetCVar("showToastWindow", 0)--显示浮窗
	SetCVar("nameplateShowFriendlyNPCs", 0)
	SetCVar("showTimestamps", "none")--聊天时间戳
	SetCVar("ActionButtonUseKeyDown", 1)
	SetCVar("lockActionBars", 1)
	SetActionBarToggles(1, 1, 0, 0)
	SHOW_MULTI_ACTIONBAR_1="1" --左下方动作条 
  SHOW_MULTI_ACTIONBAR_2="1" --右下方动作条 
  SHOW_MULTI_ACTIONBAR_3 = "0" --右动作条1
  SHOW_MULTI_ACTIONBAR_4 = "0" --右动作条2
  InterfaceOptions_UpdateMultiActionBars() --刷新动作条
	SetCVar("enableFloatingCombatText", 0)
	SetCVar("floatingCombatTextCombatState", 0)
	SetCVar("showTargetOfTarget",1) --目标的目标
	SetCVar("ShowClassColorInNameplate", 1)
	--SetCVar("floatingCombatTextCombatDamage", 0)
	--SetCVar("floatingCombatTextCombatHealing", 0)
	SetCVar("floatingCombatTextCombatDamageDirectionalScale", 1)
	SetCVar("floatingCombatTextFloatMode", 3) 
  --SetCVar("floatingCombatTextPetMeleeDamage", 0)   	 --寵物對目標傷害
  --SetCVar("floatingCombatTextPetSpellDamage", 0)   	 --寵物對目標傷害
  SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)    --目標盾提示 
  SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)    --自身得盾/護甲提示 
  SetCVar("floatingCombatTextDodgeParryMiss", 0)    --閃招 
  SetCVar("floatingCombatTextDamageReduction", 0)    --傷害減免 
  SetCVar("floatingCombatTextCombatLogPeriodicSpells", 0)    --周期性傷害 
  SetCVar("floatingCombatTextReactives", 0)    --法術警示
  SetCVar("floatingCombatTextSpellMechanics", 0)    --他人的糾纏效果(例如 誘補(xxxx-xxxx)) 
  SetCVar("floatingCombatTextRepChanges", 1)    --聲望變化 
  SetCVar("floatingCombatTextFriendlyHealers", 0)    --友方治療者名稱 
  SetCVar("floatingCombatTextCombatState", 1)    --進入/離開戰鬥文字提示 
  SetCVar("floatingCombatTextLowManaHealth", 1)      --低MP/低HP文字提示 
  SetCVar("floatingCombatTextComboPoints", 0)    --連擊點 
  SetCVar("floatingCombatTextEnergyGains", 0)    --能量獲得
  SetCVar("floatingCombatTextPeriodicEnergyGains", 0)    --周期性能量   
  SetCVar("floatingCombatTextHonorGains", 0)    --榮譽擊殺 
  SetCVar("floatingCombatTextAuras", 0)   --光環 
	SetCVar("doNotFlashLowHealthWarning", 1)
	if not InCombatLockdown() then
		SetCVar("nameplateMotion", 1)
		SetCVar("nameplateShowAll", 1)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("alwaysShowActionBars", 1)
	end
	SetCVar("ffxGlow", 0)
	SetCVar("Sound_EnableErrorSpeech", 0)								--错误提示音
	--SetCVar("SpellQueueWindow", 100);
	SetCVar("statusText",1) --状态文字
	SetCVar("statusTextDisplay","NUMERIC")--头像状态文字形式："NUMERIC"数值"PERCENT"百分比"BOTH"同时显示
	SetCVar("autoLootDefault",1) --自动拾取
	SetCVar("worldPreloadNonCritical", 1) --0是加快蓝条，读完蓝条再载入游戏模组
end

local function ForceRaidFrame()
	if InCombatLockdown() then return end
	if not CompactUnitFrameProfiles then return end
	CompactRaidFrameContainer:SetScale(0.85)
	--SetRaidProfileOption(GetActiveRaidProfile(), "healthText", "none")
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "useClassColors", true) --显示职业颜色
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayPowerBar", false) --显示能量条 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayBorder", false) --显示边框
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "frameWidth", 160) --设置宽度
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "frameHeight", 21) --设置高度
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate2Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate3Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate5Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate10Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate15Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate25Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "autoActivate40Players", true)
	--SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "keepGroupsTogether", true) --保持小队相连 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayHealPrediction", true) --显示预计治疗 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayAggroHighlight", true) --高亮显示仇恨目标 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayPets", false) --显示宠物 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayMainTankAndAssist", false) --显示主坦克和主助理 
	SetRaidProfileOption(CompactUnitFrameProfiles.selectedProfile, "displayOnlyDispellableDebuffs", true) --只显示可供驱散的负面
	--SetRaidProfileSavedPosition(GetActiveRaidProfile(), false, "TOP", 440, "BOTTOM", 320, "LEFT", 0)	--团队框体位置 
	CompactUnitFrameProfiles_ApplyCurrentSettings()
	CompactUnitFrameProfiles_UpdateCurrentPanel()
end

local function ForceChatSettings()
	M:GetModule("Chat"):UpdateChatSize()

	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame"..i]
		ChatFrame_RemoveMessageGroup(cf, "CHANNEL")
	end
	FCF_SavePositionAndDimensions(ChatFrame1)

	R.db["Chat"]["Lock"] = true
end

StaticPopupDialogs["RELOAD_NDUI"] = {
	text = U["ReloadUI Required"],
	button1 = APPLY,
	button2 = CLASS_TRIAL_THANKS_DIALOG_CLOSE_BUTTON,
	OnAccept = function()
		ReloadUI()
	end,
}

-- DBM bars
local function ForceDBMOptions()
	if not IsAddOnLoaded("DBM-Core") then return end
	if DBT_AllPersistentOptions then wipe(DBT_AllPersistentOptions) end
	DBT_AllPersistentOptions = {
		["Default"] = {
			["DBM"] = {
				["Scale"] = 0.9,
				["HugeScale"] = 1.2,
				["ExpandUpwards"] = true,
				["ExpandUpwardsLarge"] = true,
				["BarXOffset"] = 0,
				["BarYOffset"] = 1,
				["TimerPoint"] = "BOTTOMLEFT",
				["TimerX"] = 100,
				["TimerY"] = 210,
				["Width"] = 200,
				["Heigh"] = 14,
				["HugeWidth"] = 280,
				["HugeBarXOffset"] = 0,
				["HugeBarYOffset"] = 3,
				["HugeTimerPoint"] = "CENTER",
				["HugeTimerX"] = -12,
				["HugeTimerY"] = -143,
				["FontSize"] = 15,
				["StartColorR"] = 1,
				["StartColorG"] = .7,
				["StartColorB"] = 0,
				["EndColorR"] = 1,
				["EndColorG"] = 0,
				["EndColorB"] = 0,
				["Texture"] = I.normTex,
			},
		},
	}
	DBM_MinimapIcon["hide"] = true
	if not DBM_AllSavedOptions["Default"] then DBM_AllSavedOptions["Default"] = {} end
	DBM_AllSavedOptions["Default"]["ChosenVoicePack"] = "Yike"
	DBM_AllSavedOptions["Default"]["RangeFrameRadarPoint"] = "RIGHT"
	DBM_AllSavedOptions["Default"]["RangeFrameRadarX"] = -90
	DBM_AllSavedOptions["Default"]["RangeFrameRadarY"] = -180
	DBM_AllSavedOptions["Default"]["InfoFrameX"] = 300
	DBM_AllSavedOptions["Default"]["InfoFrameY"] = 210
	DBM_AllSavedOptions["Default"]["HPFramePoint"] = "RIGHT"
	DBM_AllSavedOptions["Default"]["HPFrameX"] = -160
	DBM_AllSavedOptions["Default"]["WarningY"] = 260
	DBM_AllSavedOptions["Default"]["WarningX"] = 0
	DBM_AllSavedOptions["Default"]["WarningFontStyle"] = "OUTLINE"
	DBM_AllSavedOptions["Default"]["SpecialWarningPoint"] = "TOP"
	DBM_AllSavedOptions["Default"]["SpecialWarningFontCol"] = {1.0, 0.3, 0.0}
	DBM_AllSavedOptions["Default"]["SpecialWarningX"] = 0
	DBM_AllSavedOptions["Default"]["SpecialWarningY"] = -195
	DBM_AllSavedOptions["Default"]["SpecialWarningFontStyle"] = "OUTLINE"
	DBM_AllSavedOptions["Default"]["HideQuestTooltips"] = false
	DBM_AllSavedOptions["Default"]["HideObjectivesFrame"] = false
	DBM_AllSavedOptions["Default"]["WarningFontSize"] = 20
	DBM_AllSavedOptions["Default"]["SpecialWarningFontSize2"] = 36
	MaoRUIDB["DBMRequest"] = false
end

-- Skada
local function ForceSkadaOptions()
	if not IsAddOnLoaded("Skada") then return end
	if SkadaDB then return end  --wipe(SkadaDB)
	SkadaDB = {
		["hasUpgraded"] = true,
		["profiles"] = {
			["Default"] = {
				["windows"] = {
					{	["barheight"] = 16,
						["classicons"] = true,
						["barslocked"] = true,
						["y"] = 21,
						["x"] = 0,
						["title"] = {
							["color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["font"] = "",
							["borderthickness"] = 2,
							["fontflags"] = "OUTLINE",
							["fontsize"] = 11,
							["texture"] = "None",
						},
						["barfontflags"] = "OUTLINE",
						["point"] = "BOTTOMRIGHT",
						["mode"] = U["Damage"],
						["barwidth"] = 285,
						["barbgcolor"] = {
							["a"] = 0.21,
							["b"] = 0.21,
							["g"] = 0.21,
							["r"] = 0.12,
						},
						["barfontsize"] = 11,
						["background"] = {
							["height"] = 165,
							["texture"] = "None",
							["bordercolor"] = {
								["a"] = 0,
							},
						},
						["bartexture"] = "HalfStyle",
					}, -- [1]
				},
				["tooltiprows"] = 3,
				["setstokeep"] = 10,
				["tooltippos"] = "topleft",
				["reset"] = {
					["instance"] = 3,
					["join"] = 1,
				},
			},
		},
	}
	MaoRUIDB["SkadaRequest"] = false
end

-- BigWigs
local function ForceBigwigs()
	if not IsAddOnLoaded("BigWigs") then return end
	if BigWigs3DB then wipe(BigWigs3DB) end
	BigWigs3DB = {
		["namespaces"] = {
			["BigWigs_Plugins_Bars"] = {
				["profiles"] = {
					["Default"] = {
						["outline"] = I.Font[3],
						["fontSize"] = 12,
						["BigWigsAnchor_y"] = 336,
						["BigWigsAnchor_x"] = 16,
						["BigWigsAnchor_width"] = 175,
						["growup"] = true,
						["interceptMouse"] = false,
						["barStyle"] = "NDui",
						["LeftButton"] = {
							["emphasize"] = false,
						},
						["font"] = I.Font[1],
						["onlyInterceptOnKeypress"] = true,
						["emphasizeMultiplier"] = 1,
						["BigWigsEmphasizeAnchor_x"] = 810,
						["BigWigsEmphasizeAnchor_y"] = 350,
						["BigWigsEmphasizeAnchor_width"] = 220,
						["emphasizeGrowup"] = true,
					},
				},
			},
			["BigWigs_Plugins_Super Emphasize"] = {
				["profiles"] = {
					["Default"] = {
						["fontSize"] = 28,
						["font"] = I.Font[1],
					},
				},
			},
			["BigWigs_Plugins_Messages"] = {
				["profiles"] = {
					["Default"] = {
						["fontSize"] = 18,
						["font"] = I.Font[1],
						["BWEmphasizeCountdownMessageAnchor_x"] = 665,
						["BWMessageAnchor_x"] = 616,
						["BWEmphasizeCountdownMessageAnchor_y"] = 530,
						["BWMessageAnchor_y"] = 305,
					},
				},
			},
			["BigWigs_Plugins_Proximity"] = {
				["profiles"] = {
					["Default"] = {
						["fontSize"] = 18,
						["font"] = I.Font[1],
						["posy"] = 346,
						["width"] = 140,
						["posx"] = 1024,
						["height"] = 120,
					},
				},
			},
			["BigWigs_Plugins_Alt Power"] = {
				["profiles"] = {
					["Default"] = {
						["posx"] = 1002,
						["fontSize"] = 14,
						["font"] = I.Font[1],
						["fontOutline"] = I.Font[3],
						["posy"] = 490,
					},
				},
			},
		},
		["profiles"] = {
			["Default"] = {
				["fakeDBMVersion"] = true,
			},
		},
	}
	MaoRUIDB["BWRequest"] = false
end

local function ForceAddonSkins()
	if MaoRUIDB["DBMRequest"] then ForceDBMOptions() end
	if MaoRUIDB["SkadaRequest"] then ForceSkadaOptions() end
	if MaoRUIDB["BWRequest"] then ForceBigwigs() end
end

-- Tutorial
local function YesTutor()
	ForceRaidFrame()
	MaoRUIDB["DBMRequest"] = true
	MaoRUIDB["SkadaRequest"] = true
	MaoRUIDB["BWRequest"] = true
	ForceAddonSkins()
	MaoRUIDB["ResetDetails"] = true
	MaoRUIDB["YesTutor"] = false
end

local welcome
local function HelloWorld()
	if welcome then welcome:Show() return end
	local BackDropFile = "Interface\\Addons\\_ShiGuang\\Media\\Modules\\Raid\\Solid"
	welcome = CreateFrame("Frame", "UI_Tutorial", UIParent, "BackdropTemplate")
	welcome:SetPoint("TOPLEFT",0,0)
	welcome:SetPoint("BOTTOMRIGHT",0,0)
	welcome:SetFrameStrata("HIGH")
	welcome:SetFrameLevel(0)
	welcome:SetBackdrop({ 
   bgFile = BackDropFile, 
   edgeFile = BackDropFile, 
	})
	welcome:SetBackdropColor(0.2, 0.2, 0.2, 1) 
	welcome:SetBackdropBorderColor(0,0,0,0)
	
	local BottomBlack = CreateFrame("Frame", nil, welcome) 
	BottomBlack:SetPoint("TOPLEFT",welcome,"BOTTOMLEFT",0,43)
	BottomBlack:SetPoint("BOTTOMRIGHT",0,0)
	--M.CreateBD(BottomBlack, 1)
	M.CreateBDFrame(BottomBlack, .2)
	BottomBlackText = M:CreatStyleText(BottomBlack, STANDARD_TEXT_FONT, 16, "OUTLINE", "-----  开袋即食零设置 上手即用懒人包  -----", "BOTTOM",BottomBlack,"BOTTOM",0,16, 0.97,0.75,0) 
	
	local WelcomeTitle1 = M:CreatStyleButton(nil, welcome, 60, 60, "BOTTOM", welcome, "CENTER", 0, 12, 1, 1) 
	WelcomeTitle1Text = M:CreatStyleText(WelcomeTitle1, "Interface\\addons\\_ShiGuang\\Media\\Fonts\\RedCircl.TTF", 120, "OUTLINE", "|cFFFFFF00 2 |r", "CENTER", WelcomeTitle1, "CENTER",0, 3, 1, 0, 0) 

	local WelcomeTitle2 = M:CreatStyleButton(nil, welcome, 43, 43, "BOTTOMRIGHT", WelcomeTitle1, "BOTTOMRIGHT", 21, -8, 1, 1) 
	WelcomeTitle2Text = M:CreatStyleText(WelcomeTitle2, "Interface\\addons\\_ShiGuang\\Media\\Fonts\\RedCircl.TTF", 23, "OUTLINE", "|cFFFF0000 UI|r", "CENTER", WelcomeTitle2, "CENTER", 0, 3, 1, 1, 0) 

	local MadeBy = M:CreatStyleButton(nil, welcome, 210, 21, "BOTTOMRIGHT", BottomBlack, "BOTTOMRIGHT", -8, 31, 10, 1) 
	MadeBy:SetScript("OnClick", function(self,Button) welcome:Hide() end)
	--MadeByText = M:CreatStyleText(MadeBy, "Interface\\addons\\_ShiGuang\\Media\\Fonts\\Pixel.TTF", 12, "OUTLINE", "- www.maorui.net -", "CENTER", MadeBy, 0, 0, 0.66,0.66,0.66) --■ ■
	MadeByText1 = M:CreatStyleText(MadeBy, "Interface\\addons\\_ShiGuang\\Media\\Fonts\\Edo.TTF", 52, "OUTLINE", "ALLIANCE OR HORDE ?", "TOP",Welcome,"TOP",0,-21, 1, 1, 1)
	MadeByText2 = M:CreatStyleText(MadeBy, "Interface\\addons\\_ShiGuang\\Media\\Fonts\\Edo.TTF", 43, "OUTLINE", "MAKE DECISION !", "TOP",Welcome,"TOP",0,-99, 1, 1, 1)

	local LeftPic = M:CreatStyleButton(nil, welcome, 512, 210, "BOTTOMRIGHT", welcome, "BOTTOM", 1, 43, 2, 1)
	LeftPic:SetNormalTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\BlinkHealthText\\LeftPic")
  local function Sc(alpha) LeftPic:SetAlpha(alpha) end  --按钮特效--
	LeftPic:EnableMouse(true)
	LeftPic:SetScript("OnEnter", function(self) Sc(0.8) end)
	LeftPic:SetScript("OnLeave", function(self) Sc(1) end)
	LeftPic:SetScript("OnMouseUp", function(self) Sc(1) end)
	LeftPic:SetScript("OnMouseDown", function(self) Sc(0.6) end)
	LeftPic:SetScript("OnClick", function()
		welcome:Hide()
		if MaoRUIDB["YesTutor"] then YesTutor() end
		ShiGuangPerDB["BHT"] = true
		R.db["Tutorial"]["Complete"] = true
		ForceDefaultSettings()
		ReloadUI()
	end)
	SmallText1 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 微美化界面 ]", "RIGHT",LeftPic,"LEFT",26,60, I.r, I.g, I.b)
	SmallText2 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 全职业适用无障碍 ]", "RIGHT",LeftPic,"LEFT",26,20, I.r, I.g, I.b)
	SmallText3 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 开袋即食 轻优化 无繁琐设置 ]", "RIGHT",LeftPic,"LEFT",26,-20, I.r, I.g, I.b)
	SmallText4 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 适配主流更新器 更加便捷及时和高效 ]", "RIGHT",LeftPic,"LEFT",26,-60, I.r, I.g, I.b)

  local RightPic = M:CreatStyleButton(nil, welcome, 512, 210, "BOTTOMLEFT", welcome, "BOTTOM", -1, 43, 2, 1)
  RightPic:SetNormalTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\BlinkHealthText\\RightPic")
  local function Sc(alpha) RightPic:SetAlpha(alpha) end  --按钮特效--
	RightPic:EnableMouse(true)
	RightPic:SetScript("OnEnter", function(self) Sc(0.8) end)
	RightPic:SetScript("OnLeave", function(self) Sc(1) end)
	RightPic:SetScript("OnMouseUp", function(self) Sc(1) end)
	RightPic:SetScript("OnMouseDown", function(self) Sc(0.6) end)
	RightPic:SetScript("OnClick", function()
		welcome:Hide()
		if MaoRUIDB["YesTutor"] then YesTutor() end
		ShiGuangPerDB["BHT"] = false
		R.db["Tutorial"]["Complete"] = true
		ForceDefaultSettings()
		ReloadUI()
  end)
	SmallText1 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ SL " ..GetAddOnMetadata("_ShiGuang", "X-Support").. " v"..GetAddOnMetadata("_ShiGuang", "Version").." ]", "LEFT",RightPic,"RIGHT",-26,60, I.r, I.g, I.b)
	SmallText2 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ https://www.maorui.net ]", "LEFT",RightPic,"RIGHT",-26,20, I.r, I.g, I.b)
	SmallText3 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 鼠标右键点击小地图便捷插件设置 ]", "LEFT",RightPic,"RIGHT",-26,-20, I.r, I.g, I.b)
	SmallText4 = M:CreatStyleText(LeftPic, STANDARD_TEXT_FONT, 16, "OUTLINE", "[ 系统自带功能，插件有针对性增强或者删减 ]", "LEFT",RightPic,"RIGHT",-26,-60, I.r, I.g, I.b)

	local LeftBlue = CreateFrame("Frame", nil, welcome, "BackdropTemplate") 
	LeftBlue:SetPoint("TOPLEFT",welcome,"TOPLEFT",0,0)
	LeftBlue:SetPoint("BOTTOMRIGHT",LeftPic,"TOPRIGHT",0,0)
	LeftBlue:SetBackdrop({ 
   bgFile = BackDropFile, 
   edgeFile = BackDropFile, 
	})
	LeftBlue:SetBackdropColor(0, 0, 1, 0.3) 
	LeftBlue:SetBackdropBorderColor(0,0,0,0)

	local RightRed = CreateFrame("Frame", nil, welcome, "BackdropTemplate") 
	RightRed:SetPoint("TOPRIGHT",welcome,"TOPRIGHT",0,0)
	RightRed:SetPoint("BOTTOMLEFT",RightPic,"TOPLEFT",0,0)
	RightRed:SetBackdrop({ 
   bgFile = BackDropFile, 
   edgeFile = BackDropFile, 
	})
	RightRed:SetBackdropColor(1, 0, 0, 0.3) 
	RightRed:SetBackdropBorderColor(0,0,0,0)

	local NPCModeRight = CreateFrame("PlayerModel", "NPCModeRight", RightRed)
	NPCModeRight:SetSize(UIParent:GetWidth()*0.6, UIParent:GetHeight())
	NPCModeRight:SetPoint("BOTTOM",RightPic,"TOPRIGHT",0,0) --"CENTER",0,210
	NPCModeRight:SetDisplayInfo(28213)  --ShiGuangDB.DisplayInfo
	NPCModeRight:SetParent(RightRed) 
	NPCModeRight:SetCamDistanceScale(0.5)
	NPCModeRight:SetPosition(0,-0.08,0.12)
	NPCModeRight:SetRotation(-0.2)
	NPCModeRight.rotation = 0.21

	local NPCModeLeft = CreateFrame("PlayerModel", "NPCModeLeft", LeftBlue)
	NPCModeLeft:SetSize(UIParent:GetWidth()*0.6, UIParent:GetHeight())
	NPCModeLeft:SetPoint("BOTTOM",LeftPic,"TOPLEFT",0,0) --"CENTER",0,210
	NPCModeLeft:SetDisplayInfo(82047)  --54860  --74504   --71057 	--68323   --35908   --65636 
	NPCModeLeft:SetParent(LeftBlue) 
	NPCModeLeft:SetCamDistanceScale(0.8)
	NPCModeLeft:SetPosition(0,0.06,-0.12)
	NPCModeLeft:SetRotation(0.2)
	NPCModeLeft.rotation = 0.21

	local PlayerModel = CreateFrame("PlayerModel", "PlayerModel", welcome)
	PlayerModel:SetSize(256, 256)
	PlayerModel:SetPoint("BOTTOM",LeftPic,"TOPRIGHT",12,-60) --"BOTTOM",MadeBy,"TOP",0,120
	PlayerModel:SetUnit("player")
	PlayerModel:SetParent(welcome)
	PlayerModel:SetCamDistanceScale(1)
	PlayerModel:SetPosition(-1.6,0,0)
	PlayerModel:SetRotation(0)
	PlayerModel.rotation = 0
end
SlashCmdList["SHIGUANG"] = HelloWorld
SLASH_SHIGUANG1 = "/loadmr"

-----------------------------------------
function module:OnLogin()
	-- Hide options
	M.HideOption(Display_UseUIScale)
	M.HideOption(Display_UIScaleSlider)

	-- Tutorial and settings
	DefaultSettings()
	ForceAddonSkins()
	if not R.db["Tutorial"]["Complete"] then HelloWorld() end
	if (ShiGuangPerDB["BHT"] == true) then SenduiCmd("/bht on") else SenduiCmd("/bht off") end
end