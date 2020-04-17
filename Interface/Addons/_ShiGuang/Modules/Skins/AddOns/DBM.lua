local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")
local TT = M:GetModule("Tooltip")

local strfind, strmatch, gsub = string.find, string.match, string.gsub

function S:DBMSkin()
	-- Default notice message
	local RaidNotice_AddMessage_ = RaidNotice_AddMessage
	RaidNotice_AddMessage = function(noticeFrame, textString, colorInfo)
		if strfind(textString, "|T") then
            if strmatch(textString, ":(%d+):(%d+)") then
                local size1, size2 = strmatch(textString, ":(%d+):(%d+)")
                size1, size2 = size1 + 3, size2 + 3
                textString = gsub(textString,":(%d+):(%d+)",":"..size1..":"..size2..":0:0:64:64:5:59:5:59")
            elseif strmatch(textString, ":(%d+)|t") then
                local size = strmatch(textString, ":(%d+)|t")
                size = size + 3
                textString = gsub(textString,":(%d+)|t",":"..size..":"..size..":0:0:64:64:5:59:5:59|t")
            end
		end
		return RaidNotice_AddMessage_(noticeFrame, textString, colorInfo)
	end

	if not IsAddOnLoaded("DBM-Core") then return end
	if not MaoRUIPerDB["Skins"]["DBM"] then return end

	local buttonsize = 24

	local function reskinBarIcon(icon, bar)
		if icon.styled then return end

		icon:SetSize(buttonsize, buttonsize)
		icon.SetSize = M.Dummy
		icon:ClearAllPoints()
		icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -5, 0)
		local bg = M.ReskinIcon(icon)
		M.CreateSD(bg)
		bg.icon = bg:CreateTexture(nil, "BACKGROUND")
		bg.icon:SetInside()
		bg.icon:SetTexture("Interface\\Icons\\Spell_Nature_WispSplode")
		bg.icon:SetTexCoord(unpack(I.TexCoord))

		icon.styled = true
	end

	local function SkinBars(self)
		for bar in self:GetBarIterator() do
			if not bar.styeld then
				local frame		= bar.frame
				local tbar		= _G[frame:GetName().."Bar"]
				local spark		= _G[frame:GetName().."BarSpark"]
				local texture	= _G[frame:GetName().."BarTexture"]
				local icon1		= _G[frame:GetName().."BarIcon1"]
				local icon2		= _G[frame:GetName().."BarIcon2"]
				local name		= _G[frame:GetName().."BarName"]
				local timer		= _G[frame:GetName().."BarTimer"]

				if bar.color then
					tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
				else
					tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
				end

				if bar.enlarged then
					frame:SetWidth(bar.owner.options.HugeWidth)
					tbar:SetWidth(bar.owner.options.HugeWidth)
				else
					frame:SetWidth(bar.owner.options.Width)
					tbar:SetWidth(bar.owner.options.Width)
				end

				if not frame.styled then
					frame:SetScale(1)
					frame.SetScale = M.Dummy
					frame:SetHeight(buttonsize/2)
					frame.SetHeight = M.Dummy
					frame.styled = true
				end

				if not spark.killed then
					spark:SetAlpha(0)
					spark:SetTexture(nil)
					spark.killed = true
				end

				reskinBarIcon(icon1, tbar)
				reskinBarIcon(icon2, tbar)

				if not tbar.styled then
					M.StripTextures(tbar)
					M.CreateSB(tbar, true)
					tbar:SetInside(frame, 2, 2)
					tbar.SetPoint = M.Dummy
					tbar.styled = true
				end

				if not texture.styled then
					texture:SetTexture(I.normTex)
					texture.SetTexture = M.Dummy
					texture.styled = true
				end

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", frame, "LEFT", 2, 8)
					name:SetPoint("RIGHT", frame, "LEFT", tbar:GetWidth()*.85, 8)
					name.SetPoint = M.Dummy
					name:SetFont(I.Font[1], 14, I.Font[3])
					name.SetFont = M.Dummy
					name:SetJustifyH("LEFT")
					name:SetWordWrap(false)
					name:SetShadowColor(0, 0, 0, 0)
					name.styled = true
				end

				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", frame, "RIGHT", -2, 8)
					timer.SetPoint = M.Dummy
					timer:SetFont(I.Font[1], 14, I.Font[3])
					timer.SetFont = M.Dummy
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.styled = true
				end

				tbar:SetAlpha(1)
				frame:SetAlpha(1)
				frame:Show()
				bar:Update(0)

				bar.styeld = true
			end
		end
	end
	hooksecurefunc(DBT, "CreateBar", SkinBars)

	local function SkinRange()
		if DBMRangeCheckRadar and not DBMRangeCheckRadar.styled then
			TT.ReskinTooltip(DBMRangeCheckRadar)
			DBMRangeCheckRadar.styled = true
		end

		if DBMRangeCheck and not DBMRangeCheck.styled then
			TT.ReskinTooltip(DBMRangeCheck)
			DBMRangeCheck.styled = true
		end
	end
	hooksecurefunc(DBM.RangeCheck, "Show", SkinRange)

	if DBM.InfoFrame then
		DBM.InfoFrame:Show(5, "test")
		DBM.InfoFrame:Hide()
		DBMInfoFrame:HookScript("OnShow", TT.ReskinTooltip)
	end

	-- Force Settings
	if not DBM_AllSavedOptions["Default"] then DBM_AllSavedOptions["Default"] = {} end
	DBM_AllSavedOptions["Default"]["BlockVersionUpdateNotice"] = true
	DBM_AllSavedOptions["Default"]["EventSoundVictory"] = "None"
	DBT_AllPersistentOptions["Default"]["DBM"].BarYOffset = 12
	DBT_AllPersistentOptions["Default"]["DBM"].HugeBarYOffset = 12
	if IsAddOnLoaded("DBM-VPYike") then
		DBM_AllSavedOptions["Default"]["CountdownVoice"] = "VP:Yike"
		DBM_AllSavedOptions["Default"]["ChosenVoicePack"] = "Yike"
	end
end