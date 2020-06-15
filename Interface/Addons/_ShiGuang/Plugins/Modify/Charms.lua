--[[--------------Item Selling## Author: Spencer Sohn----------------------
local ItemSelling = StaticPopupDialogs["CONFIRM_MERCHANT_TRADE_TIMER_REMOVAL"] 
ItemSelling.OnAccept=nil 
ItemSelling.OnShow=function() StaticPopup_Hide("CONFIRM_MERCHANT_TRADE_TIMER_REMOVAL"); SellCursorItem(); end
----------------ArenaLeaveConfirmer----------------------
hooksecurefunc(StaticPopupDialogs["CONFIRM_LEAVE_BATTLEFIELD"],"OnShow",function(self)
	if IsActiveBattlefieldArena() or GetBattlefieldWinner() then self.button1:Click() end
end)]]
--------------------------------------Hide the left/right end cap------------------------
--MainMenuBarArtFrame.LeftEndCap:Hide()  MainMenuBarArtFrame.RightEndCap:Hide()   
-----------------------------------------	     随机队列倒计时    -----------------------------------------
local timerBar = CreateFrame("StatusBar", nil, LFGDungeonReadyPopup)
local timeLeft = 0
timerBar:SetPoint("BOTTOM", LFGDungeonReadyPopup, "TOP", 0, 0)
timerBar:SetSize(210, 12)
timerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar", "BORDER")
timerBar:SetStatusBarColor(1,.1,0)
timerBar:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	tile = true,
	tileSize = 32,
	insets = {left = -1, right = -1, top = -1, bottom = -1},
})
timerBar:Hide()
timerBar.Spark = timerBar:CreateTexture(nil, "OVERLAY")
timerBar.Spark:SetTexture"Interface\\CastingBar\\UI-CastingBar-Spark"
timerBar.Spark:SetSize(32, 32)
timerBar.Spark:SetBlendMode"ADD"
timerBar.Spark:SetPoint("LEFT", timerBar:GetStatusBarTexture(), "RIGHT", -15, 0)
timerBar.Border = timerBar:CreateTexture(nil, "ARTWORK")
timerBar.Border:SetTexture"Interface\\CastingBar\\UI-CastingBar-Border"
timerBar.Border:SetSize(266, 64)
timerBar.Border:SetPoint("TOP", timerBar, 0, 28)
timerBar.Text = timerBar:CreateFontString(nil, "OVERLAY")
timerBar.Text:SetFontObject(GameFontHighlight)
timerBar.Text:SetPoint("CENTER", timerBar, "CENTER")
timerBar:SetScript("OnUpdate", function(self, elapsed)
	timeLeft = (timeLeft or 0) - elapsed
	if(timeLeft <= 0) then return self:Hide() end
	self:SetValue(timeLeft)
	self.Text:SetFormattedText("%.1f", timeLeft)
end)

local LFGDungeonReadyTimeFrame = CreateFrame("Frame")
LFGDungeonReadyTimeFrame:RegisterEvent("LFG_PROPOSAL_SHOW") 
LFGDungeonReadyTimeFrame:SetScript("OnEvent", function(self, event, ...)
	timerBar:SetMinMaxValues(0, 40)
	timeLeft = 40
	timerBar:Show()
end)
----------------EventBossAutoSelect----------------------
LFDParentFrame:HookScript("OnShow",function()
  for i=1,GetNumRandomDungeons() do
   local id,name=GetLFGRandomDungeonInfo(i)
   if(select(15,GetLFGDungeonInfo(id)) and not GetLFGDungeonRewards(id)) then LFDQueueFrame_SetType(id) end
  end
 end)
-------------------------------------------------------------------------------  Auto Reagent Bank
local AutoReagentBank = CreateFrame("Frame")
AutoReagentBank:RegisterEvent("BANKFRAME_OPENED")
AutoReagentBank:SetScript("OnEvent", function(self, event, ...)
  if not MaoRUIPerDB["Misc"]["AutoReagentInBank"] then self:UnregisterAllEvents() return end
	if not BankFrameItemButton_Update_OLD then
		BankFrameItemButton_Update_OLD = BankFrameItemButton_Update
		BankFrameItemButton_Update = function(button)
			if BankFrameItemButton_Update_PASS == false then
				BankFrameItemButton_Update_OLD(button)
			else
				BankFrameItemButton_Update_PASS = false
			end
		end
	end
	BankFrameItemButton_Update_PASS = true
	DepositReagentBank()
end)

--[[----------------------------------------------------------------------------- ItemQualityIcons
hooksecurefunc("SetItemButtonQuality", function(button, quality, itemIDOrLink)
	button.IconBorder:Hide()

	local qualityIcon = button.qualityIcon
	if not qualityIcon then
		qualityIcon = CreateFrame("Frame", nil, button)
		qualityIcon:SetAllPoints()
		button.qualityIcon = qualityIcon
	end

	local iconColor = button.iconColor
	if not iconColor then
		iconColor = qualityIcon:CreateTexture("iconColor", "OVERLAY")
		iconColor:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Role\\bubbleTex")
		iconColor:ClearAllPoints()
		iconColor:SetPoint("TOPRIGHT", -5, -5)
		iconColor:SetSize(9, 9)
	end

	if quality then
		if BAG_ITEM_QUALITY_COLORS[quality] and quality ~= 1 then
			iconColor:SetVertexColor(BAG_ITEM_QUALITY_COLORS[quality].r, BAG_ITEM_QUALITY_COLORS[quality].g, BAG_ITEM_QUALITY_COLORS[quality].b)
		elseif quality == 1 then
			iconColor:SetVertexColor(1, 1, 1)
		elseif quality == 0 then
			iconColor:SetVertexColor(0.61568, 0.61568, 0.61568)
		end

		button.qualityIcon:Show()
	else
		button.qualityIcon:Hide()
	end
end)]]

------------------------------------------------------------------------------- NiceDamage
--Local NiceDamage = CreateFrame("Frame", "NiceDamage");
--function NiceDamage:ApplySystemDamageFonts() DAMAGE_TEXT_FONT = "Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\RedCircl.ttf"; end
--NiceDamage:SetScript("OnEvent", function() if (event == "ADDON_LOADED") then NiceDamage:ApplySystemDamageFonts() end end);
--NiceDamage:RegisterEvent("ADDON_LOADED");
--NiceDamage:ApplySystemDamageFonts()


--[[---------------------------- ## Notes: Automatically destroys items in the pre-defined list    ## Author: Tim @ WoW Interface    ## Version: 1.0
local itemList = {
	--[2287] = true,		-- haunch of meat (tested in RFC)  肉排
}
local DESTROY = CreateFrame("Frame", "AutoItemDestroyer")
DESTROY:RegisterEvent("BAG_UPDATE")
DESTROY:RegisterEvent("BAG_UPDATE_DELAYED")
DESTROY:RegisterEvent("CHAT_MSG_LOOT")
DESTROY:SetScript("OnEvent", function(_, event, ...)
   for bags = 0, 4 do
      for slots = 1, GetContainerNumSlots(bags) do
         local itemLink, linkID = GetContainerItemLink(bags, slots), GetContainerItemID(bags, slots)
         if (itemLink and linkID) then
            if (select(11, GetItemInfo(itemLink)) ~= nil and select(2, GetContainerItemInfo(bags, slots)) ~= nil) then
               local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(linkID) 
               if itemList[linkID] then
                  PickupContainerItem(bags, slots)
                  DeleteCursorItem()
                  --print("Searched bags... FOUND & DESTROYED: |cff6699dd", itemName.." [ID: "..linkID.."]")
               end
            end
         end
      end
   end
end)]]

------------------------------------------------------------------------------- 
--## Version: 1.2.0 ## Author: Crinseth
local waitTable = {};
local waitFrame = nil;
local Dressingbuttons = {}
local HIDDEN_SOURCES = {
	[77344] = true, -- head
	[77343] = true, -- shoulder
	[77345] = true, -- back
	[83202] = true, -- shirt
	[83203] = true, -- tabard
	[84223] = true, -- waist
}

function DressingWait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end

-- Updates slot buttons content based on PlayerActor
local updateSlots = function()
    local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
    for slot, button in pairs(Dressingbuttons) do
        local slotID, slotTexture = GetInventorySlotInfo(slot)
		local sourceID = playerActor:GetSlotTransmogSources(slotID)
		if sourceID == NO_TRANSMOG_SOURCE_ID or HIDDEN_SOURCES[sourceID] then
			button.item = nil
			button.text = nil
			button.icon:SetTexture(slotTexture)
			button:Disable()
		else
			local categoryID, appearanceID, canEnchant, icon, isCollected, link = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
			button.item = link
			button.text = UNKNOWN
			button.icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
			button:Enable()
		end
    end
end

-- Undress button
local undressButton = CreateFrame("Button", nil, DressUpFrame, "UIPanelButtonTemplate")
undressButton:SetSize(80, 21)
undressButton:SetText(CHARMS_NAKEDIZE)
undressButton:SetPoint("BOTTOMLEFT", 6, 4)
undressButton:SetScript("OnClick", function()
    DressUpFrame.ModelScene:GetPlayerActor():Undress()
    updateSlots()
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)

local DressUpTargetBtn = CreateFrame("Button",nil,DressUpFrame,"UIPanelButtonTemplate") 
DressUpTargetBtn:SetSize(80, 21)
DressUpTargetBtn:SetText(CHARMS_TARGET)
DressUpTargetBtn:SetPoint("LEFT", undressButton, "RIGHT", 0,0)
DressUpTargetBtn:Disable()
DressUpTargetBtn:SetScript("OnClick", function()
	DressUpFrame.ModelScene:GetPlayerActor():SetModelByUnit("target", false, true)
	updateSlots()
end)
DressUpTargetBtn:RegisterEvent("PLAYER_TARGET_CHANGED")
DressUpTargetBtn:SetScript("OnEvent", function()
	if UnitExists("target") and UnitIsPlayer("target") then
		DressUpTargetBtn:Enable() 
	else 
		DressUpTargetBtn:Disable() 
	end
end)

-- Toggle buttons visibility
local function showButtons(show)
    for slot, button in pairs(Dressingbuttons) do
        if show then
            button:Show()
        else
            button:Hide()
        end
    end
    if show then
        undressButton:Show()
        DressUpTargetBtn:Show()
    else
        undressButton:Hide()
        DressUpTargetBtn:Hide()
    end
end
-- Button click event
local function onClick(self, button)
	if button == "RightButton" then
		local slotID, slotTexture = GetInventorySlotInfo(self.slot)
        DressUpFrame.ModelScene:GetPlayerActor():UndressSlot(slotID)
        updateSlots()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	elseif self.item and IsModifiedClick() then
		HandleModifiedItemClick(self.item)
	end
end
-- Button hover event
local function onEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	if self.item then
		GameTooltip:SetHyperlink(self.item)
	else
		GameTooltip:SetText(self.text or _G[string.upper(self.slot)])
	end
end
-- Button size constants
local buttonSize = 35
local buttonSizeWithPadding = buttonSize + 5
local sideInsetLeft = 10
local sideInsetRight = 12
local topInset = -80
local SLOTS = {
	"HeadSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"ShirtSlot",
	"TabardSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"MainHandSlot",
	"SecondaryHandSlot",
}
-- Create item slot buttons
for i, slot in ipairs(SLOTS) do
    local button = CreateFrame("Button", nil, DressUpFrame)
    button:SetFrameStrata("HIGH")
    button:SetSize(buttonSize, buttonSize)
    if i <= 7 then
        button:SetPoint("TOPLEFT", sideInsetLeft, topInset + -buttonSizeWithPadding * (i - 1))
    else
        local place = i
        if i > 11 then
            place = place + 1
        end
        button:SetPoint("TOPRIGHT", -sideInsetRight, topInset + -buttonSizeWithPadding * (place - 8))
    end
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:SetMotionScriptsWhileDisabled(true)
    button:SetScript("OnClick", onClick)
    button:SetScript("OnEnter", onEnter)
    button:SetScript("OnLeave", GameTooltip_Hide)
    button.slot = slot

    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetSize(buttonSize, buttonSize)
    button.icon:SetPoint("CENTER")
    
    button.highlight = button:CreateTexture()
    button.highlight:SetSize(buttonSize, buttonSize)
    button.highlight:SetPoint("CENTER")
    button.highlight:SetAtlas("bags-glow-white")
    button.highlight:SetBlendMode("ADD")
    button:SetHighlightTexture(button.highlight)
    Dressingbuttons[slot] = button
end

-- Hook onto PlayerActor creation in order to hook onto its functions
local _SetupPlayerForModelScene = SetupPlayerForModelScene
function SetupPlayerForModelScene(...)
    showButtons(true)
    local resultSetupPlayerForModelScene = _SetupPlayerForModelScene(...)
    local playerActor = DressUpFrame.ModelScene:GetPlayerActor()

    -- Update slots when a gear piece has changed
    local _TryOn = playerActor.TryOn
    playerActor.TryOn = function (...)
        local resultTryOn = _TryOn(...)
        updateSlots()
        return resultTryOn
    end

    -- Update slots when reset button has been pressed
    local _Dress = playerActor.Dress
    playerActor.Dress = function (...)
        local resultDress = _Dress(...)
        updateSlots()
        return resultDress
    end
    DressingWait(0.1, updateSlots, nil)
    return resultSetupPlayerForModelScene
end

local _DressUpSources = DressUpSources
function DressUpSources(...)
    local resultDressUpSources = _DressUpSources(...)
    DressingWait(0.1, updateSlots, nil)
    return resultDressUpSources
end

-- Hide buttons for pet preview
local _DressUpBattlePet = DressUpBattlePet
function DressUpBattlePet(...)
    showButtons(false)
    return _DressUpBattlePet(...)
end

-- Hide buttons for mount preview
local _DressUpMount = DressUpMount
function DressUpMount(...)
    showButtons(false)
    return _DressUpMount(...)
end

--## Title: Extended Transmog UI  ## Author: Germbread ## Version: 1.1.1
function ExtTransmog_RebuildFrame()
    WardrobeFrame:SetWidth(1200);
    --WardrobeFrame:SetScale(0.82);
    WardrobeTransmogFrame:SetWidth(535);
    WardrobeTransmogFrame.ModelScene:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 0, -4);
    WardrobeTransmogFrame.ModelScene:SetWidth(420);
    WardrobeTransmogFrame.ModelScene:SetHeight(420);
    WardrobeTransmogFrame.Inset.BG:SetWidth(529);

    WardrobeTransmogFrame.ModelScene.HeadButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.HeadButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -238, -41);
    WardrobeTransmogFrame.ModelScene.HandsButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.HandsButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 235, -118);

    WardrobeTransmogFrame.ModelScene.MainHandButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", -26, -5);
    WardrobeTransmogFrame.ModelScene.SecondaryHandButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", 27, -5);
    WardrobeTransmogFrame.ModelScene.MainHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene.MainHandButton, "BOTTOM", 0, -20);
    WardrobeTransmogFrame.ModelScene.SecondaryHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene.SecondaryHandButton, "BOTTOM", 0, -20); 
    
    UIPanelWindows["WardrobeFrame"].width = 1200;   
end
local ExtTransmogUI = CreateFrame("Frame")
ExtTransmogUI:RegisterEvent("ADDON_LOADED")
ExtTransmogUI:SetScript("OnEvent",function(self,event,addon)
    if addon=="Blizzard_Collections" then
		ExtTransmogUI:UnregisterEvent("ADDON_LOADED")
		ExtTransmog_RebuildFrame()
	end
end)

--## Version: 1.0 ## Author: HopeAsd(叶蜀黍@埃德萨拉-CN)
local MountsSource = CreateFrame("frame")
MountsSource.mounts = {}
MountsSource:RegisterEvent("PLAYER_ENTERING_WORLD")
MountsSource.bootFlag = false

function MountsSource:isCollected(spell)
    local index = self.mounts[spell].index
    local isCollected = select(11, C_MountJournal.GetMountInfoByID(index))
    return isCollected
end

function MountsSource:GetOrCreateMountTable(spell)
    if not self.mounts[spell] then
        local index = C_MountJournal.GetMountFromSpell(spell)
        if index then
            local _, mSpell, _, _, _, sourceType =
                C_MountJournal.GetMountInfoByID(index)
            if spell == mSpell then
                local _, _, source = C_MountJournal.GetMountInfoExtraByID(index)
                self.mounts[spell] = {source = source, index = index}
            end
            return self.mounts[spell]
        end
        return nil
    end
    return self.mounts[spell]
end

function addLine(self, source, isCollectedText, type, noadd)
    for i = 1, self:NumLines() do
        local line = _G[self:GetName() .. "TextLeft" .. i]
        if not line then break end
        local text = line:GetText()
        if text and text == type then return end
    end
    if not noadd then self:AddLine(" ") end
    self:AddDoubleLine(type,isCollectedText)
    self:AddLine(source, 1, 1, 1)
    self:Show()
end

function MountsSource:boot()
    if not self.bootFlag then
        local boot = self
        hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
            local id = select(10, UnitAura(...))
            if not id then return end
            local tab = boot:GetOrCreateMountTable(id)
            if not tab then return end
            addLine(self, tab.source,
                    boot:isCollected(id) and COLLECTED or NOT_COLLECTED, SOURCE)
            self:Show()
        end)
        self.bootFlag = true
    end
end

MountsSource:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:boot()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end)

------------------
--[[------------------------------------------------------------
兑换信息
---------------------------------------------------------------]]
local success, CharIcon = pcall(function() return CharacterStatsPane.ItemLevelFrame.Corruption end)
function SetOrHookScript(target,eventName,func)
	if target:GetScript(eventName) then
		return target:HookScript(eventName,func)
	else
		return target:SetScript(eventName,func)
	end
end

    LOCALES = {
        PATTERN_INFO = "%d级%s",
        UNKNOWN = "其他或专有",
        special = "专有",

        passive_crit_dam = "爆伤",
        passive_mastery = "渠精",
        passive_haste = "渠急",
        passive_versatility = "渠全",
        passive_crit = "渠暴",
        passive_avoidance = "闪避",
        passive_leech = "吸血",

        proc_haste = "急速",
        proc_crit = "暴击",
        proc_mastery = "精通",
        proc_versatility = "全能",

        twilight = "暮光",
        ritual = "仪式",
        twisted = "触须",
        clarity = "洞察",
        truth = "真相",
        echo = "回响",
        star = "无尽",
        bleed = "龟裂",
    }

local data = {
  affixes = {
    [6437] = { key = "passive_crit_dam", level = 1, },
    [6438] = { key = "passive_crit_dam", level = 2, },
    [6439] = { key = "passive_crit_dam", level = 3, },
    [6471] = { key = "passive_mastery", level = 1, },
    [6472] = { key = "passive_mastery", level = 2, },
    [6473] = { key = "passive_mastery", level = 3, },
    [6474] = { key = "passive_haste", level = 1, },
    [6475] = { key = "passive_haste", level = 2, },
    [6476] = { key = "passive_haste", level = 3, },
    [6477] = { key = "passive_versatility", level = 1, },
    [6478] = { key = "passive_versatility", level = 2, },
    [6479] = { key = "passive_versatility", level = 3, },
    [6480] = { key = "passive_crit", level = 1, },
    [6481] = { key = "passive_crit", level = 2, },
    [6482] = { key = "passive_crit", level = 3, },
    [6483] = { key = "passive_avoidance", level = 1, },
    [6484] = { key = "passive_avoidance", level = 2, },
    [6485] = { key = "passive_avoidance", level = 3, },
    [6493] = { key = "passive_leech", level = 1, },
    [6494] = { key = "passive_leech", level = 2, },
    [6495] = { key = "passive_leech", level = 3, },
    [6537] = { key = "twilight", level = 1, },
    [6538] = { key = "twilight", level = 2, },
    [6539] = { key = "twilight", level = 3, },
    [6540] = { key = "ritual", level = 1, },
    [6541] = { key = "ritual", level = 2, },
    [6542] = { key = "ritual", level = 3, },
    [6543] = { key = "twisted", level = 1, },
    [6544] = { key = "twisted", level = 2, },
    [6545] = { key = "twisted", level = 3, },
    [6546] = { key = "clarity", level = 1, },
    [6547] = { key = "truth", level = 1, },
    [6548] = { key = "truth", level = 2, },
    [6549] = { key = "echo", level = 1, },
    [6550] = { key = "echo", level = 2, },
    [6551] = { key = "echo", level = 3, },
    [6552] = { key = "star", level = 1, },
    [6553] = { key = "star", level = 2, },
    [6554] = { key = "star", level = 3, },
    [6555] = { key = "proc_haste", level = 1, },
    [6556] = { key = "proc_crit", level = 1, },
    [6557] = { key = "proc_mastery", level = 1, },
    [6558] = { key = "proc_versatility", level = 1, },
    [6559] = { key = "proc_haste", level = 2, },
    [6560] = { key = "proc_haste", level = 3, },
    [6561] = { key = "proc_crit", level = 2, },
    [6562] = { key = "proc_crit", level = 3, },
    [6563] = { key = "proc_mastery", level = 2, },
    [6564] = { key = "proc_mastery", level = 3, },
    [6565] = { key = "proc_versatility", level = 2, },
    [6566] = { key = "proc_versatility", level = 3, },
    [6573] = { key = "bleed", level = 1, },
  },
  corrupts = {
    bleed = { 15, },
    clarity = { 15, },
    echo = { 25, 35, 60, },
    passive_avoidance = { 10, 15, 20, },
    passive_crit = { 10, 15, 20, },
    passive_crit_dam = { 10, 15, 20, },
    passive_haste = { 10, 15, 20, },
    passive_leech = { 10, 15, 20, },
    passive_mastery = { 10, 15, 20, },
    passive_versatility = { 10, 15, 20, },
    proc_crit = { 15, 20, 35, },
    proc_haste = { 15, 20, 35, },
    proc_mastery = { 15, 20, 35, },
    proc_versatility = { 15, 20, 35, },
    ritual = { 15, 35, 66, },
    star = { 20, 50, 75, },
    truth = { 12, 30, },
    twilight = { 25, 50, 75, },
    twisted = { 10, 35, 66, },
  },
}

local icons = {
  bleed = "Interface/Icons/Ability_IronMaidens_CorruptedBlood",
  clarity = "Interface/Icons/ability_warlock_soulswap",
  echo = "Interface/Icons/Ability_Priest_VoidEntropy",
  passive_avoidance = "Interface/Icons/spell_warlock_demonsoul",
  passive_crit = "Interface/Icons/Ability_Priest_ShadowyApparition",
  passive_crit_dam = "Interface/Icons/Achievement_Profession_Fishing_FindFish",
  passive_haste = "Interface/Icons/Ability_Mage_NetherWindPresence",
  passive_leech = "Interface/Icons/Spell_Shadow_LifeDrain02_purple",
  passive_mastery = "Interface/Icons/Ability_Rogue_SinisterCalling",
  passive_versatility = "Interface/Icons/Spell_Arcane_ArcaneTactics",
  proc_crit = "Interface/Icons/Ability_Hunter_RaptorStrike",
  proc_haste = "Interface/Icons/Ability_Warrior_BloodFrenzy",
  proc_mastery = "Interface/Icons/Spell_Nature_FocusedMind",
  proc_versatility = "Interface/Icons/Ability_Hunter_OneWithNature",
  ritual = "Interface/Icons/Spell_Shadow_Shadesofdarkness",
  star = "Interface/Icons/Ability_Druid_Starfall",
  truth = "Interface/Icons/INV_Wand_1H_NzothRaid_D_01",
  twilight = "Interface/Icons/Spell_Priest_VoidSear",
  twisted = "Interface/Icons/Achievement_Boss_YoggSaron_01",
  special = "INterface\\Icons\\INV_Misc_QuestionMark",
}

if success and GetCVar("portal") == "CN" then
    local prices = { [10] = 3000, [12] = 3300, [15] = 4125, [16] = 4250, [17] = 4250, [20] = 5000, [28] = 6300, [30] = 6750, [35] = 7875, [45] = 9000, [50] = 10000, [66] = 13200, [75] = 15000, }
    local vendors = {
        { { "truth", 1, }, { "proc_mastery", 1, }, { "passive_crit_dam", 2, }, { "passive_mastery", 2, }, { "passive_haste", 3, }, { "twisted", 3, }, },
        { { "passive_mastery", 1, }, { "ritual", 1, }, { "proc_crit", 2, }, { "passive_leech", 2, }, { "truth", 2, }, { "passive_versatility", 3, }, { "passive_avoidance", 2, }, },
        { { "star", 1, }, { "proc_versatility", 1, }, { "clarity", 1, }, { "passive_crit", 2, }, { "proc_haste", 3, }, { "passive_leech", 3, }, { "passive_avoidance", 3, }, },
        { { "passive_crit", 1, }, { "passive_leech", 1, }, { "passive_haste", 2, }, { "twilight", 2, }, { "proc_mastery", 3, }, { "passive_crit_dam", 3, }, },
        { { "passive_haste", 1, }, { "twisted", 1, }, { "proc_haste", 2, }, { "echo", 2, }, { "star", 3, }, { "passive_crit", 3, }, },
    }
    local firstTime = time({ year =2020, month=5, day=21, hour=7})
    local interval = 60*60*24*7/2
    local timeFormat = "%m月%d日%H:%M"

    local tip = CorruptionVendorTooltip or CreateFrame("GameTooltip", "CorruptionVendorTooltip", UIParent, "GameTooltipTemplate")
    SetOrHookScript(GameTooltip, "OnHide", function() tip:Hide() end)

    local function formatOne(key, level)
        if not key then return " " end
        return format("\124T%s:11\124t %d级%s %s", icons[key] or icons.special, level, LOCALES[key] or LOCALES.UNKNOWN, data.corrupts[key] and prices[data.corrupts[key][level]] or "????")
    end

    local function addVendorTip(list, color)
        for i=1, #list, 2 do
            local left = formatOne(list[i][1], list[i][2])
            local right = list[i+1] and formatOne(list[i+1][1], list[i+1][2]) or " "
            GameTooltip_AddColoredDoubleLine(tip, left, right, color or HIGHLIGHT_FONT_COLOR, color or HIGHLIGHT_FONT_COLOR, true);
        end
    end

    CharIcon:HookScript("OnEnter", function()
        local round = floor((time()-firstTime)/interval)
        round = round % 8 + 1 --0->1 7->8 8->1
        local nextDate = date("%m月%d日 %H:%M", firstTime + round * interval)

        tip:SetOwner(GameTooltip, "ANCHOR_NONE")
        tip:ClearAllPoints()
        tip:SetMinimumWidth(100)
        tip:SetPoint("TOPLEFT", GameTooltip, "TOPRIGHT", 5, 0)
        GameTooltip_AddColoredLine(tip, "腐蚀兑换情况", HIGHLIGHT_FONT_COLOR);
        GameTooltip_AddColoredLine(tip, "心之密室纯净圣母处可以用回响换腐蚀附魔，因为国服更新时间晚于美服，所以北京时间每周二晚23:00可以预知周四早7:00、每周六中午11:00可以预知周日晚19:00刷新的腐蚀", NORMAL_FONT_COLOR);

        GameTooltip_AddBlankLineToTooltip(tip);
        GameTooltip_AddColoredLine(tip, "当前 至 " .. date(timeFormat, firstTime + round * interval), NORMAL_FONT_COLOR);
        local list = vendors[round]
        if not list then
            GameTooltip_AddColoredLine(tip, "暂时没有数据", HIGHLIGHT_FONT_COLOR)
        else
            addVendorTip(list)
        end

        GameTooltip_AddBlankLineToTooltip(tip);
        GameTooltip_AddColoredLine(tip, "下一轮 " .. date(timeFormat, firstTime + round * interval) .. " 至 " .. date(timeFormat, firstTime + (round+1) * interval), NORMAL_FONT_COLOR);
        list = vendors[round+1]
        if not list then
            local round2 = floor((time()+32*60*60-firstTime)/interval) --提前32小时
            round2 = round2 % 8 + 1
            GameTooltip_AddColoredLine(tip, round == round2 and "美服尚未更新，请等待并及时更新爱不易" or "没有数据，请等待并及时更新爱不易", GRAY_FONT_COLOR)
        else
            addVendorTip(list, GRAY_FONT_COLOR)
        end

        for i=2,7 do
            GameTooltip_AddBlankLineToTooltip(tip);
            GameTooltip_AddColoredLine(tip, date(timeFormat, firstTime + (round+i) * interval) .. " 至 " .. date(timeFormat, firstTime + (round+i+1) * interval), NORMAL_FONT_COLOR);
            local list = vendors[(round+i-1)%8+1]
            if not list then
                GameTooltip_AddColoredLine(tip, "尚未轮换", GRAY_FONT_COLOR)
            else
                addVendorTip(list, GRAY_FONT_COLOR)
            end
        end

        tip:Show()
    end)
end
