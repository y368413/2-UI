--[[
	Slothpala ## Version: 2.2.1
	UNIT_FRAME_SHOW_HEALTH_ONLY = true would be nice but taints the UI since PlayerFrame_ToVehicleArt/PlayerFrame_ToPlayerArt 
	call SetSize on the player healthbar. 
]]

local healthBar = _G.PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar
local healthBarMask = _G.PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBarMask
local resourceBars = {
	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar,
	InsanityBarFrame,
	AlternatePowerBar,
	MonkStaggerBar,
}
local frameTexture = PlayerFrame.PlayerFrameContainer.FrameTexture
local alternatePowerFrameTexture = PlayerFrame.PlayerFrameContainer.AlternatePowerFrameTexture
local frameFlash = PlayerFrame.PlayerFrameContainer.FrameFlash

--[[
	Hide the power bars and keep them hidden
]]

for i=1, #resourceBars do
	local statusBar = resourceBars[i]
	statusBar:SetAlpha(0) --hiding it can cause taint
	statusBar:HookScript("OnShow", function()
		statusBar:SetAlpha(0)
	end)
end

--[[
	Method to delay changes on protected regions
]]

local callback = function() end
local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function()
	callback()
	eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
end)

local function Delay(func)
	callback = func
	eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
end

--[[
	Hook into PlayerFrame_ToPlayerArt/PlayerFrame_ToVehicleArt and apply the settings that the game would do if UNIT_FRAME_SHOW_HEALTH_ONLY existed.
]]

local function OnToPlayerArt()
	-- frame textures
	frameTexture:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton")
	frameTexture:Show()
	alternatePowerFrameTexture:Hide()
	-- status textures
	frameFlash:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton-incombat", TextureKitConstants.UseAtlasSize)
	frameFlash:SetPoint("CENTER", frameFlash:GetParent(), "CENTER", -1, 0.5);
	-- resize health bar
	healthBar:SetHeight(32)
	healthBarMask:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton-bar-health-mask")
	healthBarMask:SetHeight(37)
	-- Font since tww the halth text is anchored to the container.
	local healthTextLeft = _G.PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.LeftText
	local healthTextMiddle = _G.PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBarText
	local healthTextRight = _G.PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.RightText
	healthTextLeft:SetPoint("LEFT", healthBar, "LEFT")
	healthTextMiddle:SetPoint("CENTER", healthBar, "CENTER")
	healthTextRight:SetPoint("RIGHT", healthBar, "RIGHT")
end

hooksecurefunc("PlayerFrame_ToPlayerArt", function()
	if InCombatLockdown() then
		Delay(OnToPlayerArt)
		return
	end
	OnToPlayerArt()
end)

local function OnToVehicleArt()
	healthBar:SetHeight(32)
end

hooksecurefunc("PlayerFrame_ToVehicleArt", function()
	if InCombatLockdown() then
		Delay(OnToVehicleArt)
		return
	end
	OnToVehicleArt()
end)
