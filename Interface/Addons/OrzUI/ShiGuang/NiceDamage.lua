local NiceDamage = {}
local LSM = LibStub("LibSharedMedia-3.0")

if GetLocale() == "zhCN" then
  NiceDamageLocal = "|cFF33FF99[美化]|r伤害数字";
elseif GetLocale() == "zhTW" then
  NiceDamageLocal = "|cFF33FF99[美化]|r伤害数字";
else
  NiceDamageLocal = "Nice Damage";
end

-- Create the Ace3 Addon object
LibStub("AceAddon-3.0"):NewAddon(NiceDamage, "NiceDamage", "AceEvent-3.0", "AceConsole-3.0")

function NiceDamage:OnInitialize()
    -- Determine if the client is Russian to set default font accordingly
    local defaultFont = "Edo"

    -- Initialize the Database
    -- Note: SavedVariables name must match the .toc file
    self.db = LibStub("AceDB-3.0"):New("NiceDamageDB", {
        global = { 
            minimap = { hide = false } 
        },
        profile = {
            enabled = true,
            loadCustomFont = false,
            -- Combat font
            updateWorldText = true, -- Combat Damage Number Font
            fontName = defaultFont,
            fontSize = 1,
            fontGravity = 0.5,
            fontRampDuration = 1.0,
            -- Floating text font
            updateUiText = false,   -- Scrolling Combat Text Font
            uiFont = defaultFont,
            uiOutline = "OUTLINE",
            uiMonochrome = false,
            uiShadowOffset = 1,
        }
    }, true)

    -- Register custom fonts with LibSharedMedia
    self:RegisterFonts()

    -- Create DataBroker object for Minimap/Addon Managers
    self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("NiceDamage", {
        type = "data source",
        icon = "Interface\\Addons\\OrzUI\\Media\\2UI",      --"Interface\\Icons\\INV_Scroll_03"
        label = NiceDamageLocal,
    })

    -- Initialize Minimap Icon via LibDBIcon
    self.icon = LibStub("LibDBIcon-1.0")
    self.icon:Register("NiceDamage", self.ldb, self.db.global.minimap)



--------- Isle of Thunder Weekly Check---- by Fluffies------DIY by y368413-------------------------------------------
local chest_icon = "|TInterface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals:12|t "
local rare_icon = "|TInterface\\Icons\\Achievement_Boss_Archaedas:12|t "
local quest_icon = "|TInterface\\CURSOR\\QUEST:12|t "
local rare_name = EXAMPLE_TARGET_MONSTER.." ("..ITEM_QUALITY3_DESC..")"

-- string colors
local LIGHT_RED   = "|cffFF2020"
local LIGHT_GREEN = "|cff20FF20"
local LIGHT_BLUE  = "|cff00ddFF"
local ZONE_BLUE   = "|cff00aacc"
local GREY        = "|cff999999"
local COORD_GREY  = "|cffBBBBBB"
local GOLD        = "|cffffcc00"
local WHITE       = "|cffffffff"
local PINK        = "|cffFFaaaa"
local function AddColor(str,color) return color..(str or " ^-^ ").."|r" end

local function completedstring(arg)
 if C_QuestLog.IsQuestFlaggedCompleted(arg) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end

-------------------------------------------------------------
local bonus = {52834, 52838, 52835, 52839, 52837, 52840,}						--Order Resources(前3)  -Gold(中3)  --Orderhall(后1) 
local count = 0
for _, id in pairs(bonus) do if C_QuestLog.IsQuestFlaggedCompleted(id) then count = count + 1 end end
local function CheckCurrency()
	if count < 2 then return AddColor(count.." / 2",LIGHT_RED) elseif count >= 2 then return AddColor(count.." / 2",LIGHT_GREEN) end
end
local function TimeTravelFB()
 if C_QuestLog.IsQuestFlaggedCompleted(40168) or C_QuestLog.IsQuestFlaggedCompleted(40173) or C_QuestLog.IsQuestFlaggedCompleted(40786) or C_QuestLog.IsQuestFlaggedCompleted(45799) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function GarrisonInvade()
 if C_QuestLog.IsQuestFlaggedCompleted(37638) or C_QuestLog.IsQuestFlaggedCompleted(37639) or C_QuestLog.IsQuestFlaggedCompleted(37640) or C_QuestLog.IsQuestFlaggedCompleted(38482) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function LegionWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(42270) or C_QuestLog.IsQuestFlaggedCompleted(42269) or C_QuestLog.IsQuestFlaggedCompleted(42779) or C_QuestLog.IsQuestFlaggedCompleted(43192) or IsQuestFlaggedCompleted(42819) or IsQuestFlaggedCompleted(43193) or IsQuestFlaggedCompleted(43513) or IsQuestFlaggedCompleted(43448) or IsQuestFlaggedCompleted(43512) or IsQuestFlaggedCompleted(43985) or IsQuestFlaggedCompleted(44287) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function TombWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(46947) or C_QuestLog.IsQuestFlaggedCompleted(46948) or C_QuestLog.IsQuestFlaggedCompleted(46945) or C_QuestLog.IsQuestFlaggedCompleted(47061) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function ArgusWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(38276) or C_QuestLog.IsQuestFlaggedCompleted(47461) or C_QuestLog.IsQuestFlaggedCompleted(47462) or C_QuestLog.IsQuestFlaggedCompleted(47463) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function CheckIslandweekly()
	local iwqID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	local _, _, _, cur, max = GetQuestObjectiveInfo(iwqID, 1, false)
	if iwqID and UnitLevel("player") == 120 and C_QuestLog.IsQuestFlaggedCompleted(iwqID) then return AddColor(COMPLETE,LIGHT_RED) elseif iwqID and UnitLevel("player") == 120 then return AddColor(cur.." / "..max,LIGHT_GREEN) end
end

----------------------------------------------------------------------------	右键菜单---------------------------------------
--动作条样式
local SetMrbarMenuFrame = CreateFrame("Frame", "ClickMenu", UIParent, "UIDropDownMenuTemplate")
local SetMrbarMicromenu = {  
    --{ text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = "           "..MAINMENU_BUTTON.."", isTitle = true, notCheckable = true},
    --{ text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = CHARACTER, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        --func = function() ToggleFrame(CharacterFrame) end, notCheckable = true},
    --{ text = SPELLBOOK, icon = 'Interface\\MINIMAP\\TRACKING\\Class',
        --func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true},
    --{ text = TALENTS, icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition',
        --func = function() if (not PlayerTalentFrame) then C_AddOns.LoadAddOn('Blizzard_TalentUI') end
        --if (not GlyphFrame) then C_AddOns.LoadAddOn('Blizzard_GlyphUI') end
        --ToggleTalentFrame() end, notCheckable = true},
    --{ text = INVENTORY_TOOLTIP,  icon = 'Interface\\MINIMAP\\TRACKING\\Banker',
        --func = function() ToggleAllBags() end, notCheckable = true},
    --{ text = ACHIEVEMENTS, icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
        --func = function() ToggleAchievementFrame() end, notCheckable = true},
    --{ text = QUEST_LOG, icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        --func = function() ToggleQuestLog() end, notCheckable = true},
    --{ text = FRIENDS, icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
        --func = function() ToggleFriendsFrame() end, notCheckable = true},
    --{ text = GUILD, icon = 'Interface\\GossipFrame\\TabardGossipIcon',
        --func = function() if (IsTrialAccount()) then UIErrorsFrame:AddMessage(ERR_RESTRICTED_ACCOUNT, 1, 0, 0) else ToggleGuildFrame() end end, notCheckable = true},
    --{ text = GROUP_FINDER, icon = 'Interface\\LFGFRAME\\BattleNetWorking0',
        --func = function() securecall(PVEFrame_ToggleFrame, 'GroupFinderFrame', LFDParentFrame) end, notCheckable = true},
    --{ text = ENCOUNTER_JOURNAL, icon = 'Interface\\MINIMAP\\TRACKING\\Profession',
        --func = function() ToggleEncounterJournal() end, notCheckable = true},
    --{ text = PLAYER_V_PLAYER, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster', --broke
	     --func = function() securecall(PVEFrame_ToggleFrame, 'PVPUIFrame', HonorFrame) end, notCheckable = true},
    --{ text = MOUNTS, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',  --broke
	      --func = function() ToggleCollectionsJournal() end, notCheckable = true},
   -- { text = PETS, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',  --broke
	  --func = function() securecall(ToggleCollectionsJournal, 2) end, tooltipTitle = securecall(MicroButtonTooltipText, MOUNTS_AND_PETS, 'TOGGLEPETJOURNAL'), notCheckable = true},
    --{ text = TOY_BOX, icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',  --broke 
	  --func = function() securecall(ToggleCollectionsJournal, 3) end, tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'), notCheckable = true},
    --{ text = 'Heirlooms', icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',  --broke
	  --func = function() securecall(ToggleCollectionsJournal, 4) end, tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'), notCheckable = true},
    --{ text = "Calender",icon = 'Interface\\Calendar\\UI-Calendar-Button',  --broke 
         --func = function() C_AddOns.LoadAddOn('Blizzard_Calendar') Calendar_Toggle() end, notCheckable = true},
    --{ text = BLIZZARD_STORE, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         --func = function() C_AddOns.LoadAddOn('Blizzard_StoreUI') securecall(ToggleStoreUI) end, notCheckable = true},
    --{ text = GAMEMENU_HELP, icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
         --func = function() ToggleFrame(HelpFrame) end, notCheckable = true},
    --{ text = BATTLEFIELD_MINIMAP,
         --func = function() securecall(ToggleBattlefieldMinimap) end, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    { text = "           -|cFFFFFF00 2|r|cFFFF0000 UI |r- ", isTitle = true, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = MINIMAP_MENU_BARSTYLE,  icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         --func = function() SenduiCmd("/mr");  end, notCheckable = true},
    { text = MINIMAP_MENU_KEYBIND, icon = 'Interface\\MacroFrame\\MacroFrame-Icon.blp',
        func = function() SenduiCmd("/Keybind"); end, notCheckable = true},
    { text = "|cFF00DDFF ----- "..BINDING_NAME_MOVEANDSTEER.." -----|r", isTitle = true, notCheckable = true },
    { text = MINIMAP_MENU_SPECIALBUTTON, icon = 'Interface\\Icons\\INV_Inscription_RunescrollOfFortitude_Red',
        func = function() SenduiCmd("/moveit"); end, notCheckable = true},
    { text = MINIMAP_MENU_AURADIY, icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
        func = function() SenduiCmd("/awc"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_QUESTBUTTON, icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        --func = function() SenduiCmd("/eqb"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_CASTBAR, icon = 'Interface\\Icons\\INV_Misc_Bone_HumanSkull_02',
        --func = function() SenduiCmd("/cbs"); end, notCheckable = true},
    { text = MINIMAP_MENU_DAMAGESTYLE, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function() SenduiCmd("/dex"); end, notCheckable = true },
    { text = MINIMAP_MENU_DOOMCOOLDOWN, icon = 'Interface\\Icons\\Spell_Nature_Earthbind',
        func = function() SenduiCmd("/dcp"); end, notCheckable = true},
    --{ text = "传送助手", icon = 'Interface\\Calendar\\UI-Calendar-Button',
        --func = function() SenduiCmd("/tomeofteleport"); end, notCheckable = true},
    --{ text = "|cFF00DDFF ------- "..MINIMAP_MENU_ONOFF.." -------|r", isTitle = true, notCheckable = true},
    --{ text = MINIMAP_MENU_INTERRUPT, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
        --func = function() SenduiCmd("/esi"); end, notCheckable = true},
    --{text = MINIMAP_MENU_DISTANCE, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/hardyards sho") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/hardyards hid") end, notCheckable = true}
        --}
    --},
    --{text = MINIMAP_MENU_COMBOPOINTS, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/bht hiton") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/bht hitoff") end, notCheckable = true}
        --}
    --},
    --{text = MINIMAP_MENU_COMPAREITEMS, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/run SetCVar('alwaysCompareItems', 1)") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/run SetCVar('alwaysCompareItems', 0)") end, notCheckable = true}
        --}
    --},
    { text = "|cFF00DDFF ------- Style -------|r", isTitle = true, notCheckable = true },
    { text = MINIMAP_MENU_SWITCHUF, icon = 'Interface\\Icons\\Spell_Holy_Crusade',
        func = function() SenduiCmd("/loadui"); end, notCheckable = true},
    { text = MINIMAP_MENU_AFKSCREEN, icon = 'Interface\\Icons\\Spell_Nature_Sentinal',
        func = function() SenduiCmd("/wallpaperkit"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_CHECKFOODSSS, icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',
        --func = function() SenduiCmd("/hj"); end, notCheckable = true  },
    --{ text = MINIMAP_MENU_WORLDQUESTREWARD, icon = 'Interface\\Calendar\\UI-Calendar-Button',
        --func = function() SenduiCmd("/wqa popup"); end, notCheckable = true},
    --{ text = "|cFF00DDFF -- OneKeyMacro --|r", func = function() SenduiCmd("/MacroHelp"); end, notCheckable = true},
    { text = "  |cFFBF00FFSimc|r", func = function() SenduiCmd("/simc"); end, notCheckable = true},
    { text = "  |cFFBF00FFWe Love WOW|r", func = function() SenduiCmd("/welovewow"); end, notCheckable = true},
    { text = "|cffff8800 --------------------------|r", isTitle = true, notCheckable = true  },
    { text = "  |cFFBF00FF"..MINIMAP_MENU_QUSETIONANSWER.."|r", func = function() SenduiCmd("/MrHelp"); end, notCheckable = true},
    { text = "  |cFFBF00FF2 UI"..MINIMAP_MENU_UISETTING.."|r", func = function() SenduiCmd("/orzui"); end, notCheckable = true},
    { text = "|cffff8800 --------------------------|r", isTitle = true, notCheckable = true  },
    { text = "            |cFFBF00FF"..MINIMAP_MENU_MORE.."|r", func = function() SenduiCmd("/ip"); end, notCheckable = true},
    --{ text = "ESC菜单", func = function() ToggleFrame(GameMenuFrame) end, notCheckable = true},
    --{ text = "                       ", isTitle = true, notCheckable = true  },
    --{ text = LOGOUT, func = function() Logout() end, notCheckable = true},
    --{ text = QUIT, func = function() ForceQuit() end, notCheckable = true},
}

--WeekyDungeons
--## Author: Kimpa ## Version: 1.92
local rewardsTable = {
   {10, 662},
   {7, 658},
   {6, 655},
   {4, 652},
   {2, 649},
   {0, 645}
}
if WeeklyDungeonsMapIcon == nil then WeeklyDungeonsMapIcon = {} end
local resolution = GetCurrentScaledResolution()
if resolution >= 2560 then res = true end
local a = CreateFrame("Frame", "WeeklyDungeonsFrame", UIParent, "BasicFrameTemplate")
tinsert(UISpecialFrames, a:GetName())
if res then a:SetSize(520, 283) else a:SetSize(520 * 0.75 + 3, 283 * 0.75 + 6) end
--[[local infoButton = CreateFrame("Frame", nil, a)
infoButton:SetPoint("RIGHT", a.CloseButton, "LEFT", 5.93, -0.089)
infoButton:SetSize(33 * 0.7079, 33 * 0.7079)
infoButton:SetFrameLevel(2)
infoButton.tex = infoButton:CreateTexture(nil, "ARTWORK")
infoButton.tex:SetAtlas("worldquest-questmarker-questionmark")
infoButton.tex:SetSize(13 * 0.8, 17 * 0.8)
infoButton.tex:SetPoint("CENTER")
infoButton.tex.highlight = infoButton:CreateTexture(nil, "OVERLAY")
infoButton.tex.highlight:SetAllPoints()
infoButton.tex.highlight:SetTexture("Interface/Buttons/UI-Common-MouseHilight")
infoButton.tex.highlight:SetBlendMode("ADD") 
infoButton.tex.highlight:Hide()
infoButton:SetScript('OnEnter', function(self)
      infoButton.tex.highlight:Show()
      GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
      GameTooltip:AddLine('每周奖励染色：')
      GameTooltip:AddDoubleLine('\124cFFFF8000橙色：', '\124r装备等级 ' .. rewardsTable[1][2])
      GameTooltip:AddDoubleLine('\124cFFA335EE紫色：', '\124r装备等级 ' .. rewardsTable[2][2])
      GameTooltip:AddDoubleLine('\124cFF007ADD蓝色：', '\124r装备等级 ' .. rewardsTable[3][2])
      GameTooltip:AddDoubleLine('\124cFF1EFF00绿色：', '\124r装备等级 ' .. rewardsTable[4][2])
      GameTooltip:AddDoubleLine('\124cFFFFFFFF白色：', '\124r装备等级 ' .. rewardsTable[5][2])
      --GameTooltip:AddDoubleLine('\124cFF9D9D9DGray:', '\124rItem Level =< ' .. rewardsTable[6][2])
      GameTooltip:Show()
end)
infoButton:SetScript('OnLeave', function()
      infoButton.tex.highlight:Hide()
      GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
end)]]

a.TopLeftButtonBorder = a:CreateTexture()
a.TopLeftButtonBorder:SetSize(33, 21)
a.TopLeftButtonBorder:SetAtlas("UI-Frame-TopCornerRight")
a.TopLeftButtonBorder:SetTexCoord(1, 0, 0, 0.68)
a.TopLeftButtonBorder:SetPoint("TOPLEFT", a, -2, 0)
a.TopLeftButtonBorder:SetDrawLayer("OVERLAY", 0)
a.TopLeftButton = CreateFrame("Button", nil, a)
a.TopLeftButton.tex = a.TopLeftButton:CreateTexture(nil, "ARTWORK")
a.TopLeftButton.tex:SetAtlas("greatvault-dragonflight-32x32")
a.TopLeftButton.tex:SetSize(23, 23)
a.TopLeftButton.tex:SetPoint("CENTER")
a.TopLeftButton.tex.highlight = a.TopLeftButton:CreateTexture(nil, "OVERLAY")
a.TopLeftButton.tex.highlight:SetAllPoints()
a.TopLeftButton.tex.highlight:SetTexture("Interface/Buttons/UI-Common-MouseHilight")
a.TopLeftButton.tex.highlight:SetBlendMode("ADD") 
a.TopLeftButton.tex.highlight:Hide()
a.TopLeftButton:SetPoint("TOPLEFT", a, "TOPLEFT", -1, 1)
a.TopLeftButton:SetSize(23, 23)
a.TopLeftButton:SetScript("OnEnter", function(self)
   a.TopLeftButton.tex.highlight:Show()
 end)
 a.TopLeftButton:SetScript("OnLeave", function(self)
   a.TopLeftButton.tex.highlight:Hide()
 end)
a.TopLeftButton:SetScript("OnClick", function(self, button)
   C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
   WeeklyRewardsFrame:Show()
 end)
a:SetPoint("CENTER")
a:Hide()
local frame = CreateFrame("Frame", nil, UIParent)
a:SetMovable(true)
a:SetClampedToScreen(true)
a.LeftBorder:SetDrawLayer("OVERLAY", 1)
a.RightBorder:SetDrawLayer("OVERLAY")
a.BotLeftCorner:SetDrawLayer("OVERLAY")
frame:EnableMouse(true)
frame:SetScript("OnMouseDown", function(self, button)
      if button == "LeftButton" and not self.isMoving then
         a:StartMoving();
         self.isMoving = true;
      end
end)
frame:SetScript("OnMouseUp", function(self, button)
      if button == "LeftButton" and self.isMoving then
         a:StopMovingOrSizing();
         self.isMoving = false;
      end
end)
frame:SetScript("OnHide", function(self)
      if ( self.isMoving ) then
         self:StopMovingOrSizing();
         self.isMoving = false;
      end
end)
--frame:SetAllPoints(a.TitleBg)
local bg = CreateFrame("frame", nil, a)
bg:SetFrameLevel(1)
bg:SetAllPoints(a.Bg)
bg.HorizBord = CreateFrame("frame", nil, bg)
bg.HorizBord:CreateTexture(nil, "ARTWORK", "_Talent-Inner-TopTile")
bg.HorizBord:SetPoint("CENTER", bg, "CENTER", -1, -1)
if res then bg.HorizBord:SetSize(516, 14) else bg.HorizBord:SetSize(516 * 0.75, 14 * 0.75) end
bg.HorizBord:SetFrameLevel(1)
bg.VertBord1 = CreateFrame("frame", nil, bg)
bg.VertBord1:CreateTexture(nil, "ARTWORK", "!Talent-Inner-RightTile")
bg.VertBord1:SetPoint("LEFT", bg, "LEFT", res and 120 or 120 * 0.75, 0)
if res then bg.VertBord1:SetSize(14, 258) else bg.VertBord1:SetSize(14 * 0.75, 258 * 0.75) end --258
bg.VertBord1:SetFrameLevel(1)
bg.VertBord2 = CreateFrame("frame", nil, bg)
bg.VertBord2:CreateTexture(nil, "ARTWORK", "!Talent-Inner-RightTile")
bg.VertBord2:SetPoint("LEFT", bg, "LEFT", res and 249 or 249 * 0.75, 0)
if res then bg.VertBord2:SetSize(14, 258) else bg.VertBord2:SetSize(14 * 0.75, 258 * 0.75) end
bg.VertBord2:SetFrameLevel(1)
bg.VertBord3 = CreateFrame("frame", nil, bg)
bg.VertBord3:CreateTexture(nil, "ARTWORK", "!Talent-Inner-RightTile")
bg.VertBord3:SetPoint("LEFT", bg, "LEFT", res and 378 or 378 * 0.75, 0)
if res then bg.VertBord3:SetSize(14, 258) else bg.VertBord3:SetSize(14 * 0.75, 258 * 0.75) end
bg.VertBord3:SetFrameLevel(1)
--Create Textures/Fonstrings
bg.tex = {}
bg.numfont = {}
bg.levelfont = {}
bg.Rewardframe = {}
for i = 1, 8 do 
   bg.tex[i] = bg:CreateTexture("weeklyDungText" .. i, "BORDER")
   local relative
   local anchor
   if i == 1 then bg.tex[i]:SetPoint("TOPLEFT", bg, "TOPLEFT", 0, -1)
   elseif (i > 1 and i < 5) or (i > 5) then bg.tex[i]:SetPoint("TOPLEFT", bg.tex[i - 1], "TOPRIGHT", 1, 0)
   elseif i == 5 then bg.tex[i]:SetPoint("TOPLEFT", bg.tex[1], "BOTTOMLEFT", 0, -1)end
   if res then bg.tex[i]:SetSize(128, 128) else bg.tex[i]:SetSize(128 * 0.75, 128 * 0.75) end
   bg.numfont[i] = bg:CreateFontString()
   bg.numfont[i]:SetPoint("BOTTOMRIGHT", bg.tex[i], "BOTTOMRIGHT", -3, i < 6 and 3 or -1)
   bg.numfont[i]:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
   if(i == 1 or i == 4 or i == 8) then
      bg.numfont[i]:SetTextColor(1, 0.82, 0)
   end
   bg.levelfont[i] = bg:CreateFontString()
   bg.levelfont[i]:SetPoint("CENTER", bg.tex[i], "CENTER")
   bg.levelfont[i]:SetFont(STANDARD_TEXT_FONT, 72, "OUTLINE")
   if i == 1 or i == 4 or i == 8 then
      bg.Rewardframe[i] = CreateFrame("frame", nil, bg)
      bg.Rewardframe[i]:SetSize(212 * 0.23, 119 * 0.23)
      
      bg.Rewardframe[i]:SetFrameLevel(1)
      bg.Rewardframe[i].tex = bg.Rewardframe[i]:CreateTexture("ARTWORK")
      bg.Rewardframe[i].tex:SetAllPoints()
      bg.Rewardframe[i].tex:SetAtlas("weeklyrewards-orb-unlocked")
      if i == 1 then
         bg.Rewardframe[i]:SetPoint("CENTER", bg.numfont[i], "CENTER", -4, 3)
      elseif i == 4 then
         bg.Rewardframe[i]:SetPoint("CENTER", bg.numfont[i], "CENTER", -7, 3)
      elseif i == 8 then
         bg.Rewardframe[i]:SetPoint("CENTER", bg.numfont[i], "CENTER", -10, 2)
      end
      bg.Rewardframe[i]:SetScript('OnLeave', function()
         GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
      end)
  end
end
--Set Textures/Fontstrings
local texNum
InsertKey = function(texture, level, timed)
   if texNum < 9 then
bg.tex[texNum]:SetTexture(texture)
      if texture == "Interface/LFGFrame/GroupFinder" then
         bg.tex[texNum]:SetTexCoord(0.00048828125, 0.16064453125, 0.0009765625, 0.3291015625)
      else
         bg.tex[texNum]:SetTexCoord(0,1,0,1)
      end
      if timed then 
         bg.tex[texNum]:SetDesaturated(false)
      else
         bg.tex[texNum]:SetDesaturated(true)
      end
      bg.numfont[texNum]:SetText(texNum)
      if level then
         bg.levelfont[texNum]:SetText(level)
         if level >= rewardsTable[1][1] then
            local color = ITEM_QUALITY_COLORS[5]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false)
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFFFF8000' .. rewardsTable[1][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[2][1] then
            local color = ITEM_QUALITY_COLORS[4]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFFA335EE' .. rewardsTable[2][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[3][1] then
            local color = ITEM_QUALITY_COLORS[3]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF007ADD' .. rewardsTable[3][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[4][1] then
            local color = ITEM_QUALITY_COLORS[2]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF1EFF00' .. rewardsTable[4][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[5][1] then
            local color = ITEM_QUALITY_COLORS[1]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[5][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[6][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[6][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[7][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[7][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[8][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[8][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[9][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[9][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[10][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[10][2])
                  GameTooltip:Show()
               end)
            end
         elseif level >= rewardsTable[11][1] then
            local color = ITEM_QUALITY_COLORS[0]
            bg.levelfont[texNum]:SetTextColor(color.r, color.g, color.b)
            if texNum == 1 or texNum == 4 or texNum == 8 then 
               bg.Rewardframe[texNum].tex:SetDesaturated(false) 
               bg.Rewardframe[texNum]:SetScript('OnEnter', function(self)
                  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
                  GameTooltip:AddLine('Item Level: \124cFF9D9D9D' .. rewardsTable[11][2])
                  GameTooltip:Show()
               end)
            end
         end
         
      else 
         bg.levelfont[texNum]:SetText("")
         if texNum == 1 or texNum == 4 or texNum == 8 then
            bg.Rewardframe[texNum].tex:SetDesaturated(true) 
            bg.Rewardframe[texNum]:SetScript('OnEnter', function(self) end)
         end
      end
      texNum = texNum + 1
  end
end
--Populate frames
local PopulateFrame = function()
   local runs = C_MythicPlus.GetRunHistory(false, true)
   local levelList = {}
   for key in pairs(runs)do
      if levelList[runs[key].level] == nil then levelList[runs[key].level] = {} end
      local name, id, timeLimit, dungTexture = C_ChallengeMode.GetMapUIInfo(runs[key].mapChallengeModeID)
      local payload = {dungTexture = dungTexture, level = runs[key].level, timed = runs[key].completed}
      table.insert(levelList[runs[key].level], payload)
   end
   local success = false
   repeat
      success = false
      for level in pairs(levelList) do
         if level - 1 > 0 and levelList[level - 1] == nil then
            levelList[level - 1] = levelList[level]
            levelList[level] = nil
            success = true
         end
      end
   until success == false
   success = false
   repeat
      success = false
      for level in pairs(levelList) do
         for key in pairs(levelList[level]) do
            if levelList[level][key].timed == false and levelList[level][key + 1] and levelList[level][key + 1].timed then
               local swap1 = levelList[level][key]
               local swap2 = levelList[level][key + 1]
               levelList[level][key] = swap2
               levelList[level][key + 1] = swap1
               success = true
            end
         end
      end
   until success == false
   local levelCount = 0
   for level in pairs(levelList) do
      levelCount = levelCount + 1
   end
   levelList.length = levelCount
   for i = levelList.length, 1, -1 do
      for key in pairs(levelList[i]) do
         InsertKey(levelList[i][key].dungTexture, levelList[i][key].level, levelList[i][key].timed)
      end
   end
   for i = 1, 10 do
      InsertKey("Interface/LFGFrame/GroupFinder")
   end
end
--Events
local f = CreateFrame("Frame")
function f:CHALLENGE_MODE_COMPLETED()
   C_MythicPlus.RequestMapInfo()
end
function f:CHALLENGE_MODE_MAPS_UPDATE()
   texNum = 1
   PopulateFrame()
end
function f:OnEvent(event, ...)
   self[event](self, event, ...)
end
f:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:SetScript("OnEvent", f.OnEvent)

function self.ldb:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddDoubleLine(TITLEREADME)
    --GameTooltip:AddDoubleLine(ERR_QUEST_HAS_IN_PROGRESS,"|T".."Interface\\Addons\\OrzUI\\Media\\Modules\\MaoR-UI"..":32|t")
    --GameTooltip:AddLine(" ")
    --GameTooltip:AddDoubleLine(quest_icon..AddColor("[|cffFFaaaa"..C_CurrencyInfo.GetCurrencyInfo(1580).."|r] ",GOLD), CheckCurrency())
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(138019),LIGHT_BLUE), completedstring(44554))            --史诗钥石
    GameTooltip:AddDoubleLine(quest_icon..AddColor(GARRISON_LANDING_INVASION,LIGHT_BLUE), GarrisonInvade())
    GameTooltip:AddDoubleLine(quest_icon..AddColor(PLAYER_DIFFICULTY_TIMEWALKER,LIGHT_BLUE), TimeTravelFB())   --TBC--WLK--CTM 
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(132892),LIGHT_BLUE), completedstring(34774))            --布林顿 C_PetJournal.GetPetAbilityInfo(989)
    --GameTooltip:AddLine(" ")
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Legion  1/11 ",PINK), LegionWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Tomb  1/4 ",PINK), TombWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Argus  1/4 ",PINK), ArgusWolrdBoss())
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-怒之煞",ZONE_BLUE), completedstring(32099))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-炮舰",ZONE_BLUE), completedstring(32098))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-纳拉克",ZONE_BLUE), completedstring(32518))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-乌达斯塔",ZONE_BLUE), completedstring(32519))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暗影领主艾斯卡|cffffddFF(死爪)|r",ZONE_BLUE), completedstring(39287))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-游侠将军|cffffddFF(泰罗菲斯特)|r",ZONE_BLUE), completedstring(39288))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-攻城大师玛塔克|cffffddFF(末日之轮)|r",ZONE_BLUE), completedstring(39289))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暴君维哈里|cffffddFF(维金斯)|r",ZONE_BLUE), completedstring(39290)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-鲁克玛",ZONE_BLUE), completedstring(37464)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-蜘蛛收割者",ZONE_BLUE), completedstring(55512))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-锈羽",ZONE_BLUE), completedstring(55811))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-无声者",ZONE_BLUE), completedstring(56298))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-四风之龙艾夏克",ZONE_BLUE), completedstring(57259))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-腐肉饕餮者",ZONE_BLUE), completedstring(57273))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-亥离",ZONE_BLUE), completedstring(57344))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-犬师任衙",ZONE_BLUE), completedstring(57345))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-丹心魁麟昂德",ZONE_BLUE), completedstring(57363))
   --GameTooltip:AddDoubleLine(rare_icon..AddColor("BFA-食尸者",ZONE_BLUE), completedstring(58696))
   --GameTooltip:AddLine(" ")
   --GameTooltip:AddDoubleLine(quest_icon..AddColor(ISLANDS_HEADER,LIGHT_BLUE), CheckIslandweekly())
   --GameTooltip:AddLine(" ")
   GameTooltip:AddLine(chest_icon..AddColor(BOSS_DEAD,GOLD))
   for i = 1, GetNumSavedInstances() do
	   local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, level, total, progress = GetSavedInstanceInfo(i)
	   GameTooltip:AddDoubleLine(AddColor(name.."("..level..")",WHITE), locked and AddColor(progress.."/"..total, LIGHT_GREEN) or AddColor(" 0/0 ", LIGHT_RED))
   end
   GameTooltip:Show()
end

function self.ldb:OnLeave()
    GameTooltip:Hide()
end

function self.ldb:OnClick(button)
	--if button == "RightButton" then EasyMenu(SetMrbarMicromenu, SetMrbarMenuFrame, "cursor", 0, 0, "MENU", 2) else TeleporterFunction() end
      if button == "RightButton" then
         if a:IsShown() then a:Hide()
         else 
            texNum = 1
            PopulateFrame()
            C_MythicPlus.RequestMapInfo()
            a:Show()
         end
      elseif button == "LeftButton" then
        NiceDamage:OpenConfig()
      else
         EasyMenu(SetMrbarMicromenu, SetMrbarMenuFrame, "cursor", 0, 0, "MENU", 2) 
      end
end

    -- Register the Options Table with AceConfig
    LibStub("AceConfig-3.0"):RegisterOptionsTable("NiceDamage", self:GetOptions())
    
    -- Add the options to the Blizzard Settings menu
    -- We use the full name here for the display label in the menu
    local categoryId = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NiceDamage", NiceDamageLocal, nil)

    -- Register chat commands for easy access
    self:RegisterChatCommand("nd", "OpenConfig")
    self:RegisterChatCommand("nicedamage", "OpenConfig")
    
    -- Apply fonts immediately on load
    self:ApplySystemFonts()
end

-- Opens the Blizzard Settings category for this addon
function NiceDamage:OpenConfig()
    if Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(categoryId)
    end
end

-- Core logic for updating the game engine fonts
function NiceDamage:ApplySystemFonts()
    if not self.db.profile.enabled then return end
    
    local fontPath = LSM:Fetch("font", self.db.profile.fontName)
    local sizeScale = tostring(self.db.profile.fontSize or 1)
    
    if fontPath then
        -- 1. WORLD TEXT (Damage/Healing numbers floating in the 3D world)
        if self.db.profile.updateWorldText then
            DAMAGE_TEXT_FONT = fontPath
            SetCVar("WorldTextScale", sizeScale)
            -- Apply the gravity setting from the database
            SetCVar("WorldTextGravity", tostring(self.db.profile.fontGravity or 0.5))
            SetCVar("WorldTextRampDuration", tostring(self.db.profile.fontRampDuration or 1.0))
        end
                
        -- 2. UI TEXT (Damage received, scrolling combat text on player frame)
        if self.db.profile.updateUiText then

            -- Combine flags
            local flags = self.db.profile.uiOutline or ""
            if self.db.profile.uiMonochrome then
                if flags == "" then
                    flags = "MONOCHROME"
                else
                    flags = flags .. ", MONOCHROME"
                end
            else -- If MONOCHROME is not enabled add SLUG
                if flags == "" then
                    flags = "SLUG"
                else
                    flags = flags .. ", SLUG"
                end
            end


            -- Fetch the specific UI font path
            local uiFontPath = LSM:Fetch("font", self.db.profile.uiFont)
            if uiFontPath then
                local fonts = { CombatTextFont, DamageNumberFont, WorldFont }
                for _, fontObj in ipairs(fonts) do
                    if fontObj then
                        fontObj:SetFont(uiFontPath, 16 ,flags)
                        local off = self.db.profile.uiShadowOffset or 1
                        fontObj:SetShadowOffset(off, -off)
                        fontObj:SetShadowColor(0, 0, 0, 1) -- Black shadow
                    end
                end
            end
        end
    end
end

-- Toggles visibility of the Minimap button
function NiceDamage:UpdateMinimapIcon()
    if self.db.global.minimap.hide then
        self.icon:Hide("NiceDamage")
    else
        self.icon:Show("NiceDamage")
    end
end


function NiceDamage:GetOptions()
    return {
        name = NiceDamageLocal,
        type = "group",
        args = {
            settings = {
                name = "通用设置",
                type = "group",
                inline = true,
                order = 1,
                args = {
                    enable = {
                        type = "toggle",
                        name = "启用插件",
                        desc = "切换战斗文字字体的替换。",
                        get = function() return self.db.profile.enabled end,
                        set = function(_, v) 
                            self.db.profile.enabled = v
                            self:ApplySystemFonts() 
                        end,
                        order = 1,
                    },
                    loadCustom = {
                        type = "toggle",
                        name = "加载自定义字体",
                        desc = "加载并自动选择'Edo'。 |cFFFF0000(需要您登出并重新登录才能在列表中看到)|r",
                        get = function() return self.db.profile.loadCustomFont end,
                        set = function(_, v) 
                            self.db.profile.loadCustomFont = v
                            if v then
                                self.db.profile.fontName = "Custom Font NDR"
                                self.db.profile.uiFont = "Custom Font NDR"
                            else
                                self.db.profile.fontName = "Pepsi Modern"
                                self.db.profile.uiFont = "Pepsi Modern"
                            end
                            self:ApplySystemFonts()
                        end,
                        order = 2,
                    },
                     --minimap = {
                        --type = "toggle",
                        --name = "Show Minimap Icon",
                        --desc = "Toggle the display of the minimap button.",
                        --get = function() return not self.db.global.minimap.hide end,
                        --set = function(_, v) 
                            --self.db.global.minimap.hide = not v
                            --self:UpdateMinimapIcon() 
                        --end,
                        --order = 3,
                    --},
                }
            },
            targets = {
                name = "文本更新",
                type = "group",
                inline = true,
                order = 2,
                args = {
                    world = {
                        type = "toggle",
                        name = "战斗伤害",
                        desc = "将字体应用到单位上方浮动的伤害和治疗数字。 |cFFFF0000(需要登出)|r",
                        get = function() return self.db.profile.updateWorldText end,
                        set = function(_, v) 
                            self.db.profile.updateWorldText = v
                            self:ApplySystemFonts() 
                        end,
                        order = 1,
                    },
                    ui = {
                        type = "toggle",
                        name = "滚动战斗文本",
                        desc = "将字体应用到你受到的伤害和滚动战斗文本。",
                        get = function() return self.db.profile.updateUiText end,
                        set = function(_, v) 
                            self.db.profile.updateUiText = v
                            self:ApplySystemFonts() 
                        end,
                        order = 2,
                    },
                }
            },
            worldFontGroup = {
                name = "战斗伤害字体外观",
                type = "group",
                inline = true,
                order = 3,
                args = {
                    warning = {
                        type = "description",
                        name = "|cFFFF0000重要：|r 更改战斗字体需要您登出。大小更改会立即生效。",
                        order = 1,
                        fontSize = "medium",
                    },
                    worldFont = {
                        type = "select",
                        name = "战斗伤害字体",
                        desc = "选择对敌伤害的字体。",
                        dialogControl = 'LSM30_Font',
                        values = LSM:HashTable("font"),
                        get = function() return self.db.profile.fontName end,
                        set = function(_, v) 
                            self.db.profile.fontName = v
                            self:ApplySystemFonts() 
                        end,
                        order = 2,
                    },
                    fontSize = {
                        type = "range",
                        name = "战斗伤害缩放（世界）",
                        desc = "调整头顶数字的缩放。默认值为1.0。",
                        min = 0.5, max = 5, step = 0.1,
                        get = function() return self.db.profile.fontSize end,
                        set = function(_, v) 
                            self.db.profile.fontSize = v
                            self:ApplySystemFonts() 
                        end,
                        order = 3,
                    },
                    fontGravity = {
                        type = "range",
                        name = "战斗文字重力",
                        desc = "控制伤害数字下落的速度。默认值为0.5。",
                        min = -10, max = 10, step = 0.5,
                        get = function() return self.db.profile.fontGravity end,
                        set = function(_, v) 
                            self.db.profile.fontGravity = v
                            self:ApplySystemFonts() 
                        end,
                        order = 4,
                    },
                    fontRampDuration = {
                        type = "range",
                        name = "战斗文字持续时间",
                        desc = "控制伤害数字保持可见的时间。默认值为1.0。",
                        min = 0.1, max = 3.0, step = 0.01,
                        get = function() return self.db.profile.fontRampDuration end,
                        set = function(_, v) 
                            self.db.profile.fontRampDuration = v
                            self:ApplySystemFonts() 
                        end,
                        order = 5,
                    },
                },
            },
            uiFontGroup = {
                name = "滚动战斗文本外观",
                type = "group",
                inline = true,
                order = 4,
                args = {
                    uiFont = {
                        type = "select",
                        name = "滚动战斗字体",
                        desc = "选择 incoming damage/heals 的字体。",
                        dialogControl = 'LSM30_Font',
                        values = LSM:HashTable("font"),
                        get = function() return self.db.profile.uiFont end,
                        set = function(_, v) 
                            self.db.profile.uiFont = v
                            self:ApplySystemFonts() 
                        end,
                        order = 1,
                    },
                    fontOutline = {
                        type = "select",
                        name = "字体描边",
                        desc = "设置滚动文本的描边样式。",
                        values = {
                            [""] = "无",
                            ["OUTLINE"] = "细描边",
                            ["THICKOUTLINE"] = "粗描边",
                        },
                        get = function() return self.db.profile.uiOutline or "OUTLINE" end,
                        set = function(_, v) 
                            self.db.profile.uiOutline = v
                            self:ApplySystemFonts() 
                        end,
                        order = 2,
                    },
                    uiMonochrome = {
                        type = "toggle",
                        name = "单色",
                        desc = "禁用抗锯齿（移除字体平滑）。最适合像素字体。",
                        get = function() return self.db.profile.uiMonochrome end,
                        set = function(_, v) 
                            self.db.profile.uiMonochrome = v
                            self:ApplySystemFonts() 
                        end,
                        order = 3,
                    },
                    uiShadowOffset = {
                        type = "range",
                        name = "阴影偏移",
                        desc = "设置字体阴影的距离。0为关闭。",
                        min = 0, max = 10, step = 1,
                        get = function() return self.db.profile.uiShadowOffset end,
                        set = function(_, v) 
                            self.db.profile.uiShadowOffset = v
                            self:ApplySystemFonts() 
                        end,
                        order = 4,
                    },
                }
            }
        }
    }
end

-- Data structure: ["Font Name"] = { file = "filename.ttf", cyrillic = true/false }
local myFonts = {
    ["Edo"]         = { file = "Edo.ttf",      cyrillic = false },
    ["Eggo"]        = { file = "Eggo.ttf",     cyrillic = false },
    ["Infinity"]              = { file = "Infinity.ttf",           cyrillic = false },
    ["Pixel"]    = { file = "Pixel.ttf", cyrillic = false },
    ["RedCircl"]            = { file = "RedCircl.ttf",         cyrillic = false },
    ["Expressway"]           = { file = "Expressway.ttf",        cyrillic = true  },
    ["LifeCraft"]          = { file = "LifeCraft.ttf",       cyrillic = false  },
    ["Ginko"]   = { file = "Ginko.ttf",  cyrillic = false },
    ["yikes"]          = { file = "yikes.ttf",          cyrillic = false },
    ["bignoodletitling"]            = { file = "bignoodletitling.ttf",    cyrillic = false },
}

function NiceDamage:RegisterFonts()
    local prefix = "Interface\\AddOns\\OrzUI\\Media\\Fonts\\"

    local mask = (LSM.LOCALE_BIT_koKR or 1) + 
                 (LSM.LOCALE_BIT_ruRU or 2) + 
                 (LSM.LOCALE_BIT_zhCN or 4) + 
                 (LSM.LOCALE_BIT_zhTW or 8) + 
                 (LSM.LOCALE_BIT_western or 128)

    for name, data in pairs(myFonts) do
        -- Check if this is the custom font and if it should be loaded
        local shouldLoad = true
        if shouldLoad then
            local displayName = name
            LSM:Register("font", displayName, prefix .. data.file, mask)
        end
    end
end