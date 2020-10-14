--## Author-zhCN: NGA - 等你病要你命 - 整理---------------------------------------------------------------------------------------------

petModel=CreateFrame("frame")
petModel.Round = 0
petModel:SetScript('OnEvent',function(_, event, ...) return petModel[event](petModel, event, ...) end)
petModel.AddReg = function(self,event,func)
	if not petModel[event] then
		petModel:RegisterEvent(event)
		petModel[event]=func
	else
		hooksecurefunc(petModel,event,func)
	end
end

local STATUS_FRAME_SPACING = 4
local STATUS_FRAME_ICON_SIZE = 20
local statusFrame = CreateFrame("Frame", "petStatusFrame")

----------------------------------------
-- 状态框初始化函数
----------------------------------------
statusFrame.Initialize = function(self)
	-- 设置状态框
	statusFrame:SetWidth(120)
	statusFrame:SetHeight(80)
	statusFrame:SetPoint("TOPLEFT", 0, -300)
	statusFrame:SetBackdrop({
		bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
	    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	    tile = true, tileSize = 8, edgeSize = 8,
	    insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	statusFrame:SetBackdropColor(0, 0, 0, 0.8)
	statusFrame:SetBackdropBorderColor(0.8, 0.8, 0.8, 1.0);
	statusFrame:SetMovable(true)
	statusFrame:EnableMouse(true)
	statusFrame:RegisterForDrag("LeftButton")
	statusFrame:SetScript("OnDragStart", function() statusFrame:StartMoving() end)
	statusFrame:SetScript("OnDragStop", function() statusFrame:StopMovingOrSizing() end)

	-- 创建状态文字
	local text1 = statusFrame:CreateFontString(nil, "OVERLAY", "GameTooltipTextSmall")
	text1:SetPoint("TOPLEFT", STATUS_FRAME_SPACING + 2 + STATUS_FRAME_ICON_SIZE, -6)
	statusFrame.text1 = text1

	statusFrame.Initialize = nil
end

----------------------------------------
-- 更新状态框  \n\n|cff00ff00小号升到110级自动隐藏此框 |r。\n\n感谢使用宠物对战，|cffff8c00魔兽交流QQ群：256670662|r（群内分享更多实用工具插件哟~）\n\n插件作者：上官晓雾\n\n插件更新：纯情小黄牛"
----------------------------------------
statusFrame.Update = function(self, remXP, remBattles,stepXP)
	self.text1:SetText(format("目前你的等级  :  |cff00ff00%d|r \n已获得的经验  :  |cff00ff00%.2f%%|r \n升级需要经验  :  |cff00ff00%d|r \n上一把的经验  :  |cff00ff00%d|r \n升级需要几场  :  |cffff8c00%d|r ",
		UnitLevel("player"), floor(10000*(UnitXP("player")/UnitXPMax("player"))+0.5)/100, remXP, stepXP, remBattles))
	self:SetWidth(statusFrame.text1:GetWidth() + STATUS_FRAME_ICON_SIZE + STATUS_FRAME_SPACING * 2 + 2)

	if not self:IsShown() then self:Show() end
end

----------------------------------------


----------------------------------------
-- 更新状态框可见性
----------------------------------------
-- local wonBattles
-- local avgTime
-- local lastTime
local lastXP
statusFrame.UpdateVisibility = function(self)

		if self.Initialize then
			self:Initialize()
--			lastTime = GetTime()
			lastXP = UnitXP("player")
			self:Update(UnitXPMax("player") - lastXP, 0 , 0)
		end
		if UnitLevel("player") >= 120 then -- 达到120级时隐藏
			self:Hide()
		else
			self:Show()
		end
end

statusFrame:RegisterEvent("ZONE_CHANGED")
statusFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
statusFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
-- statusFrame:RegisterEvent("MINIMAP_ZONE_CHANGED")
statusFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

statusFrame:SetScript("OnEvent", function(self,event,...)
	statusFrame:UpdateVisibility()
end)

----------------------------------------
-- 经验值改变时计算并更新状态框
----------------------------------------
petModel:AddReg("PLAYER_XP_UPDATE",function(...)
statusFrame:UpdateVisibility()
	if not statusFrame:IsShown() then return end

--	local nowTime = GetTime()
	local curXP = UnitXP("player")
	local remXP = UnitXPMax("player") - curXP
	local remBattles = 0
	local stepXP = 0
	if lastXP and curXP > lastXP then
		stepXP = curXP - lastXP
		remBattles = remXP / stepXP
	end


	lastXP = curXP
	statusFrame:Update(remXP, ceil(remBattles),stepXP)

end)

----------------------------------------



--------------------------------------------------------------------------------------------------------------------------------