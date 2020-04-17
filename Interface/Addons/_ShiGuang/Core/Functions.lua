local _, ns = ...
local M, R, U, I = unpack(ns)
local cr, cg, cb = I.r, I.g, I.b

local type, pairs, tonumber, wipe, next = type, pairs, tonumber, table.wipe, next
local strmatch, gmatch, strfind, format, gsub = string.match, string.gmatch, string.find, string.format, string.gsub
local min, max, floor = math.min, math.max, math.floor

function sendCmd(cmd) ChatFrame1EditBox:SetText(""); ChatFrame1EditBox:Insert(cmd); ChatEdit_SendText(ChatFrame1EditBox); end
function M:Scale(x)
	local mult = R.mult
	return mult * floor(x / mult + .5)
end

-- Gradient Frame
function M:CreateGF(w, h, o, r, g, b, a1, a2)
	self:SetSize(w, h)
	self:SetFrameStrata("BACKGROUND")
	local gf = self:CreateTexture(nil, "BACKGROUND")
	gf:SetAllPoints()
	gf:SetTexture(I.normTex)
	gf:SetGradientAlpha(o, r, g, b, a1, r, g, b, a2)
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

-- Create Shadow
function M:CreateSD(size, override)
	if not override and not MaoRUIPerDB["Skins"]["Shadow"] then return end

	if self.Shadow then return end

	local frame = self
	if self:GetObjectType() == "Texture" then frame = self:GetParent() end

	self.Shadow = CreateFrame("Frame", nil, frame)
	self.Shadow:SetOutside(self, size or 4, size or 4)
	self.Shadow:SetBackdrop({edgeFile = I.glowTex, edgeSize = M:Scale(size or 5)})
	self.Shadow:SetBackdropBorderColor(0, 0, 0, size and 1 or .4)
	self.Shadow:SetFrameLevel(1)

	return self.Shadow
end

-- ls, Azil, and Simpy made this to replace Blizzard's SetBackdrop API while the textures can't snap
local PIXEL_BORDERS = {"TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "TOP", "BOTTOM", "LEFT", "RIGHT"}

function M:SetBackdrop(frame, a)
	local borders = frame.pixelBorders
	if not borders then return end

	local size = R.mult

	borders.CENTER:SetPoint("TOPLEFT", frame)
	borders.CENTER:SetPoint("BOTTOMRIGHT", frame)

	borders.TOPLEFT:SetSize(size, size)
	borders.TOPRIGHT:SetSize(size, size)
	borders.BOTTOMLEFT:SetSize(size, size)
	borders.BOTTOMRIGHT:SetSize(size, size)

	borders.TOP:SetHeight(size)
	borders.BOTTOM:SetHeight(size)
	borders.LEFT:SetWidth(size)
	borders.RIGHT:SetWidth(size)

	M:SetBackdropColor(frame, 0, 0, 0, a)
	M:SetBackdropBorderColor(frame, 0, 0, 0)
end

function M:SetBackdropColor(frame, r, g, b, a)
	if frame.pixelBorders then
		frame.pixelBorders.CENTER:SetVertexColor(r, g, b, a)
	end
end

function M:SetBackdropBorderColor(frame, r, g, b, a)
	if frame.pixelBorders then
		for _, v in pairs(PIXEL_BORDERS) do
			frame.pixelBorders[v]:SetVertexColor(r or 0, g or 0, b or 0, a)
		end
	end
end

function M:SetBackdropColor_Hook(r, g, b, a)
	M:SetBackdropColor(self, r, g, b, a)
end

function M:SetBackdropBorderColor_Hook(r, g, b, a)
	M:SetBackdropBorderColor(self, r, g, b, a)
end

function M:PixelBorders(frame)
	if frame and not frame.pixelBorders then
		local borders = {}
		for _, v in pairs(PIXEL_BORDERS) do
			borders[v] = frame:CreateTexture(nil, "BORDER", nil, 1)
			borders[v]:SetTexture(I.bdTex)
		end

		borders.CENTER = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
		borders.CENTER:SetTexture(I.bdTex)

		borders.TOPLEFT:Point("BOTTOMRIGHT", borders.CENTER, "TOPLEFT", R.mult, -R.mult)
		borders.TOPRIGHT:Point("BOTTOMLEFT", borders.CENTER, "TOPRIGHT", -R.mult, -R.mult)
		borders.BOTTOMLEFT:Point("TOPRIGHT", borders.CENTER, "BOTTOMLEFT", R.mult, R.mult)
		borders.BOTTOMRIGHT:Point("TOPLEFT", borders.CENTER, "BOTTOMRIGHT", -R.mult, R.mult)

		borders.TOP:Point("TOPLEFT", borders.TOPLEFT, "TOPRIGHT", 0, 0)
		borders.TOP:Point("TOPRIGHT", borders.TOPRIGHT, "TOPLEFT", 0, 0)

		borders.BOTTOM:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "BOTTOMRIGHT", 0, 0)
		borders.BOTTOM:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0)

		borders.LEFT:Point("TOPLEFT", borders.TOPLEFT, "BOTTOMLEFT", 0, 0)
		borders.LEFT:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "TOPLEFT", 0, 0)

		borders.RIGHT:Point("TOPRIGHT", borders.TOPRIGHT, "BOTTOMRIGHT", 0, 0)
		borders.RIGHT:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "TOPRIGHT", 0, 0)

		hooksecurefunc(frame, "SetBackdropColor", M.SetBackdropColor_Hook)
		hooksecurefunc(frame, "SetBackdropBorderColor", M.SetBackdropBorderColor_Hook)

		frame.pixelBorders = borders
	end
end

-- Create Backdrop
R.frames = {}
function M:CreateBD(a)
	self:SetBackdrop(nil)
	M:PixelBorders(self)
	M:SetBackdrop(self, a or MaoRUIPerDB["Skins"]["SkinAlpha"])
	if not a then tinsert(R.frames, self) end
end

function M:CreateGradient()
	local tex = self:CreateTexture(nil, "BORDER")
	tex:SetInside(self)
	tex:SetTexture(I.bdTex)
	if MaoRUIPerDB["Skins"]["FlatMode"] then
		tex:SetVertexColor(.3, .3, .3, .25)
	else
		tex:SetGradientAlpha("Vertical", 0, 0, 0, .5, .3, .3, .3, .3)
	end

	return tex
end

-- Create Background
function M:CreateBDFrame(a, shadow)
	local frame = self
	if self:GetObjectType() == "Texture" then frame = self:GetParent() end
	local lvl = frame:GetFrameLevel()

	local bg = CreateFrame("Frame", nil, frame)
	bg:SetOutside(self)
	bg:SetFrameLevel(lvl == 0 and 0 or lvl - 1)
	M.CreateBD(bg, a)
	if shadow then M.CreateSD(bg) end
	return bg
end

function M:SetBD(x, y, x2, y2)
	local bg = M.CreateBDFrame(self, nil, true)
	if x then
		bg:SetPoint("TOPLEFT", self, x, y)
		bg:SetPoint("BOTTOMRIGHT", self, x2, y2)
	end
	M.CreateTex(bg)

	return bg
end

-- Frame Text
function M:CreateFS(size, text, classcolor, anchor, x, y, r, g, b)
	local fs = self:CreateFontString(nil, "OVERLAY")
	fs:SetFont(I.Font[1], size, I.Font[3])
	fs:SetText(text)
	fs:SetWordWrap(false)
	if classcolor and type(classcolor) == "boolean" then
		fs:SetTextColor(cr, cg, cb)
	elseif classcolor == "system" then
		fs:SetTextColor(1, .8, 0)
	elseif classcolor == "Chatbar" then
		fs:SetTextColor(r, g, b)
	end
	if anchor and x and y then
		fs:SetPoint(anchor, x, y)
	else
		fs:SetPoint("CENTER", 1, 0)
	end
	return fs
end

-- GameTooltip
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

-- Icon Style
function M:ReskinIcon(shadow)
	self:SetTexCoord(unpack(I.TexCoord))
	return M.CreateBDFrame(self, nil, shadow)
end

function M:PixelIcon(texture, highlight)
	M.CreateBD(self)
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
	self.CD:SetAllPoints()
	self.CD:SetReverse(true)
	M.PixelIcon(self, nil, highlight)
	M.CreateSD(self)
end

function M:CreateGear(name)
	local bu = CreateFrame("Button", name, self)
	bu:SetSize(21, 21)
	bu.Icon = bu:CreateTexture(nil, "ARTWORK")
	bu.Icon:SetAllPoints()
	bu.Icon:SetTexture(I.gearTex)
	bu.Icon:SetTexCoord(0, .5, 0, .5)
	bu.Icon:SetVertexColor(1, 0, 0, 1)
	bu:SetHighlightTexture(I.gearTex)
	bu:GetHighlightTexture():SetTexCoord(0, .5, 0, .5)
	return bu
end

-- Statusbar
function M:CreateSB(spark, r, g, b)
	self:SetStatusBarTexture(I.normTex)
	if r and g and b then
		self:SetStatusBarColor(r, g, b)
	else
		self:SetStatusBarColor(cr, cg, cb)
	end

	local bg = M.SetBD(self)
	self.Shadow = bg.Shadow

	if spark then
		self.Spark = self:CreateTexture(nil, "OVERLAY")
		self.Spark:SetTexture(I.sparkTex)
		self.Spark:SetBlendMode("ADD")
		self.Spark:SetAlpha(.8)
		self.Spark:SetPoint("TOPLEFT", self:GetStatusBarTexture(), "TOPRIGHT", -10, 10)
		self.Spark:SetPoint("BOTTOMRIGHT", self:GetStatusBarTexture(), "BOTTOMRIGHT", 10, -10)
	end
end


-- Reskin ui widgets
local function Button_OnEnter(self)
	if not self:IsEnabled() then return end

	if MaoRUIPerDB["Skins"]["FlatMode"] then
		self.bgTex:SetVertexColor(cr / 4, cg / 4, cb / 4)
	else
		self:SetBackdropColor(cr, cg, cb, .25)
	end
	self:SetBackdropBorderColor(cr, cg, cb)
end

local function Button_OnLeave(self)
	if MaoRUIPerDB["Skins"]["FlatMode"] then
		self.bgTex:SetVertexColor(.3, .3, .3, .25)
	else
		self:SetBackdropColor(0, 0, 0, 0)
	end
	self:SetBackdropBorderColor(0, 0, 0)
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
}
function M:Reskin(noHighlight)
	if self.SetNormalTexture then self:SetNormalTexture("") end
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

	M.CreateBD(self, 0)

	self.bgTex = M.CreateGradient(self)

	if not noHighlight then
		self:HookScript("OnEnter", Button_OnEnter)
 		self:HookScript("OnLeave", Button_OnLeave)
	end
end

local function Menu_OnEnter(self)
	self.bg:SetBackdropBorderColor(cr, cg, cb)
end
local function Menu_OnLeave(self)
	self.bg:SetBackdropBorderColor(0, 0, 0)
end
local function Menu_OnMouseUp(self)
	self.bg:SetBackdropColor(0, 0, 0, MaoRUIPerDB["Skins"]["SkinAlpha"])
end
local function Menu_OnMouseDown(self)
	self.bg:SetBackdropColor(cr, cg, cb, .25)
end
function M:ReskinMenuButton()
	M.StripTextures(self)
	self.bg = M.SetBD(self)
	self:SetScript("OnEnter", Menu_OnEnter)
	self:SetScript("OnLeave", Menu_OnLeave)
	self:HookScript("OnMouseUp", Menu_OnMouseUp)
	self:HookScript("OnMouseDown", Menu_OnMouseDown)
end
function M:Texture_OnEnter()
	if self:IsEnabled() then
		if self.pixels then
			for _, pixel in pairs(self.pixels) do
				pixel:SetVertexColor(cr, cg, cb)
			end
		elseif self.bg then
			self.bg:SetBackdropColor(cr, cg, cb, .25)
		else
			self.bgTex:SetVertexColor(cr, cg, cb)
		end
	end
end

function M:Texture_OnLeave()
	if self.pixels then
		for _, pixel in pairs(self.pixels) do
			pixel:SetVertexColor(1, 1, 1)
		end
	elseif self.bg then
		self.bg:SetBackdropColor(0, 0, 0, .25)
	else
		self.bgTex:SetVertexColor(1, 1, 1)
	end
end

-- Arrows
local direcIndex = {
	["up"] = I.arrowUp,
	["down"] = I.arrowDown,
	["left"] = I.arrowLeft,
	["right"] = I.arrowRight,
}
function M:ReskinArrow(direction)
	self:SetSize(17, 17)
	M.Reskin(self, true)

	self:SetDisabledTexture(I.bdTex)
	local dis = self:GetDisabledTexture()
	dis:SetVertexColor(0, 0, 0, .3)
	dis:SetDrawLayer("OVERLAY")
	dis:SetAllPoints()

	local tex = self:CreateTexture(nil, "ARTWORK")
	tex:SetTexture(direcIndex[direction])
	tex:SetSize(8, 8)
	tex:SetPoint("CENTER")
	self.bgTex = tex

	self:HookScript("OnEnter", M.Texture_OnEnter)
	self:HookScript("OnLeave", M.Texture_OnLeave)
end

-- Checkbox
function M:ReskinCheck(forceSaturation)
	self:SetNormalTexture("")
	self:SetPushedTexture("")
	self:SetHighlightTexture(I.bdTex)
	local hl = self:GetHighlightTexture()
	hl:SetPoint("TOPLEFT", 5, -5)
	hl:SetPoint("BOTTOMRIGHT", -5, 5)
	hl:SetVertexColor(cr, cg, cb, .25)

	local bg = M.CreateBDFrame(self, 0)
	bg:SetPoint("TOPLEFT", 4, -4)
	bg:SetPoint("BOTTOMRIGHT", -4, 4)
	M.CreateGradient(bg)

	local ch = self:GetCheckedTexture()
	ch:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	ch:SetTexCoord(0, 1, 0, 1)
	ch:SetDesaturated(true)
	ch:SetVertexColor(cr, cg, cb)

	self.forceSaturation = forceSaturation
end

hooksecurefunc("TriStateCheckbox_SetState", function(_, checkButton)
	if checkButton.forceSaturation then
		local tex = checkButton:GetCheckedTexture()
		if checkButton.state == 2 then
			tex:SetDesaturated(true)
			tex:SetVertexColor(cr, cg, cb)
		elseif checkButton.state == 1 then
			tex:SetVertexColor(1, .8, 0, .8)
		end
	end
end)

function M:ReskinRadio()
	self:SetNormalTexture("")
	self:SetHighlightTexture("")
	self:SetCheckedTexture(I.bdTex)

	local ch = self:GetCheckedTexture()
	ch:SetPoint("TOPLEFT", 4, -4)
	ch:SetPoint("BOTTOMRIGHT", -4, 4)
	ch:SetVertexColor(cr, cg, cb, .6)

	local bg = M.CreateBDFrame(self, 0)
	bg:SetPoint("TOPLEFT", 3, -3)
	bg:SetPoint("BOTTOMRIGHT", -3, 3)
	M.CreateGradient(bg)
	self.bg = bg

	self:HookScript("OnEnter", Menu_OnEnter)
	self:HookScript("OnLeave", Menu_OnLeave)
end
-- Slider
function M:ReskinSlider(verticle)
	self:SetBackdrop(nil)
	M.StripTextures(self)

	local bg = M.CreateBDFrame(self, 0)
	bg:SetPoint("TOPLEFT", 14, -2)
	bg:SetPoint("BOTTOMRIGHT", -15, 3)
	M.CreateGradient(bg)

	local thumb = self:GetThumbTexture()
	thumb:SetTexture(I.sparkTex)
	thumb:SetBlendMode("ADD")
	if verticle then thumb:SetRotation(math.rad(90)) end
end

function M:CreateGlowFrame(size)
	local frame = CreateFrame("Frame", nil, self)
	frame:SetPoint("CENTER")
	frame:SetSize(size+8, size+8)

	return frame
end

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

-- Color code
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

-- Disable function
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

function M:Dummy()
	return
end

function M:HideOption()
	self:SetAlpha(0)
	self:SetScale(.0001)
end

-- Timer Format
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

-- Itemlevel
local iLvlDB = {}
local itemLevelString = gsub(ITEM_LEVEL, "%%d", "")
local enchantString = gsub(ENCHANTED_TOOLTIP_LINE, "%%s", "(.+)")
local essenceTextureID = 2975691
local essenceDescription = GetSpellDescription(277253)
local ITEM_SPELL_TRIGGER_ONEQUIP = ITEM_SPELL_TRIGGER_ONEQUIP
local RETRIEVING_ITEM_INFO = RETRIEVING_ITEM_INFO
local tip = CreateFrame("GameTooltip", "NDui_iLvlTooltip", nil, "GameTooltipTemplate")

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

		local firstLine = _G.NDui_iLvlTooltipTextLeft1:GetText()
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

-- GUID to npcID
function M.GetNPCID(guid)
	local id = tonumber(strmatch((guid or ""), "%-(%d-)%-%x-$"))
	return id
end

-- Add APIs
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

local function Point(frame, arg1, arg2, arg3, arg4, arg5, ...)
	if arg2 == nil then arg2 = frame:GetParent() end

	if type(arg2) == "number" then arg2 = M:Scale(arg2) end
	if type(arg3) == "number" then arg3 = M:Scale(arg3) end
	if type(arg4) == "number" then arg4 = M:Scale(arg4) end
	if type(arg5) == "number" then arg5 = M:Scale(arg5) end

	frame:SetPoint(arg1, arg2, arg3, arg4, arg5, ...)
end

local function SetInside(frame, anchor, xOffset, yOffset, anchor2)
	xOffset = xOffset or R.mult
	yOffset = yOffset or R.mult
	anchor = anchor or frame:GetParent()

	DisablePixelSnap(frame)
	frame:ClearAllPoints()
	frame:Point("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	frame:Point("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

local function SetOutside(frame, anchor, xOffset, yOffset, anchor2)
	xOffset = xOffset or R.mult
	yOffset = yOffset or R.mult
	anchor = anchor or frame:GetParent()

	DisablePixelSnap(frame)
	frame:ClearAllPoints()
	frame:Point("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	frame:Point("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Point then mt.Point = Point end
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

-- GUI APIs
function M:CreateButton(width, height, text, fontSize)
	local bu = CreateFrame("Button", nil, self)
	bu:SetSize(width, height)
	if type(text) == "boolean" then
		M.PixelIcon(bu, fontSize, true)
		M.CreateBD(bu, .3)
	else
		M.Reskin(bu)
		bu.text = M.CreateFS(bu, fontSize or 14, text, true)
	end

	return bu
end

function M:CreateCheckBox()
	local cb = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	M.ReskinCheck(cb)

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
	M.CreateBD(eb, .3)
	M.CreateGradient(eb)
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
	local dd = CreateFrame("Frame", nil, self)
	dd:SetSize(width, height)
	M.CreateBD(dd)
	dd:SetBackdropBorderColor(1, 1, 1, .2)
	dd.Text = M.CreateFS(dd, 14, "", false, "LEFT", 5, 0)
	dd.Text:SetPoint("RIGHT", -5, 0)
	dd.options = {}

	local bu = CreateFrame("Button", dd, self)
	bu:SetSize(26, 26)
	bu.Icon = bu:CreateTexture(nil, "ARTWORK")
	bu.Icon:SetAllPoints()
	bu.Icon:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\Raid\\ArrowLarge")
	bu.Icon:SetVertexColor(1, 0, 0, 1)
	bu:SetHighlightTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\Raid\\ArrowLarge")
	bu:GetHighlightTexture():SetVertexColor(0, 1, 0, 1)
	bu:SetPoint("LEFT", dd, "RIGHT", -8, 3)
	local list = CreateFrame("Frame", nil, dd)
	list:SetPoint("TOP", dd, "BOTTOM", 0, -2)
	M.CreateBD(list, 1)
	list:SetBackdropBorderColor(1, 1, 1, .2)
	list:Hide()
	bu.__list = list
	bu:SetScript("OnShow", buttonOnShow)
	bu:SetScript("OnClick", buttonOnClick)
	dd.button = bu

	local opt, index = {}, 0
	for i, j in pairs(data) do
		opt[i] = CreateFrame("Button", nil, list)
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

	local swatch = CreateFrame("Button", nil, self)
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

function M:CreateSlider(name, minValue, maxValue, x, y, width)
	local slider = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
	slider:SetPoint("TOPLEFT", x, y)
	slider:SetWidth(width or 200)
	slider:SetMinMaxValues(minValue, maxValue)
	slider:SetHitRectInsets(0, 0, 0, 0)
	M.ReskinSlider(slider)

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

	return slider
end

function M:TogglePanel(frame)
	if frame:IsShown() then
		frame:Hide()
	else
		frame:Show()
	end
end

	-- Function --
function M:CreatStyleButton(id, parent, w, h, ap, frame, rp, x, y, l, alpha, bgF, r, g, b)
  local StyleButton = CreateFrame("Button", id, parent, "SecureActionButtonTemplate")
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