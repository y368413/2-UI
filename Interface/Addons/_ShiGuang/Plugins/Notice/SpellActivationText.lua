--## Author: CN-无尽之海-简繁丶-www.douyu.com/323075  ## Version: 11.0-7
local width, height = SpellActivationOverlayFrame:GetSize(),SpellActivationOverlayFrame:GetSize()/2
local function AddTextFrame(size1,size2,name,point1,point2,x,y,fontsize)
	local SATFrame = CreateFrame("Frame", nil, SpellActivationOverlayFrame)
    SATFrame:SetSize(size1,size2)
	SATFrame:SetPoint(point1, SpellActivationOverlayFrame, point2, 0, 0)
	local SATCooldown = CreateFrame("Cooldown",name,SATFrame)
	SATCooldown:Hide()
	local SATText = SATFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	SATText:SetFont("fonts\\ARHei.ttf", fontsize, "OUTLINE")
	SATText:SetPoint("CENTER", SATFrame, "CENTER", x, y)
	SATText:SetVertexColor(1,1,1)
	local function UpdateText()
		SATFrame:SetScale(SATCooldown:GetScale())
		local StarTime,durationTime = SATCooldown:GetCooldownTimes()
		local durationText = (StarTime+durationTime)/1000-GetTime()
		if durationText > 10 then
			SATText:SetText(format("%d", durationText))
		elseif durationText > 0 then
			SATText:SetText(format("%.1f", durationText))
		else
			SATText:SetText("")
		end
	end
	SATCooldown:HookScript("OnUpdate", UpdateText)
	return SATCooldown
end
local toptext = AddTextFrame(width,height,"toptext","BOTTOM","TOP",0,0,30)
local toptext2 = AddTextFrame(width,height,"toptext2","BOTTOM","TOP",0,0,30)
local lefttext = AddTextFrame(height,width,"lefttext","RIGHT","LEFT",-40,0,30)
local lefttext1 = AddTextFrame(height,width,"lefttext1","RIGHT","LEFT",-10,0,30)
local lefttext2 = AddTextFrame(height,width,"lefttext2","RIGHT","LEFT",-10,0,45)
local righttext = AddTextFrame(height,width,"toptext","LEFT","RIGHT",40,0,30)
local righttext1 = AddTextFrame(height,width,"toptext1","LEFT","RIGHT",10,0,30)
local righttext2 = AddTextFrame(height,width,"toptext2","LEFT","RIGHT",10,0,45)
local bottomtext = AddTextFrame(width,height,"toptext","TOP","BOTTOM",0,0,30)

local topid,topid2,leftid,leftid1,leftid2,rightid,rightid1,rightid2,Oldrightid,Oldrightid1,Oldrightid2,bottomid

hooksecurefunc(SpellActivationOverlayFrame,"ShowAllOverlays", function(self, spellID, texture, positions, scale, r, g, b)
	--如果右边ID查不到,就把他设置成左边的spellID
	if not C_UnitAuras.GetPlayerAuraBySpellID(spellID) then
		if (positions == 8 or positions == 11) and scale > 1 then
			Oldrightid = spellID
			spellID = leftid
		elseif (positions == 2 or positions == 9) and scale == 1 then
			Oldrightid1 = spellID
			spellID = leftid1
		elseif (positions == 2 or positions == 9) and scale < 1 then
			Oldrightid2 = spellID
			spellID = leftid2
		end
	end
	--如果还没查到ID就垃圾吧倒
	if not spellID then return end
	if not C_UnitAuras.GetPlayerAuraBySpellID(spellID) then return end

	local expirationTime = C_UnitAuras.GetPlayerAuraBySpellID(spellID).expirationTime
	local duration = C_UnitAuras.GetPlayerAuraBySpellID(spellID).duration
	if not duration or not expirationTime then return end
	--11.05更新Enum.ScreenLocationType
	if positions == 3 and scale >= 1 then
		toptext:SetCooldown(expirationTime-duration,duration)
		toptext:SetScale(scale)
		topid = spellID
	end
	if positions == 3 and scale < 1 then
		toptext2:SetCooldown(expirationTime-duration,duration)
		toptext2:SetScale(scale)
		topid2 = spellID
	end
	if (positions == 7 or positions == 11) and scale > 1 then
		lefttext:SetCooldown(expirationTime-duration,duration)
		lefttext:SetScale(scale)
		leftid = spellID
	end
	if (positions == 1 or positions == 9) and scale == 1 then
		lefttext1:SetCooldown(expirationTime-duration,duration)
		lefttext1:SetScale(scale)
		leftid1 = spellID
	end
	if (positions == 1 or positions == 9) and scale < 1 then
		lefttext2:SetCooldown(expirationTime-duration,duration)
		lefttext2:SetScale(scale)
		leftid2 = spellID
	end
	if (positions == 8 or positions == 11) and scale > 1 then
		righttext:SetCooldown(expirationTime-duration,duration)
		righttext:SetScale(scale)
		rightid = spellID
	end
	if (positions == 2 or positions == 9) and scale == 1 then
		righttext1:SetCooldown(expirationTime-duration,duration)
		righttext1:SetScale(scale)
		rightid1 = spellID
	end
	if (positions == 2 or positions == 9) and scale < 1 then
		righttext2:SetCooldown(expirationTime-duration,duration)
		righttext2:SetScale(scale)
		rightid2 = spellID
	end
	if positions == 4 then
		bottomtext:SetCooldown(expirationTime-duration,duration)
		bottomtext:SetScale(scale)
		bottomid = spellID
	end
end)
--替换不同层数的材质
hooksecurefunc(SpellActivationOverlayFrame,"ShowOverlay", function(self, spellID, texturePath, position, r, g, b)
	if not spellID then return end
	if not C_UnitAuras.GetPlayerAuraBySpellID(spellID) then return end
	local overlay = self:GetOverlay(spellID, position);
	local applications = C_UnitAuras.GetPlayerAuraBySpellID(spellID).applications
	if spellID == 263725 then--奥法的节能施法
		if applications == 1 then
			overlay.texture:SetTexture(1027131)
			overlay.texture:SetVertexColor(1,1,1)--默认白色
		elseif applications == 2 then
			overlay.texture:SetTexture(1027132)
			overlay.texture:SetVertexColor(0,1,1)--青色
		elseif applications == 3 then
			overlay.texture:SetTexture(1027133)
			overlay.texture:SetVertexColor(0,0.5,1)--青蓝色
		end
	end
end)

hooksecurefunc(SpellActivationOverlayFrame,"HideOverlays", function(self, spellID)

	if spellID == topid then
		toptext:SetCooldown(0,0)
	end
	if spellID == topid2 then
		toptext2:SetCooldown(0,0)
	end
	if spellID == leftid then
		lefttext:SetCooldown(0,0)
	end
	if spellID == leftid1 then
		lefttext1:SetCooldown(0,0)
	end
	if spellID == leftid2 then
		lefttext2:SetCooldown(0,0)
	end
	if spellID == rightid or spellID ==  Oldrightid then
		righttext:SetCooldown(0,0)
	end
	if spellID == rightid1 or spellID ==  Oldrightid1 then
		righttext1:SetCooldown(0,0)
	end
	if spellID == rightid2 or spellID ==  Oldrightid2 then
		righttext2:SetCooldown(0,0)
	end
	if spellID == bottomid then
		bottomtext:SetCooldown(0,0)
	end
end)