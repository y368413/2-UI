local _, ns = ...
local M, R, U, I = unpack(ns)
local cr, cg, cb = I.r, I.g, I.b

local _G = _G
local type, pairs, tonumber, wipe, next, select, unpack = type, pairs, tonumber, table.wipe, next, select, unpack
local strmatch, gmatch, strfind, format, gsub = string.match, string.gmatch, string.find, string.format, string.gsub
local min, max, floor, rad = math.min, math.max, math.floor, math.rad

function SenduiCmd(cmd) ChatFrame1EditBox:SetText(""); ChatFrame1EditBox:Insert(cmd); ChatEdit_SendText(ChatFrame1EditBox); end
-- Math
do
	-- Numberize
	function M.Numb(n)
		if MaoRUIDB["NumberFormat"] == 1 then
			if n >= 1e12 then
				return format("%.2ft", n / 1e12)
			elseif n >= 1e9 then
				return format("%.2fb", n / 1e9)
			elseif n >= 1e6 then
				return format("%.2fm", n / 1e6)
			elseif n >= 1e3 then
				return format("%.1fk", n / 1e3)
			else
				return format("%.0f", n)
			end
		elseif MaoRUIDB["NumberFormat"] == 2 then
			if n >= 1e12 then
				return format("%.2f"..U["NumberCap3"], n / 1e12)
			elseif n >= 1e8 then
				return format("%.2f"..U["NumberCap2"], n / 1e8)
			elseif n >= 1e4 then
				return format("%.1f"..U["NumberCap1"], n / 1e4)
			else
				return format("%.0f", n)
			end
		else
			return format("%.0f", n)
		end
	end

	function M:Round(number, idp)
		idp = idp or 0
		local mult = 10 ^ idp
		return floor(number * mult + .5) / mult
	end

	-- Cooldown calculation
	local day, hour, minute = 86400, 3600, 60
	function M.FormatTime(s)
		if s >= day then
			return format("%d"..I.MyColor.."d", s/day), s%day
		elseif s >= hour then
			return format("%d"..I.MyColor.."h", s/hour), s%hour
		elseif s >= minute then
			return format("%d"..I.MyColor.."m", s/minute), s%minute
		elseif s > 10 then
			return format("|cffcccc33%d|r", s), s - floor(s)
		elseif s > 3 then
			return format("|cffffff00%d|r", s), s - floor(s)
		else
			if MaoRUIPerDB["Actionbar"]["DecimalCD"] then
				return format("|cffff0000%.1f|r", s), s - format("%.1f", s)
			else
				return format("|cffff0000%d|r", s + .5), s - floor(s)
			end
		end
	end

	function M.FormatTimeRaw(s)
		if s >= day then
			return format("%dd", s/day)
		elseif s >= hour then
			return format("%dh", s/hour)
		elseif s >= minute then
			return format("%dm", s/minute)
		elseif s >= 3 then
			return floor(s)
		else
			return format("%d", s)
		end
	end

	function M:CooldownOnUpdate(elapsed, raw)
		local formatTime = raw and M.FormatTimeRaw or M.FormatTime
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= .1 then
			local timeLeft = self.expiration - GetTime()
			if timeLeft > 0 then
				local text = formatTime(timeLeft)
				self.timer:SetText(text)
			else
				self:SetScript("OnUpdate", nil)
				self.timer:SetText(nil)
			end
			self.elapsed = 0
		end
	end

	-- GUID to npcID
	function M.GetNPCID(guid)
		local id = tonumber(strmatch((guid or ""), "%-(%d-)%-%x-$"))
		return id
	end

	-- Table
	function M.CopyTable(source, target)
		for key, value in pairs(source) do
			if type(value) == "table" then
				if not target[key] then target[key] = {} end
				for k in pairs(value) do
					target[key][k] = value[k]
				end
			else
				target[key] = value
			end
		end
	end

	function M.SplitList(list, variable, cleanup)
		if cleanup then wipe(list) end
		for word in gmatch(variable, "%S+") do
			list[word] = true
		end
	end
end

-- Color
do
	function M.HexRGB(r, g, b)
		if r then
			if type(r) == "table" then
				if r.r then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
			end
			return format("|cff%02x%02x%02x", r*255, g*255, b*255)
		end
	end

	function M.ClassColor(class)
		local color = I.ClassColors[class]
		if not color then return 1, 1, 1 end
		return color.r, color.g, color.b
	end

	function M.UnitColor(unit)
		local r, g, b = 1, 1, 1
		if UnitIsPlayer(unit) then
			local class = select(2, UnitClass(unit))
			if class then
				r, g, b = M.ClassColor(class)
			end
		elseif UnitIsTapDenied(unit) then
			r, g, b = .6, .6, .6
		else
			local reaction = UnitReaction(unit, "player")
			if reaction then
				local color = FACTION_BAR_COLORS[reaction]
				r, g, b = color.r, color.g, color.b
			end
		end
		return r, g, b
	end
end

-- Itemlevel
do
	local iLvlDB = {}
	local itemLevelString = gsub(ITEM_LEVEL, "%%d", "")
	local enchantString = gsub(ENCHANTED_TOOLTIP_LINE, "%%s", "(.+)")
	local essenceTextureID = 2975691
	local essenceDescription = GetSpellDescription(277253)
	local ITEM_SPELL_TRIGGER_ONEQUIP = ITEM_SPELL_TRIGGER_ONEQUIP
	local RETRIEVING_ITEM_INFO = RETRIEVING_ITEM_INFO
	local tip = CreateFrame("GameTooltip", "NDui_ScanTooltip", nil, "GameTooltipTemplate")
	M.ScanTip = tip

	function M:InspectItemTextures()
		if not tip.gems then
			tip.gems = {}
		else
			wipe(tip.gems)
		end

		if not tip.essences then
			tip.essences = {}
		else
			for _, essences in pairs(tip.essences) do
				wipe(essences)
			end
		end

		local step = 1
		for i = 1, 10 do
			local tex = _G[tip:GetName().."Texture"..i]
			local texture = tex and tex:IsShown() and tex:GetTexture()
			if texture then
				if texture == essenceTextureID then
					local selected = (tip.gems[i-1] ~= essenceTextureID and tip.gems[i-1]) or nil
					if not tip.essences[step] then tip.essences[step] = {} end
					tip.essences[step][1] = selected		--essence texture if selected or nil
					tip.essences[step][2] = tex:GetAtlas()	--atlas place 'tooltip-heartofazerothessence-major' or 'tooltip-heartofazerothessence-minor'
					tip.essences[step][3] = texture			--border texture placed by the atlas

					step = step + 1
					if selected then tip.gems[i-1] = nil end
				else
					tip.gems[i] = texture
				end
			end
		end

		return tip.gems, tip.essences
	end

	function M:InspectItemInfo(text, slotInfo)
		local itemLevel = strfind(text, itemLevelString) and strmatch(text, "(%d+)%)?$")
		if itemLevel then
			slotInfo.iLvl = tonumber(itemLevel)
		end

		local enchant = strmatch(text, enchantString)
		if enchant then
			slotInfo.enchantText = enchant
		end
	end

	function M:CollectEssenceInfo(index, lineText, slotInfo)
		local step = 1
		local essence = slotInfo.essences[step]
		if essence and next(essence) and (strfind(lineText, ITEM_SPELL_TRIGGER_ONEQUIP, nil, true) and strfind(lineText, essenceDescription, nil, true)) then
			for i = 5, 2, -1 do
				local line = _G[tip:GetName().."TextLeft"..index-i]
				local text = line and line:GetText()

				if text and (not strmatch(text, "^[ +]")) and essence and next(essence) then
					local r, g, b = line:GetTextColor()
					essence[4] = r
					essence[5] = g
					essence[6] = b

					step = step + 1
					essence = slotInfo.essences[step]
				end
			end
		end
	end

	function M.GetItemLevel(link, arg1, arg2, fullScan)
		if fullScan then
			tip:SetOwner(UIParent, "ANCHOR_NONE")
			tip:SetInventoryItem(arg1, arg2)

			if not tip.slotInfo then tip.slotInfo = {} else wipe(tip.slotInfo) end

			local slotInfo = tip.slotInfo
			slotInfo.gems, slotInfo.essences = M:InspectItemTextures()

			for i = 1, tip:NumLines() do
				local line = _G[tip:GetName().."TextLeft"..i]
				if line then
					local text = line:GetText() or ""
					if i == 1 and text == RETRIEVING_ITEM_INFO then
						return "tooSoon"
					else
						M:InspectItemInfo(text, slotInfo)
						M:CollectEssenceInfo(i, text, slotInfo)
					end
				end
			end

			return slotInfo
		else
			if iLvlDB[link] then return iLvlDB[link] end

			tip:SetOwner(UIParent, "ANCHOR_NONE")
			if arg1 and type(arg1) == "string" then
				tip:SetInventoryItem(arg1, arg2)
			elseif arg1 and type(arg1) == "number" then
				tip:SetBagItem(arg1, arg2)
			else
				tip:SetHyperlink(link)
			end

			local firstLine = _G.NDui_ScanTooltipTextLeft1:GetText()
			if firstLine == RETRIEVING_ITEM_INFO then
				return "tooSoon"
			end

			for i = 2, 5 do
				local line = _G[tip:GetName().."TextLeft"..i]
				if line then
					local text = line:GetText() or ""
					local found = strfind(text, itemLevelString)
					if found then
						local level = strmatch(text, "(%d+)%)?$")
						iLvlDB[link] = tonumber(level)
						break
					end
				end
			end

			return iLvlDB[link]
		end
	end
end

-- Kill regions
do
	function M:Dummy()
		return
	end

	M.HiddenFrame = CreateFrame("Frame")
	M.HiddenFrame:Hide()

	function M:HideObject()
		if self.UnregisterAllEvents then
			self:UnregisterAllEvents()
			self:SetParent(M.HiddenFrame)
		else
			self.Show = self.Hide
		end
		self:Hide()
	end

	function M:HideOption()
		self:SetAlpha(0)
		self:SetScale(.0001)
	end

	local blizzTextures = {
		"Inset",
		"inset",
		"InsetFrame",
		"LeftInset",
		"RightInset",
		"NineSlice",
		"BG",
		"border",
		"Border",
		"Background",
		"BorderFrame",
		"bottomInset",
		"BottomInset",
		"bgLeft",
		"bgRight",
		"FilligreeOverlay",
		"PortraitOverlay",
		"ArtOverlayFrame",
		"Portrait",
		"portrait",
		"ScrollFrameBorder",
	}
	function M:StripTextures(kill)
		local frameName = self.GetName and self:GetName()
		for _, texture in pairs(blizzTextures) do
			local blizzFrame = self[texture] or (frameName and _G[frameName..texture])
			if blizzFrame then
				M.StripTextures(blizzFrame, kill)
			end
		end

		if self.GetNumRegions then
			for i = 1, self:GetNumRegions() do
				local region = select(i, self:GetRegions())
				if region and region.IsObjectType and region:IsObjectType("Texture") then
					if kill and type(kill) == "boolean" then
						M.HideObject(region)
					elseif tonumber(kill) then
						if kill == 0 then
							region:SetAlpha(0)
						elseif i ~= kill then
							region:SetTexture("")
						end
					else
						region:SetTexture("")
					end
				end
			end
		end
	end
end

-- UI widgets
do
	-- Fontstring
	function M:CreateFS(size, text, color, anchor, x, y, r, g, b)
		local fs = self:CreateFontString(nil, "OVERLAY")
		fs:SetFont(I.Font[1], size, I.Font[3])
		fs:SetText(text)
		fs:SetWordWrap(false)
		if color and type(color) == "boolean" then
			fs:SetTextColor(cr, cg, cb)
		elseif color == "system" then
			fs:SetTextColor(1, .8, 0)
		elseif color == "Chatbar" then
		        fs:SetTextColor(r, g, b)
		end
		if anchor and x and y then
			fs:SetPoint(anchor, x, y)
		else
			fs:SetPoint("CENTER", 1, 0)
		end

		return fs
	end

	-- Gametooltip
	function M:HideTooltip()
		GameTooltip:Hide()
	end
	local function Tooltip_OnEnter(self)
		GameTooltip:SetOwner(self, self.anchor)
		GameTooltip:ClearLines()
		if self.title then
			GameTooltip:AddLine(self.title)
		end
		if tonumber(self.text) then
			GameTooltip:SetSpellByID(self.text)
		elseif self.text then
			local r, g, b = 1, 1, 1
			if self.color == "class" then
				r, g, b = cr, cg, cb
			elseif self.color == "system" then
				r, g, b = 1, .8, 0
			elseif self.color == "info" then
				r, g, b = .6, .8, 1
			end
			GameTooltip:AddLine(self.text, r, g, b, 1)
		end
		GameTooltip:Show()
	end
	function M:AddTooltip(anchor, text, color)
		self.anchor = anchor
		self.text = text
		self.color = color
		self:SetScript("OnEnter", Tooltip_OnEnter)
		self:SetScript("OnLeave", M.HideTooltip)
	end

	-- Glow parent
	function M:CreateGlowFrame(size)
		local frame = CreateFrame("Frame", nil, self)
		frame:SetPoint("CENTER")
		frame:SetSize(size+8, size+8)

		return frame
	end

	-- Gradient texture
	local orientationAbbr = {
		["V"] = "Vertical",
		["H"] = "Horizontal",
	}
	function M:SetGradient(orientation, r, g, b, a1, a2, width, height)
		orientation = orientationAbbr[orientation]
		if not orientation then return end

		local tex = self:CreateTexture(nil, "BACKGROUND")
		tex:SetTexture(I.bdTex)
		tex:SetGradientAlpha(orientation, r, g, b, a1, r, g, b, a2)
		if width then tex:SetWidth(width) end
		if height then tex:SetHeight(height) end

		return tex
	end

	-- Background texture
	function M:CreateTex()
		if self.Tex then return end

		local frame = self
		if self:GetObjectType() == "Texture" then frame = self:GetParent() end

		self.Tex = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
		self.Tex:SetAllPoints(self)
		self.Tex:SetTexture(I.bgTex, true, true)
		self.Tex:SetHorizTile(true)
		self.Tex:SetVertTile(true)
		self.Tex:SetBlendMode("ADD")
	end

	-- Backdrop shadow
	local shadowBackdrop = {edgeFile = I.glowTex}

	function M:CreateSD(size, override)
		if not override and not MaoRUIPerDB["Skins"]["Shadow"] then return end
		if self.__shadow then return end

		local frame = self
		if self:GetObjectType() == "Texture" then frame = self:GetParent() end

		shadowBackdrop.edgeSize = size or 5
		self.__shadow = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		self.__shadow:SetOutside(self, size or 4, size or 4)
		self.__shadow:SetBackdrop(shadowBackdrop)
		self.__shadow:SetBackdropBorderColor(0, 0, 0, size and 1 or .4)
		self.__shadow:SetFrameLevel(1)

		return self.__shadow
	end
end

-- UI skins
do
	-- Setup backdrop
	R.frames = {}
	local defaultBackdrop = {bgFile = I.bdTex, edgeFile = I.bdTex}

	function M:CreateBD(a)
		defaultBackdrop.edgeSize = R.mult
		self:SetBackdrop(defaultBackdrop)
		self:SetBackdropColor(0, 0, 0, a or MaoRUIPerDB["Skins"]["SkinAlpha"])
		self:SetBackdropBorderColor(0, 0, 0)
		if not a then tinsert(R.frames, self) end
	end

	function M:CreateGradient()
		local tex = self:CreateTexture(nil, "BORDER")
		tex:SetInside()
		tex:SetTexture(I.bdTex)
		if MaoRUIPerDB["Skins"]["FlatMode"] then
			tex:SetVertexColor(.3, .3, .3, .25)
		else
			tex:SetGradientAlpha("Vertical", 0, 0, 0, .5, .3, .3, .3, .3)
		end

		return tex
	end

	-- Handle frame
	function M:CreateBDFrame(a, gradient)
		local frame = self
		if self:GetObjectType() == "Texture" then frame = self:GetParent() end
		local lvl = frame:GetFrameLevel()

		local bg = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		bg:SetOutside(self)
		bg:SetFrameLevel(lvl == 0 and 0 or lvl - 1)
		M.CreateBD(bg, a)
		if gradient then
			self.__gradient = M.CreateGradient(bg)
		end

		return bg
	end

	function M:SetBD(a, x, y, x2, y2)
		local bg = M.CreateBDFrame(self, a)
		if x then
			bg:SetPoint("TOPLEFT", self, x, y)
			bg:SetPoint("BOTTOMRIGHT", self, x2, y2)
		end
		M.CreateSD(bg)
		M.CreateTex(bg)

		return bg
	end

	-- Handle icons
	function M:ReskinIcon(shadow)
		self:SetTexCoord(unpack(I.TexCoord))
		local bg = M.CreateBDFrame(self)
		if shadow then M.CreateSD(bg) end
		return bg
	end

	function M:PixelIcon(texture, highlight)
		self.bg = M.CreateBDFrame(self)
		self.bg:SetAllPoints()
		self.Icon = self:CreateTexture(nil, "ARTWORK")
		self.Icon:SetInside()
		self.Icon:SetTexCoord(unpack(I.TexCoord))
		if texture then
			local atlas = strmatch(texture, "Atlas:(.+)$")
			if atlas then
				self.Icon:SetAtlas(atlas)
			else
				self.Icon:SetTexture(texture)
			end
		end
		if highlight and type(highlight) == "boolean" then
			self:EnableMouse(true)
			self.HL = self:CreateTexture(nil, "HIGHLIGHT")
			self.HL:SetColorTexture(1, 1, 1, .25)
			self.HL:SetInside()
		end
	end

	function M:AuraIcon(highlight)
		self.CD = CreateFrame("Cooldown", nil, self, "CooldownFrameTemplate")
		self.CD:SetInside()
		self.CD:SetReverse(true)
		M.PixelIcon(self, nil, highlight)
		M.CreateSD(self)
	end

	function M:CreateGear(name)
		local bu = CreateFrame("Button", name, self)
		bu:SetSize(24, 24)
		bu.Icon = bu:CreateTexture(nil, "ARTWORK")
		bu.Icon:SetAllPoints()
		bu.Icon:SetTexture(I.gearTex)
		bu.Icon:SetTexCoord(0, .5, 0, .5)
		bu.Icon:SetVertexColor(1, 0, 0, 1)
		bu:SetHighlightTexture(I.gearTex)
		bu:GetHighlightTexture():SetTexCoord(0, .5, 0, .5)

		return bu
	end

	function M:CreateHelpInfo(tooltip)
		local bu = CreateFrame("Button", nil, self)
		bu:SetSize(40, 40)
		bu.Icon = bu:CreateTexture(nil, "ARTWORK")
		bu.Icon:SetAllPoints()
		bu.Icon:SetTexture(616343)
		bu:SetHighlightTexture(616343)
		if tooltip then
			bu.title = U["Tips"]
			M.AddTooltip(bu, "ANCHOR_BOTTOMLEFT", tooltip, "info")
		end

		return bu
	end

	function M:CreateWatermark()
		local logo = self:CreateTexture(nil, "BACKGROUND")
		logo:SetPoint("BOTTOMRIGHT", 10, 0)
		logo:SetTexture(I.logoTex)
		logo:SetTexCoord(0, 1, 0, .75)
		logo:SetSize(200, 75)
		logo:SetAlpha(.3)
	end

	local AtlasToQuality = {
		["auctionhouse-itemicon-border-gray"] = LE_ITEM_QUALITY_POOR,
		["auctionhouse-itemicon-border-white"] = LE_ITEM_QUALITY_COMMON,
		["auctionhouse-itemicon-border-green"] = LE_ITEM_QUALITY_UNCOMMON,
		["auctionhouse-itemicon-border-blue"] = LE_ITEM_QUALITY_RARE,
		["auctionhouse-itemicon-border-purple"] = LE_ITEM_QUALITY_EPIC,
		["auctionhouse-itemicon-border-orange"] = LE_ITEM_QUALITY_LEGENDARY,
		["auctionhouse-itemicon-border-artifact"] = LE_ITEM_QUALITY_ARTIFACT,
		["auctionhouse-itemicon-border-account"] = LE_ITEM_QUALITY_HEIRLOOM,
	}
	local function updateIconBorderColorByAtlas(self, atlas)
		local quality = AtlasToQuality[atlas]
		local color = I.QualityColors[quality or 1]
		self.__owner.bg:SetBackdropBorderColor(color.r, color.g, color.b)
	end
	local function updateIconBorderColor(self, r, g, b)
		if r == .65882 then r, g, b = 0, 0, 0 end
		self.__owner.bg:SetBackdropBorderColor(r, g, b)
	end
	local function resetIconBorderColor(self)
		self.__owner.bg:SetBackdropBorderColor(0, 0, 0)
	end
	function M:ReskinIconBorder()
		self:SetAlpha(0)
		self.__owner = self:GetParent()
		if not self.__owner.bg then return end
		if self.__owner.useCircularIconBorder then -- for auction item display
			hooksecurefunc(self, "SetAtlas", updateIconBorderColorByAtlas)
		else
			hooksecurefunc(self, "SetVertexColor", updateIconBorderColor)
		end
		hooksecurefunc(self, "Hide", resetIconBorderColor)
	end

	-- Handle statusbar
	function M:CreateSB(spark, r, g, b)
		self:SetStatusBarTexture(I.normTex)
		if r and g and b then
			self:SetStatusBarColor(r, g, b)
		else
			self:SetStatusBarColor(cr, cg, cb)
		end

		local bg = M.SetBD(self)
		self.__shadow = bg.__shadow

		if spark then
			self.Spark = self:CreateTexture(nil, "OVERLAY")
			self.Spark:SetTexture(I.sparkTex)
			self.Spark:SetBlendMode("ADD")
			self.Spark:SetAlpha(.8)
			self.Spark:SetPoint("TOPLEFT", self:GetStatusBarTexture(), "TOPRIGHT", -10, 10)
			self.Spark:SetPoint("BOTTOMRIGHT", self:GetStatusBarTexture(), "BOTTOMRIGHT", 10, -10)
		end
	end

	-- Handle button
	local function Button_OnEnter(self)
		if not self:IsEnabled() then return end

		if MaoRUIPerDB["Skins"]["FlatMode"] then
			self.__gradient:SetVertexColor(cr / 4, cg / 4, cb / 4)
		else
			self.__bg:SetBackdropColor(cr, cg, cb, .25)
		end
		self.__bg:SetBackdropBorderColor(cr, cg, cb)
	end
	local function Button_OnLeave(self)
		if MaoRUIPerDB["Skins"]["FlatMode"] then
			self.__gradient:SetVertexColor(.3, .3, .3, .25)
		else
			self.__bg:SetBackdropColor(0, 0, 0, 0)
		end
		self.__bg:SetBackdropBorderColor(0, 0, 0)
	end

	local blizzRegions = {
		"Left",
		"Middle",
		"Right",
		"Mid",
		"LeftDisabled",
		"MiddleDisabled",
		"RightDisabled",
		"TopLeft",
		"TopRight",
		"BottomLeft",
		"BottomRight",
		"TopMiddle",
		"MiddleLeft",
		"MiddleRight",
		"BottomMiddle",
		"MiddleMiddle",
		"TabSpacer",
		"TabSpacer1",
		"TabSpacer2",
		"_RightSeparator",
		"_LeftSeparator",
		"Cover",
		"Border",
		"Background",
		"TopTex",
		"TopLeftTex",
		"TopRightTex",
		"LeftTex",
		"BottomTex",
		"BottomLeftTex",
		"BottomRightTex",
		"RightTex",
		"MiddleTex",
		"Center",
	}
	function M:Reskin(noHighlight, override)
		if self.SetNormalTexture and not override then self:SetNormalTexture("") end
		if self.SetHighlightTexture then self:SetHighlightTexture("") end
		if self.SetPushedTexture then self:SetPushedTexture("") end
		if self.SetDisabledTexture then self:SetDisabledTexture("") end

		local buttonName = self.GetName and self:GetName()
		for _, region in pairs(blizzRegions) do
			region = buttonName and _G[buttonName..region] or self[region]
			if region then
				region:SetAlpha(0)
			end
		end

		self.__bg = M.CreateBDFrame(self, 0, true)
		self.__bg:SetAllPoints()

		if not noHighlight then
			self:HookScript("OnEnter", Button_OnEnter)
			self:HookScript("OnLeave", Button_OnLeave)
		end
	end

	local function resetTabAnchor(tab)
		local text = tab.Text or _G[tab:GetName().."Text"]
		if text then
			text:SetPoint("CENTER", tab)
		end
	end
	hooksecurefunc("PanelTemplates_DeselectTab", resetTabAnchor)
	hooksecurefunc("PanelTemplates_SelectTab", resetTabAnchor)

	-- Handle scrollframe
	local function Scroll_OnEnter(self)
		local thumb = self.thumb
		if not thumb then return end
		thumb.bg:SetBackdropColor(cr, cg, cb, .25)
		thumb.bg:SetBackdropBorderColor(cr, cg, cb)
	end

	local function Scroll_OnLeave(self)
		local thumb = self.thumb
		if not thumb then return end
		thumb.bg:SetBackdropColor(0, 0, 0, 0)
		thumb.bg:SetBackdropBorderColor(0, 0, 0)
	end

	local function GrabScrollBarElement(frame, element)
		local frameName = frame:GetDebugName()
		return frame[element] or frameName and (_G[frameName..element] or strfind(frameName, element)) or nil
	end

	function M:ReskinScroll()
		M.StripTextures(self:GetParent())
		M.StripTextures(self)

		local thumb = GrabScrollBarElement(self, "ThumbTexture") or GrabScrollBarElement(self, "thumbTexture") or self.GetThumbTexture and self:GetThumbTexture()
		if thumb then
			thumb:SetAlpha(0)
			thumb:SetWidth(16)
			self.thumb = thumb

			local bg = M.CreateBDFrame(self, 0, true)
			bg:SetPoint("TOPLEFT", thumb, 0, -2)
			bg:SetPoint("BOTTOMRIGHT", thumb, 0, 4)
			thumb.bg = bg
		end

		local up, down = self:GetChildren()
		M.ReskinArrow(up, "up")
		M.ReskinArrow(down, "down")

		self:HookScript("OnEnter", Scroll_OnEnter)
		self:HookScript("OnLeave", Scroll_OnLeave)
	end
	-- Handle close button
	function M:Texture_OnEnter()
		if self:IsEnabled() then
			if self.bg then
				self.bg:SetBackdropColor(cr, cg, cb, .25)
			else
				self.__texture:SetVertexColor(cr, cg, cb)
			end
		end
	end

	function M:Texture_OnLeave()
		if self.bg then
			self.bg:SetBackdropColor(0, 0, 0, .25)
		else
			self.__texture:SetVertexColor(1, 1, 1)
		end
	end
	-- Handle arrows
	local arrowDegree = {
		["up"] = 0,
		["down"] = 180,
		["left"] = 90,
		["right"] = -90,
	}
	function M:SetupArrow(direction)
		self:SetTexture(I.ArrowUp)
		self:SetRotation(rad(arrowDegree[direction]))
	end

	function M:ReskinArrow(direction)
		self:SetSize(16, 16)
		--M.Reskin(self, true)

		self:SetDisabledTexture(I.bdTex)
		local dis = self:GetDisabledTexture()
		dis:SetVertexColor(0, 0, 0, .3)
		dis:SetDrawLayer("OVERLAY")
		dis:SetAllPoints()

		local tex = self:CreateTexture(nil, "ARTWORK")
		tex:SetAllPoints()
		M.SetupArrow(tex, direction)
		tex:SetVertexColor(1, 0, 0, 1)
		self.__texture = tex
		self:HookScript("OnEnter", function() if self:IsEnabled() then self.__texture:SetVertexColor(0, 1, 0, 1) end end)
		self:HookScript("OnLeave", function() self.__texture:SetVertexColor(1, 0, 0, 1) end)
	end
end

-- GUI elements
do
	function M:CreateButton(width, height, text, fontSize)
		local bu = CreateFrame("Button", nil, self, "BackdropTemplate")
		bu:SetSize(width, height)
		if type(text) == "boolean" then
			M.PixelIcon(bu, fontSize, true)
		else
			M.Reskin(bu)
			bu.text = M.CreateFS(bu, fontSize or 14, text, true)
		end

		return bu
	end

	function M:CreateCheckBox()
		local cb = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		--M.ReskinCheck(cb)

		cb.Type = "CheckBox"
		return cb
	end

	local function editBoxClearFocus(self)
		self:ClearFocus()
	end

	function M:CreateEditBox(width, height)
		local eb = CreateFrame("EditBox", nil, self)
		eb:SetSize(width, height)
		eb:SetAutoFocus(false)
		eb:SetTextInsets(5, 5, 0, 0)
		eb:SetFont(I.Font[1], I.Font[2]+2, I.Font[3])
		eb.bg = M.CreateBDFrame(eb, .25, true)
		eb:SetScript("OnEscapePressed", editBoxClearFocus)
		eb:SetScript("OnEnterPressed", editBoxClearFocus)

		eb.Type = "EditBox"
		return eb
	end

	local function optOnClick(self)
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
		local opt = self.__owner.options
		for i = 1, #opt do
			if self == opt[i] then
				opt[i]:SetBackdropColor(1, .8, 0, .3)
				opt[i].selected = true
			else
				opt[i]:SetBackdropColor(0, 0, 0, .3)
				opt[i].selected = false
			end
		end
		self.__owner.Text:SetText(self.text)
		self:GetParent():Hide()
	end

	local function optOnEnter(self)
		if self.selected then return end
		self:SetBackdropColor(1, 1, 1, .25)
	end

	local function optOnLeave(self)
		if self.selected then return end
		self:SetBackdropColor(0, 0, 0)
	end

	local function buttonOnShow(self)
		self.__list:Hide()
	end

	local function buttonOnClick(self)
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
		M:TogglePanel(self.__list)
	end

	function M:CreateDropDown(width, height, data)
		local dd = CreateFrame("Frame", nil, self, "BackdropTemplate")
		dd:SetSize(width, height)
		M.CreateBD(dd)
		dd:SetBackdropBorderColor(1, 1, 1, .2)
		dd.Text = M.CreateFS(dd, 14, "", false, "LEFT", 5, 0)
		dd.Text:SetPoint("RIGHT", -5, 0)
		dd.options = {}

		local bu = CreateFrame("Button", nil, dd)
		bu:SetPoint("RIGHT", 12, 5)
		M.ReskinArrow(bu, "down")
		bu:SetSize(26, 26)
		local list = CreateFrame("Frame", nil, dd, "BackdropTemplate")
		list:SetPoint("TOP", dd, "BOTTOM", 0, -2)
		M.CreateBD(list, 0.85)
		list:SetBackdropBorderColor(1, 1, 1, .85)
		list:Hide()
		bu.__list = list
		bu:SetScript("OnShow", buttonOnShow)
		bu:SetScript("OnClick", buttonOnClick)
		dd.button = bu

		local opt, index = {}, 0
		for i, j in pairs(data) do
			opt[i] = CreateFrame("Button", nil, list, "BackdropTemplate")
			opt[i]:SetPoint("TOPLEFT", 4, -4 - (i-1)*(height+2))
			opt[i]:SetSize(width - 8, height)
			M.CreateBD(opt[i])
			local text = M.CreateFS(opt[i], 14, j, false, "LEFT", 5, 0)
			text:SetPoint("RIGHT", -5, 0)
			opt[i].text = j
			opt[i].__owner = dd
			opt[i]:SetScript("OnClick", optOnClick)
			opt[i]:SetScript("OnEnter", optOnEnter)
			opt[i]:SetScript("OnLeave", optOnLeave)

			dd.options[i] = opt[i]
			index = index + 1
		end
		list:SetSize(width, index*(height+2) + 6)

		dd.Type = "DropDown"
		return dd
	end

	local function updatePicker()
		local swatch = ColorPickerFrame.__swatch
		local r, g, b = ColorPickerFrame:GetColorRGB()
		swatch.tex:SetVertexColor(r, g, b)
		swatch.color.r, swatch.color.g, swatch.color.b = r, g, b
	end

	local function cancelPicker()
		local swatch = ColorPickerFrame.__swatch
		local r, g, b = ColorPicker_GetPreviousValues()
		swatch.tex:SetVertexColor(r, g, b)
		swatch.color.r, swatch.color.g, swatch.color.b = r, g, b
	end

	local function openColorPicker(self)
		local r, g, b = self.color.r, self.color.g, self.color.b
		ColorPickerFrame.__swatch = self
		ColorPickerFrame.func = updatePicker
		ColorPickerFrame.previousValues = {r = r, g = g, b = b}
		ColorPickerFrame.cancelFunc = cancelPicker
		ColorPickerFrame:SetColorRGB(r, g, b)
		ColorPickerFrame:Show()
	end

	function M:CreateColorSwatch(name, color)
		color = color or {r=1, g=1, b=1}

		local swatch = CreateFrame("Button", nil, self, "BackdropTemplate")
		swatch:SetSize(18, 18)
		M.CreateBD(swatch, 1)
		swatch.text = M.CreateFS(swatch, 14, name, false, "LEFT", 26, 0)
		local tex = swatch:CreateTexture()
		tex:SetInside()
		tex:SetTexture(I.bdTex)
		tex:SetVertexColor(color.r, color.g, color.b)

		swatch.tex = tex
		swatch.color = color
		swatch:SetScript("OnClick", openColorPicker)

		return swatch
	end

	local function updateSliderEditBox(self)
		local slider = self.__owner
		local minValue, maxValue = slider:GetMinMaxValues()
		local text = tonumber(self:GetText())
		if not text then return end
		text = min(maxValue, text)
		text = max(minValue, text)
		slider:SetValue(text)
		self:SetText(text)
		self:ClearFocus()
	end

	local function resetSliderValue(self)
		local slider = self.__owner
		if slider.__default then
			slider:SetValue(slider.__default)
		end
	end

	function M:CreateSlider(name, minValue, maxValue, step, x, y, width)
		local slider = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		slider:SetPoint("TOPLEFT", x, y)
		slider:SetWidth(width or 200)
		slider:SetMinMaxValues(minValue, maxValue)
		slider:SetValueStep(step)
		slider:SetObeyStepOnDrag(true)
		slider:SetHitRectInsets(0, 0, 0, 0)
		--M.ReskinSlider(slider)

		slider.Low:SetText(minValue)
		slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 10, -2)
		slider.High:SetText(maxValue)
		slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -10, -2)
		slider.Text:ClearAllPoints()
		slider.Text:SetPoint("CENTER", 0, 25)
		slider.Text:SetText(name)
		slider.Text:SetTextColor(1, .8, 0)
		slider.value = M.CreateEditBox(slider, 50, 20)
		slider.value:SetPoint("TOP", slider, "BOTTOM")
		slider.value:SetJustifyH("CENTER")
		slider.value.__owner = slider
		slider.value:SetScript("OnEnterPressed", updateSliderEditBox)

		slider.clicker = CreateFrame("Button", nil, slider)
		slider.clicker:SetAllPoints(slider.Text)
		slider.clicker.__owner = slider
		slider.clicker:SetScript("OnDoubleClick", resetSliderValue)

		return slider
	end

	function M:TogglePanel(frame)
		if frame:IsShown() then
			frame:Hide()
		else
			frame:Show()
		end
	end
end

-- Add API
do
	local function WatchPixelSnap(frame, snap)
		if (frame and not frame:IsForbidden()) and frame.PixelSnapDisabled and snap then
			frame.PixelSnapDisabled = nil
		end
	end

	local function DisablePixelSnap(frame)
		if (frame and not frame:IsForbidden()) and not frame.PixelSnapDisabled then
			if frame.SetSnapToPixelGrid then
				frame:SetSnapToPixelGrid(false)
				frame:SetTexelSnappingBias(0)
			elseif frame.GetStatusBarTexture then
				local texture = frame:GetStatusBarTexture()
				if texture and texture.SetSnapToPixelGrid then
					texture:SetSnapToPixelGrid(false)
					texture:SetTexelSnappingBias(0)
				end
			end

			frame.PixelSnapDisabled = true
		end
	end

	local function SetInside(frame, anchor, xOffset, yOffset, anchor2)
		xOffset = xOffset or R.mult
		yOffset = yOffset or R.mult
		anchor = anchor or frame:GetParent()

		DisablePixelSnap(frame)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
		frame:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", -xOffset, yOffset)
	end

	local function SetOutside(frame, anchor, xOffset, yOffset, anchor2)
		xOffset = xOffset or R.mult
		yOffset = yOffset or R.mult
		anchor = anchor or frame:GetParent()

		DisablePixelSnap(frame)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
		frame:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", xOffset, -yOffset)
	end

	local function addapi(object)
		local mt = getmetatable(object).__index
		if not object.SetInside then mt.SetInside = SetInside end
		if not object.SetOutside then mt.SetOutside = SetOutside end
		if not object.DisabledPixelSnap then
			if mt.SetTexture then hooksecurefunc(mt, "SetTexture", DisablePixelSnap) end
			if mt.SetTexCoord then hooksecurefunc(mt, "SetTexCoord", DisablePixelSnap) end
			if mt.CreateTexture then hooksecurefunc(mt, "CreateTexture", DisablePixelSnap) end
			if mt.SetVertexColor then hooksecurefunc(mt, "SetVertexColor", DisablePixelSnap) end
			if mt.SetColorTexture then hooksecurefunc(mt, "SetColorTexture", DisablePixelSnap) end
			if mt.SetSnapToPixelGrid then hooksecurefunc(mt, "SetSnapToPixelGrid", WatchPixelSnap) end
			if mt.SetStatusBarTexture then hooksecurefunc(mt, "SetStatusBarTexture", DisablePixelSnap) end
			mt.DisabledPixelSnap = true
		end
	end

	local handled = {["Frame"] = true}
	local object = CreateFrame("Frame")
	addapi(object)
	addapi(object:CreateTexture())
	addapi(object:CreateMaskTexture())

	object = EnumerateFrames()
	while object do
		if not object:IsForbidden() and not handled[object:GetObjectType()] then
			addapi(object)
			handled[object:GetObjectType()] = true
		end

		object = EnumerateFrames(object)
	end
end

	-- Function --
function M:CreatStyleButton(id, parent, w, h, ap, frame, rp, x, y, l, alpha, bgF, r, g, b)
  local StyleButton = CreateFrame("Button", id, parent, "BackdropTemplate")
	StyleButton:SetWidth(w)
	StyleButton:SetHeight(h)
	StyleButton:SetPoint(ap, frame, rp, x, y)
	StyleButton:SetFrameStrata("HIGH")
	StyleButton:SetFrameLevel(l)
	StyleButton:SetAlpha(alpha)
	StyleButton:SetBackdrop({bgFile = bgF})
	StyleButton:SetBackdropColor(r, g, b)
	return StyleButton
end
function M:CreatStyleText(f, font, fontsize, fontmod, text, ap, frame, rp, x, y, r, g, b, k)
	local StyleText = f:CreateFontString(nil, "OVERLAY")
	StyleText:SetFont(font, fontsize, fontmod)
	StyleText:SetJustifyH("CENTER")
	StyleText:SetText(text)
	StyleText:SetPoint(ap, frame, rp, x, y)
	StyleText:SetTextColor(r, g, b, k or 1)
	return StyleText
end
-- Function end --