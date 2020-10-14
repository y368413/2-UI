------------------------ 自动邀请 -----------------------## Author: Jany  ## Version: 1.0.1
local AutoInviteFrame = CreateFrame("Frame")
AutoInviteFrame:RegisterEvent("ADDON_LOADED")
AutoInviteFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)
local button = CreateFrame("CheckButton",nil, LFGListFrame, "InterfaceOptionsCheckButtonTemplate")
button:SetPoint("TOPRIGHT",-40, 0)

button:SetScript("OnClick", function(self)
	ShiGuangDB["AutoInviteEnable"] = button:GetChecked()
end)

button.opensettings = CreateFrame("Button", nil, button,"UIPanelButtonTemplate")
button.opensettings:Show()
button.opensettings:SetHeight(25)
button.opensettings:SetWidth(25)
button.opensettings:SetPoint("RIGHT",20, 0)
button.opensettings:SetText("*")
button.opensettings:SetScript("OnClick", function (self)

	----职业--------
	button.zydropDown = CreateFrame("FRAME", "WPDemoDropDown", button, "UIDropDownMenuTemplate")
	button.zydropDown:SetPoint("RIGHT",180, -60)
	UIDropDownMenu_SetWidth(button.zydropDown, 100)
	UIDropDownMenu_SetText(button.zydropDown,"请选择")
	UIDropDownMenu_Initialize(button.zydropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		if (level or 1) == 1 then
			for k,v in pairs(ShiGuangDB["AutoInviteClass"]) do
				info.text, info.checked = k, ShiGuangDB["AutoInviteClass"][k]
				info.func = function()
					
					if ShiGuangDB["AutoInviteClass"][k] then ShiGuangDB["AutoInviteClass"][k]=false else ShiGuangDB["AutoInviteClass"][k] = true end
					--print(k,ShiGuangDB["AutoInviteClass"][k])
				end
				UIDropDownMenu_AddButton(info)	
			end
		end
	end)
	button.zydropDown.title = button.zydropDown:CreateFontString(nil, "ARTWORK")
	button.zydropDown.title:SetFont(GameFontNormal:GetFont(), 12)
	button.zydropDown.title:SetPoint("TOP", 0, 10)
	button.zydropDown.title:SetText("职业")

	----职责--------
	button.zzdropDown = CreateFrame("FRAME", "WPDemoDropDown", button, "UIDropDownMenuTemplate")
	button.zzdropDown:SetPoint("RIGHT",320, -60)
	UIDropDownMenu_SetWidth(button.zzdropDown, 100)
	UIDropDownMenu_SetText(button.zzdropDown,"请选择")
	UIDropDownMenu_Initialize(button.zzdropDown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		if (level or 1) == 1 then
			for k,v in pairs(ShiGuangDB["AutoInviteRole"]) do
				info.text, info.checked = k, ShiGuangDB["AutoInviteRole"][k]
				info.func = function()
					
					if ShiGuangDB["AutoInviteRole"][k] then ShiGuangDB["AutoInviteRole"][k]=false else ShiGuangDB["AutoInviteRole"][k] = true end
					--print(k,ShiGuangDB["AutoInviteRole"][k])
				end
				UIDropDownMenu_AddButton(info)	
			end
		end
	end)
	button.zzdropDown.title = button.zzdropDown:CreateFontString(nil, "ARTWORK")
	button.zzdropDown.title:SetFont(GameFontNormal:GetFont(), 12)
	button.zzdropDown.title:SetPoint("TOP", 0, 10)
	button.zzdropDown.title:SetText("职责")

	--等级----
	button.levelEdit = CreateFrame("EditBox", nil,button, "InputBoxTemplate")
	button.levelEdit:Show()
	button.levelEdit:SetWidth(50)
	button.levelEdit:SetHeight(20)
	button.levelEdit:SetPoint("RIGHT",110, -10)
	button.levelEdit:SetAutoFocus(false)
	button.levelEdit:SetText(ShiGuangDB["AutoInvitelevle"])
	button.levelEdit.title = button.levelEdit:CreateFontString(nil, "ARTWORK")
	button.levelEdit.title:SetFont(GameFontNormal:GetFont(), 12)
	button.levelEdit.title:SetPoint("TOP", 0, 10)
	button.levelEdit.title:SetText("等级")

	--装等----
	button.itemlevelEdit = CreateFrame("EditBox", nil,button, "InputBoxTemplate")
	button.itemlevelEdit:Show()
	button.itemlevelEdit:SetWidth(50)
	button.itemlevelEdit:SetHeight(20)
	button.itemlevelEdit:SetPoint("RIGHT",180, -10)
	button.itemlevelEdit:SetAutoFocus(false)
	button.itemlevelEdit:SetText(ShiGuangDB["AutoInviteilv"])
	button.itemlevelEdit.title = button.itemlevelEdit:CreateFontString(nil, "ARTWORK")
	button.itemlevelEdit.title:SetFont(GameFontNormal:GetFont(), 12)
	button.itemlevelEdit.title:SetPoint("TOP", 0, 10)
	button.itemlevelEdit.title:SetText("装等")

	--荣誉等级----
	button.honorlevelEdit = CreateFrame("EditBox", nil,button, "InputBoxTemplate")
	button.honorlevelEdit:Show()
	button.honorlevelEdit:SetWidth(50)
	button.honorlevelEdit:SetHeight(20)
	button.honorlevelEdit:SetPoint("RIGHT",240, -10)
	button.honorlevelEdit:SetAutoFocus(false)
	button.honorlevelEdit:SetText(ShiGuangDB["AutoInviteHonourilv"])
	button.honorlevelEdit.title = button.honorlevelEdit:CreateFontString(nil, "ARTWORK")
	button.honorlevelEdit.title:SetFont(GameFontNormal:GetFont(), 12)
	button.honorlevelEdit.title:SetPoint("TOP", 0, 10)
	button.honorlevelEdit.title:SetText("荣誉等级")

	button.ok = CreateFrame("Button", nil, button,"UIPanelButtonTemplate")
	button.ok:Show()
	button.ok:SetHeight(25)
	button.ok:SetWidth(50)
	button.ok:SetPoint("RIGHT",300, -10)
	button.ok:SetText("确定")
	button.ok:SetScript("OnClick", function (self)
		ShiGuangDB["AutoInvitelevle"] = button.levelEdit:GetText()
		ShiGuangDB["AutoInviteilv"] = button.itemlevelEdit:GetText()
		ShiGuangDB["AutoInviteHonourilv"] = button.honorlevelEdit:GetText()
		button.zydropDown:Hide()
		button.zzdropDown:Hide()
		button.levelEdit:Hide()
		button.itemlevelEdit:Hide()
		button.honorlevelEdit:Hide()
		self:Hide()
	end)
end)

function AutoInviteFrame:ADDON_LOADED()
	if ShiGuangDB["AutoInviteEnable"] == nil then ShiGuangDB["AutoInviteEnable"] = true end
	if ShiGuangDB["AutoInviteTank"] == nil then ShiGuangDB["AutoInviteTank"] = 1 end
	if ShiGuangDB["AutoInviteHeal"] == nil then ShiGuangDB["AutoInviteHeal"] = 1 end
	if ShiGuangDB["AutoInviteDPS"] == nil then ShiGuangDB["AutoInviteDPS"] = 3 end
	if ShiGuangDB["AutoInviteClass"] == nil then ShiGuangDB["AutoInviteClass"] = {
		["战士"]=true,
		["死亡骑士"]=true,
		["圣骑士"]=true,
		["德鲁伊"]=true,
		["武僧"]=true,
		["恶魔猎手"]=true,
		["术士"]=true,
		["潜行者"]=true,
		["猎人"]=true,
		["萨满祭司"]=true,
		["牧师"]=true,
		["法师"]=true,
		}
	end
	if ShiGuangDB["AutoInviteRole"] == nil then ShiGuangDB["AutoInviteRole"] = {
		["坦克"]=true,
		["治疗"]=true,
		["输出"]=true,
		}
	end
	if ShiGuangDB["AutoInvitelevle"] == nil then ShiGuangDB["AutoInvitelevle"] = 120 end
	if ShiGuangDB["AutoInviteilv"] == nil then ShiGuangDB["AutoInviteilv"] = 450 end
	if ShiGuangDB["AutoInviteHonourilv"] == nil then ShiGuangDB["AutoInviteHonourilv"] = 0 end
	if ShiGuangDB["AutoInviteRelationShip"] == nil then ShiGuangDB["AutoInviteRelationShip"] = 1 end
	if ShiGuangDB["AutoInviteEnable"] then button:SetChecked(true) else button:SetChecked(false) end
end 




hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", function(member, appID, memberIdx, status, pendingStatus)
	local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(appID, memberIdx);
	-- 名字，职业，本地化职业，等级，装等，荣誉等级，T,N,DPS,分配的角色,关系
	
	if ( name ) and ShiGuangDB["AutoInviteEnable"] and ShiGuangDB["AutoInviteClass"][localizedClass] and (ShiGuangDB["AutoInviteRole"]["坦克"] and ShiGuangDB["AutoInviteRole"]["坦克"] == tank) or (ShiGuangDB["AutoInviteRole"]["治疗"] and ShiGuangDB["AutoInviteRole"]["治疗"] == healer) or (ShiGuangDB["AutoInviteRole"]["输出"] and ShiGuangDB["AutoInviteRole"]["输出"] == damage) and level >= tonumber(ShiGuangDB["AutoInvitelevle"]) and  itemLevel >= tonumber(ShiGuangDB["AutoInviteilv"]) and  honorLevel >= tonumber(ShiGuangDB["AutoInviteHonourilv"]) then
		C_PartyInfo.InviteUnit(name);
		--LFGListApplicationViewerScrollFrameButton1:Click()
	end
end)
--[[
hooksecurefunc("LFGListGroupDataDisplayRoleCount_Update",function(self, displayData, disabled)
	print(displayData.TANK);
	print(displayData.HEALER);
	print(displayData.DAMAGER);	
end)
]]



