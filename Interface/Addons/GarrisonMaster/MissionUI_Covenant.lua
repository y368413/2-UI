﻿local addon_name, addon_env = ...

-- [AUTOLOCAL START]
-- [AUTOLOCAL END]

local ratio_current_health

local function MissionPage_RatioInit(gmm_options)
   local Board = gmm_options.MissionPage.Board
   ratio_current_health = Board:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
   ratio_current_health:SetWidth(100)
   ratio_current_health:SetHeight(0)
   ratio_current_health:SetJustifyH("LEFT")
   ratio_current_health:SetPoint("BOTTOMLEFT", Board.AllyHealthValue, "TOPLEFT", 0, 12)
end

local function UpdateEnemyToAllyPowerRatio(self, missionPage)
   -- TODO: find all info yourself, don't rely on reading it from UI
   local missionInfo = missionPage.missionInfo
   local missionID = missionInfo.missionID
   local missionDeploymentInfo = C_Garrison.GetMissionDeploymentInfo(missionInfo.missionID)

   local enemies = missionDeploymentInfo.enemies
   local enemiesAttack = 0
   local enemiesMaxHealth = 0
   for idx = 1, #enemies do
      local enemy = enemies[idx]
      enemiesAttack    = enemiesAttack    + enemy.attack
      enemiesMaxHealth = enemiesMaxHealth + enemy.maxHealth
   end

   local alliesAttack = 0
   local alliesCurrentHealth = 0
   for followerFrame in missionPage.Board:EnumerateFollowers() do
      local info = followerFrame.info
      if info then
         alliesAttack        = alliesAttack        + info.autoCombatantStats.attack
         alliesCurrentHealth = alliesCurrentHealth + info.autoCombatantStats.currentHealth
      end
   end

   local enemiesWinTurn = alliesCurrentHealth / enemiesAttack
   local alliesWinTurn = enemiesMaxHealth / alliesAttack


   if alliesWinTurn < enemiesWinTurn then
      -- allies winning faster -> success rate is better than 50/50
      ratio_current_health:SetFormattedText("|cFF00FF88√ %0.2f|r", enemiesWinTurn / alliesWinTurn)
   else
      -- enemies winning faster
      ratio_current_health:SetFormattedText("|cFFFF0000X %0.2f|r", alliesWinTurn / enemiesWinTurn)
   end
end

local function InitUI(gmm_options)
   MissionPage_RatioInit(gmm_options)
   hooksecurefunc(CovenantMissionFrame, "UpdateAllyPower", UpdateEnemyToAllyPowerRatio)
end

addon_env.AddInitUI({
   follower_type = Enum.GarrisonFollowerType.FollowerType_9_0,
   gmm_prefix    = 'Covenant',
   init          = InitUI,
})

