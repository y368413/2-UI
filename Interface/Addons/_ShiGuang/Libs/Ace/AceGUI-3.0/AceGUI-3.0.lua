local ACEGUI_MAJOR, ACEGUI_MINOR = "AceGUI-3.0", 41
local AceGUI, oldminor = LibStub:NewLibrary(ACEGUI_MAJOR, ACEGUI_MINOR)

if not AceGUI then return end -- No upgrade needed

-- Lua APIs
local tinsert = table.insert
local select, pairs, next, type = select, pairs, next, type
local error, assert = error, assert
local setmetatable, rawget = setmetatable, rawget
local math_max = math.max

-- WoW APIs
local UIParent = UIParent

AceGUI.WidgetRegistry = AceGUI.WidgetRegistry or {}
AceGUI.LayoutRegistry = AceGUI.LayoutRegistry or {}
AceGUI.WidgetBase = AceGUI.WidgetBase or {}
AceGUI.WidgetContainerBase = AceGUI.WidgetContainerBase or {}
AceGUI.WidgetVersions = AceGUI.WidgetVersions or {}
AceGUI.tooltip = AceGUI.tooltip or CreateFrame("GameTooltip", "AceGUITooltip", UIParent, "GameTooltipTemplate")

-- local upvalues
local WidgetRegistry = AceGUI.WidgetRegistry
local LayoutRegistry = AceGUI.LayoutRegistry
local WidgetVersions = AceGUI.WidgetVersions

local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function safecall(func, ...)
	if func then
		return xpcall(func, errorhandler, ...)
	end
end

-- Recycling functions
local newWidget, delWidget
do
	if oldminor and oldminor < 29 and AceGUI.objPools then
		AceGUI.objPools = nil
	end
	
	AceGUI.objPools = AceGUI.objPools or {}
	local objPools = AceGUI.objPools
	--Returns a new instance, if none are available either returns a new table or calls the given contructor
	function newWidget(type)
		if not WidgetRegistry[type] then
			error("Attempt to instantiate unknown widget type", 2)
		end
		
		if not objPools[type] then
			objPools[type] = {}
		end
		
		local newObj = next(objPools[type])
		if not newObj then
			newObj = WidgetRegistry[type]()
			newObj.AceGUIWidgetVersion = WidgetVersions[type]
		else
			objPools[type][newObj] = nil

			if not newObj.AceGUIWidgetVersion or newObj.AceGUIWidgetVersion < WidgetVersions[type] then
				return newWidget(type)
			end
		end
		return newObj
	end
	-- Releases an instance to the Pool
	function delWidget(obj,type)
		if not objPools[type] then
			objPools[type] = {}
		end
		if objPools[type][obj] then
			error("Attempt to Release Widget that is already released", 2)
		end
		objPools[type][obj] = true
	end
end

function AceGUI:Create(type)
	if WidgetRegistry[type] then
		local widget = newWidget(type)

		if rawget(widget, "Acquire") then
			widget.OnAcquire = widget.Acquire
			widget.Acquire = nil
		elseif rawget(widget, "Aquire") then
			widget.OnAcquire = widget.Aquire
			widget.Aquire = nil
		end
		
		if rawget(widget, "Release") then
			widget.OnRelease = rawget(widget, "Release") 
			widget.Release = nil
		end
		
		if widget.OnAcquire then
			widget:OnAcquire()
		else
			error(("Widget type %s doesn't supply an OnAcquire Function"):format(type))
		end
		-- Set the default Layout ("List")
		safecall(widget.SetLayout, widget, "List")
		safecall(widget.ResumeLayout, widget)
		return widget
	end
end

function AceGUI:Release(widget)
	if widget.isQueuedForRelease then return end
	widget.isQueuedForRelease = true
	safecall(widget.PauseLayout, widget)
	widget.frame:Hide()
	widget:Fire("OnRelease")
	safecall(widget.ReleaseChildren, widget)

	if widget.OnRelease then
		widget:OnRelease()
	end
	for k in pairs(widget.userdata) do
		widget.userdata[k] = nil
	end
	for k in pairs(widget.events) do
		widget.events[k] = nil
	end
	widget.width = nil
	widget.relWidth = nil
	widget.height = nil
	widget.relHeight = nil
	widget.noAutoHeight = nil
	widget.frame:ClearAllPoints()
	widget.frame:Hide()
	widget.frame:SetParent(UIParent)
	widget.frame.width = nil
	widget.frame.height = nil
	if widget.content then
		widget.content.width = nil
		widget.content.height = nil
	end
	widget.isQueuedForRelease = nil
	delWidget(widget, widget.type)
end

function AceGUI:IsReleasing(widget)
	if widget.isQueuedForRelease then
		return true
	end

	if widget.parent and widget.parent.AceGUIWidgetVersion then
		return AceGUI:IsReleasing(widget.parent)
	end

	return false
end

-----------
-- Focus --
-----------


function AceGUI:SetFocus(widget)
	if self.FocusedWidget and self.FocusedWidget ~= widget then
		safecall(self.FocusedWidget.ClearFocus, self.FocusedWidget)
	end
	self.FocusedWidget = widget
end

function AceGUI:ClearFocus()
	if self.FocusedWidget then
		safecall(self.FocusedWidget.ClearFocus, self.FocusedWidget)
		self.FocusedWidget = nil
	end
end

do
	local WidgetBase = AceGUI.WidgetBase 
	
	WidgetBase.SetParent = function(self, parent)
		local frame = self.frame
		frame:SetParent(nil)
		frame:SetParent(parent.content)
		self.parent = parent
	end
	
	WidgetBase.SetCallback = function(self, name, func)
		if type(func) == "function" then
			self.events[name] = func
		end
	end
	
	WidgetBase.Fire = function(self, name, ...)
		if self.events[name] then
			local success, ret = safecall(self.events[name], self, name, ...)
			if success then
				return ret
			end
		end
	end
	
	WidgetBase.SetWidth = function(self, width)
		self.frame:SetWidth(width)
		self.frame.width = width
		if self.OnWidthSet then
			self:OnWidthSet(width)
		end
	end
	
	WidgetBase.SetRelativeWidth = function(self, width)
		if width <= 0 or width > 1 then
			error(":SetRelativeWidth(width): Invalid relative width.", 2)
		end
		self.relWidth = width
		self.width = "relative"
	end
	
	WidgetBase.SetHeight = function(self, height)
		self.frame:SetHeight(height)
		self.frame.height = height
		if self.OnHeightSet then
			self:OnHeightSet(height)
		end
	end

	WidgetBase.IsVisible = function(self)
		return self.frame:IsVisible()
	end
	
	WidgetBase.IsShown= function(self)
		return self.frame:IsShown()
	end
		
	WidgetBase.Release = function(self)
		AceGUI:Release(self)
	end

	WidgetBase.IsReleasing = function(self)
		return AceGUI:IsReleasing(self)
	end

	WidgetBase.SetPoint = function(self, ...)
		return self.frame:SetPoint(...)
	end
	
	WidgetBase.ClearAllPoints = function(self)
		return self.frame:ClearAllPoints()
	end
	
	WidgetBase.GetNumPoints = function(self)
		return self.frame:GetNumPoints()
	end
	
	WidgetBase.GetPoint = function(self, ...)
		return self.frame:GetPoint(...)
	end	
	
	WidgetBase.GetUserDataTable = function(self)
		return self.userdata
	end
	
	WidgetBase.SetUserData = function(self, key, value)
		self.userdata[key] = value
	end
	
	WidgetBase.GetUserData = function(self, key)
		return self.userdata[key]
	end
	
	WidgetBase.IsFullHeight = function(self)
		return self.height == "fill"
	end
	
	WidgetBase.SetFullHeight = function(self, isFull)
		if isFull then
			self.height = "fill"
		else
			self.height = nil
		end
	end
	
	WidgetBase.IsFullWidth = function(self)
		return self.width == "fill"
	end
		
	WidgetBase.SetFullWidth = function(self, isFull)
		if isFull then
			self.width = "fill"
		else
			self.width = nil
		end
	end
	local WidgetContainerBase = AceGUI.WidgetContainerBase
		
	WidgetContainerBase.PauseLayout = function(self)
		self.LayoutPaused = true
	end
	
	WidgetContainerBase.ResumeLayout = function(self)
		self.LayoutPaused = nil
	end
	
	WidgetContainerBase.PerformLayout = function(self)
		if self.LayoutPaused then
			return
		end
		safecall(self.LayoutFunc, self.content, self.children)
	end

	WidgetContainerBase.DoLayout = function(self)
		self:PerformLayout()

	end
	
	WidgetContainerBase.AddChild = function(self, child, beforeWidget)
		if beforeWidget then
			local siblingIndex = 1
			for _, widget in pairs(self.children) do
				if widget == beforeWidget then
					break
				end
				siblingIndex = siblingIndex + 1 
			end
			tinsert(self.children, siblingIndex, child)
		else
			tinsert(self.children, child)
		end
		child:SetParent(self)
		child.frame:Show()
		self:DoLayout()
	end
	
	WidgetContainerBase.AddChildren = function(self, ...)
		for i = 1, select("#", ...) do
			local child = select(i, ...)
			tinsert(self.children, child)
			child:SetParent(self)
			child.frame:Show()
		end
		self:DoLayout()
	end
	
	WidgetContainerBase.ReleaseChildren = function(self)
		local children = self.children
		for i = 1,#children do
			AceGUI:Release(children[i])
			children[i] = nil
		end
	end
	
	WidgetContainerBase.SetLayout = function(self, Layout)
		self.LayoutFunc = AceGUI:GetLayout(Layout)
	end

	WidgetContainerBase.SetAutoAdjustHeight = function(self, adjust)
		if adjust then
			self.noAutoHeight = nil
		else
			self.noAutoHeight = true
		end
	end

	local function FrameResize(this)
		local self = this.obj
		if this:GetWidth() and this:GetHeight() then
			if self.OnWidthSet then
				self:OnWidthSet(this:GetWidth())
			end
			if self.OnHeightSet then
				self:OnHeightSet(this:GetHeight())
			end
		end
	end
	
	local function ContentResize(this)
		if this:GetWidth() and this:GetHeight() then
			this.width = this:GetWidth()
			this.height = this:GetHeight()
			this.obj:DoLayout()
		end
	end

	setmetatable(WidgetContainerBase, {__index=WidgetBase})

	function AceGUI:RegisterAsContainer(widget)
		widget.children = {}
		widget.userdata = {}
		widget.events = {}
		widget.base = WidgetContainerBase
		widget.content.obj = widget
		widget.frame.obj = widget
		widget.content:SetScript("OnSizeChanged", ContentResize)
		widget.frame:SetScript("OnSizeChanged", FrameResize)
		setmetatable(widget, {__index = WidgetContainerBase})
		widget:SetLayout("List")
		return widget
	end

	function AceGUI:RegisterAsWidget(widget)
		widget.userdata = {}
		widget.events = {}
		widget.base = WidgetBase
		widget.frame.obj = widget
		widget.frame:SetScript("OnSizeChanged", FrameResize)
		setmetatable(widget, {__index = WidgetBase})
		return widget
	end
end




------------------
-- Widget API   --
------------------
function AceGUI:RegisterWidgetType(Name, Constructor, Version)
	assert(type(Constructor) == "function")
	assert(type(Version) == "number") 
	
	local oldVersion = WidgetVersions[Name]
	if oldVersion and oldVersion >= Version then return end
	
	WidgetVersions[Name] = Version
	WidgetRegistry[Name] = Constructor
end

function AceGUI:RegisterLayout(Name, LayoutFunc)
	assert(type(LayoutFunc) == "function")
	if type(Name) == "string" then
		Name = Name:upper()
	end
	LayoutRegistry[Name] = LayoutFunc
end

function AceGUI:GetLayout(Name)
	if type(Name) == "string" then
		Name = Name:upper()
	end
	return LayoutRegistry[Name]
end

AceGUI.counts = AceGUI.counts or {}

function AceGUI:GetNextWidgetNum(type)
	if not self.counts[type] then
		self.counts[type] = 0
	end
	self.counts[type] = self.counts[type] + 1
	return self.counts[type]
end

function AceGUI:GetWidgetCount(type)
	return self.counts[type] or 0
end

function AceGUI:GetWidgetVersion(type)
	return WidgetVersions[type]
end

-------------
-- Layouts --
-------------
AceGUI:RegisterLayout("List",
	function(content, children)
		local height = 0
		local width = content.width or content:GetWidth() or 0
		for i = 1, #children do
			local child = children[i]
			
			local frame = child.frame
			frame:ClearAllPoints()
			frame:Show()
			if i == 1 then
				frame:SetPoint("TOPLEFT", content)
			else
				frame:SetPoint("TOPLEFT", children[i-1].frame, "BOTTOMLEFT")
			end
			
			if child.width == "fill" then
				child:SetWidth(width)
				frame:SetPoint("RIGHT", content)
				
				if child.DoLayout then
					child:DoLayout()
				end
			elseif child.width == "relative" then
				child:SetWidth(width * child.relWidth)
				
				if child.DoLayout then
					child:DoLayout()
				end
			end
			
			height = height + (frame.height or frame:GetHeight() or 0)
		end
		safecall(content.obj.LayoutFinished, content.obj, nil, height)
	end)

-- A single control fills the whole content area
AceGUI:RegisterLayout("Fill",
	function(content, children)
		if children[1] then
			children[1]:SetWidth(content:GetWidth() or 0)
			children[1]:SetHeight(content:GetHeight() or 0)
			children[1].frame:ClearAllPoints()
			children[1].frame:SetAllPoints(content)
			children[1].frame:Show()
			safecall(content.obj.LayoutFinished, content.obj, nil, children[1].frame:GetHeight())
		end
	end)

local layoutrecursionblock = nil
local function safelayoutcall(object, func, ...)
	layoutrecursionblock = true
	object[func](object, ...)
	layoutrecursionblock = nil
end

AceGUI:RegisterLayout("Flow",
	function(content, children)
		if layoutrecursionblock then return end
		--used height so far
		local height = 0
		--width used in the current row
		local usedwidth = 0
		--height of the current row
		local rowheight = 0
		local rowoffset = 0
		
		local width = content.width or content:GetWidth() or 0
		
		--control at the start of the row
		local rowstart
		local rowstartoffset
		local isfullheight
		
		local frameoffset
		local lastframeoffset
		local oversize 
		for i = 1, #children do
			local child = children[i]
			oversize = nil
			local frame = child.frame
			local frameheight = frame.height or frame:GetHeight() or 0
			local framewidth = frame.width or frame:GetWidth() or 0
			lastframeoffset = frameoffset

			frameoffset = child.alignoffset or (frameheight / 2)
			
			if child.width == "relative" then
				framewidth = width * child.relWidth
			end
			
			frame:Show()
			frame:ClearAllPoints()
			if i == 1 then
				-- anchor the first control to the top left
				frame:SetPoint("TOPLEFT", content)
				rowheight = frameheight
				rowoffset = frameoffset
				rowstart = frame
				rowstartoffset = frameoffset
				usedwidth = framewidth
				if usedwidth > width then
					oversize = true
				end
			else

				if usedwidth == 0 or ((framewidth) + usedwidth > width) or child.width == "fill" then
					if isfullheight then

						break
					end
					--anchor the previous row, we will now know its height and offset
					rowstart:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -(height + (rowoffset - rowstartoffset) + 3))
					height = height + rowheight + 3
					--save this as the rowstart so we can anchor it after the row is complete and we have the max height and offset of controls in it
					rowstart = frame
					rowstartoffset = frameoffset
					rowheight = frameheight
					rowoffset = frameoffset
					usedwidth = framewidth
					if usedwidth > width then
						oversize = true
					end
				-- put the control on the current row, adding it to the width and checking if the height needs to be increased
				else
					rowoffset = math_max(rowoffset, frameoffset)
					rowheight = math_max(rowheight, rowoffset + (frameheight / 2))
					
					frame:SetPoint("TOPLEFT", children[i-1].frame, "TOPRIGHT", 0, frameoffset - lastframeoffset)
					usedwidth = framewidth + usedwidth
				end
			end

			if child.width == "fill" then
				safelayoutcall(child, "SetWidth", width)
				frame:SetPoint("RIGHT", content)
				
				usedwidth = 0
				rowstart = frame
				rowstartoffset = frameoffset
				
				if child.DoLayout then
					child:DoLayout()
				end
				rowheight = frame.height or frame:GetHeight() or 0
				rowoffset = child.alignoffset or (rowheight / 2)
				rowstartoffset = rowoffset
			elseif child.width == "relative" then
				safelayoutcall(child, "SetWidth", width * child.relWidth)
				
				if child.DoLayout then
					child:DoLayout()
				end
			elseif oversize then
				if width > 1 then
					frame:SetPoint("RIGHT", content)
				end
			end
			
			if child.height == "fill" then
				frame:SetPoint("BOTTOM", content)
				isfullheight = true
			end
		end
		
		--anchor the last row, if its full height needs a special case since  its height has just been changed by the anchor
		if isfullheight then
			rowstart:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -height)
		elseif rowstart then
			rowstart:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -(height + (rowoffset - rowstartoffset) + 3))
		end
		
		height = height + rowheight + 3
		safecall(content.obj.LayoutFinished, content.obj, nil, height)
	end)

-- Get alignment method and value. Possible alignment methods are a callback, a number, "start", "middle", "end", "fill" or "TOPLEFT", "BOTTOMRIGHT" etc.
local GetCellAlign = function (dir, tableObj, colObj, cellObj, cell, child)
	local fn = cellObj and (cellObj["align" .. dir] or cellObj.align)
			or colObj and (colObj["align" .. dir] or colObj.align)
			or tableObj["align" .. dir] or tableObj.align
			or "CENTERLEFT"
	local child, cell, val = child or 0, cell or 0, nil

	if type(fn) == "string" then
		fn = fn:lower()
		fn = dir == "V" and (fn:sub(1, 3) == "top" and "start" or fn:sub(1, 6) == "bottom" and "end" or fn:sub(1, 6) == "center" and "middle")
		  or dir == "H" and (fn:sub(-4) == "left" and "start" or fn:sub(-5) == "right" and "end" or fn:sub(-6) == "center" and "middle")
		  or fn
		val = (fn == "start" or fn == "fill") and 0 or fn == "end" and cell - child or (cell - child) / 2
	elseif type(fn) == "function" then
		val = fn(child or 0, cell, dir)
	else
		val = fn
	end

	return fn, max(0, min(val, cell))
end

-- Get width or height for multiple cells combined
local GetCellDimension = function (dir, laneDim, from, to, space)
	local dim = 0
	for cell=from,to do
		dim = dim + (laneDim[cell] or 0)
	end
	return dim + max(0, to - from) * (space or 0)
end

AceGUI:RegisterLayout("Table",
	function (content, children)
		local obj = content.obj
		obj:PauseLayout()

		local tableObj = obj:GetUserData("table")
		local cols = tableObj.columns
		local spaceH = tableObj.spaceH or tableObj.space or 0
		local spaceV = tableObj.spaceV or tableObj.space or 0
		local totalH = (content:GetWidth() or content.width or 0) - spaceH * (#cols - 1)
		
		-- We need to reuse these because layout events can come in very frequently
		local layoutCache = obj:GetUserData("layoutCache")
		if not layoutCache then
			layoutCache = {{}, {}, {}, {}, {}, {}}
			obj:SetUserData("layoutCache", layoutCache)
		end
		local t, laneH, laneV, rowspans, rowStart, colStart = unpack(layoutCache)
		
		-- Create the grid
		local n, slotFound = 0
		for i,child in ipairs(children) do
			if child:IsShown() then
				repeat
					n = n + 1
					local col = (n - 1) % #cols + 1
					local row = ceil(n / #cols)
					local rowspan = rowspans[col]
					local cell = rowspan and rowspan.child or child
					local cellObj = cell:GetUserData("cell")
					slotFound = not rowspan

					-- Rowspan
					if not rowspan and cellObj and cellObj.rowspan then
						rowspan = {child = child, from = row, to = row + cellObj.rowspan - 1}
						rowspans[col] = rowspan
					end
					if rowspan and i == #children then
						rowspan.to = row
					end

					-- Colspan
					local colspan = max(0, min((cellObj and cellObj.colspan or 1) - 1, #cols - col))
					n = n + colspan

					-- Place the cell
					if not rowspan or rowspan.to == row then
						t[n] = cell
						rowStart[cell] = rowspan and rowspan.from or row
						colStart[cell] = col

						if rowspan then
							rowspans[col] = nil
						end
					end
				until slotFound
			end
		end

		local rows = ceil(n / #cols)

		-- Determine fixed size cols and collect weights
		local extantH, totalWeight = totalH, 0
		for col,colObj in ipairs(cols) do
			laneH[col] = 0

			if type(colObj) == "number" then
				colObj = {[colObj >= 1 and colObj < 10 and "weight" or "width"] = colObj}
				cols[col] = colObj
			end

			if colObj.weight then
				-- Weight
				totalWeight = totalWeight + (colObj.weight or 1)
			else
				if not colObj.width or colObj.width <= 0 then
					-- Content width
					for row=1,rows do
						local child = t[(row - 1) * #cols + col]
						if child then
							local f = child.frame
							f:ClearAllPoints()
							local childH = f:GetWidth() or 0
		
							laneH[col] = max(laneH[col], childH - GetCellDimension("H", laneH, colStart[child], col - 1, spaceH))
						end
					end

					laneH[col] = max(colObj.min or colObj[1] or 0, min(laneH[col], colObj.max or colObj[2] or laneH[col]))
				else
					-- Rel./Abs. width
					laneH[col] = colObj.width < 1 and colObj.width * totalH or colObj.width
				end
				extantH = max(0, extantH - laneH[col])
			end
		end

		-- Determine sizes based on weight
		local scale = totalWeight > 0 and extantH / totalWeight or 0
		for col,colObj in pairs(cols) do
			if colObj.weight then
				laneH[col] = scale * colObj.weight
			end
		end

		-- Arrange children
		for row=1,rows do
			local rowV = 0

			-- Horizontal placement and sizing
			for col=1,#cols do
				local child = t[(row - 1) * #cols + col]
				if child then
					local colObj = cols[colStart[child]]
					local cellObj = child:GetUserData("cell")
					local offsetH = GetCellDimension("H", laneH, 1, colStart[child] - 1, spaceH) + (colStart[child] == 1 and 0 or spaceH)
					local cellH = GetCellDimension("H", laneH, colStart[child], col, spaceH)
					
					local f = child.frame
					f:ClearAllPoints()
					local childH = f:GetWidth() or 0

					local alignFn, align = GetCellAlign("H", tableObj, colObj, cellObj, cellH, childH)
					f:SetPoint("LEFT", content, offsetH + align, 0)
					if child:IsFullWidth() or alignFn == "fill" or childH > cellH then
						f:SetPoint("RIGHT", content, "LEFT", offsetH + align + cellH, 0)
					end
					
					if child.DoLayout then
						child:DoLayout()
					end

					rowV = max(rowV, (f:GetHeight() or 0) - GetCellDimension("V", laneV, rowStart[child], row - 1, spaceV))
				end
			end

			laneV[row] = rowV

			-- Vertical placement and sizing
			for col=1,#cols do
				local child = t[(row - 1) * #cols + col]
				if child then
					local colObj = cols[colStart[child]]
					local cellObj = child:GetUserData("cell")
					local offsetV = GetCellDimension("V", laneV, 1, rowStart[child] - 1, spaceV) + (rowStart[child] == 1 and 0 or spaceV)
					local cellV = GetCellDimension("V", laneV, rowStart[child], row, spaceV)
						
					local f = child.frame
					local childV = f:GetHeight() or 0

					local alignFn, align = GetCellAlign("V", tableObj, colObj, cellObj, cellV, childV)
					if child:IsFullHeight() or alignFn == "fill" then
						f:SetHeight(cellV)
					end
					f:SetPoint("TOP", content, 0, -(offsetV + align))
				end
			end
		end

		-- Calculate total height
		local totalV = GetCellDimension("V", laneV, 1, #laneV, spaceV)
		
		-- Cleanup
		for _,v in pairs(layoutCache) do wipe(v) end

		safecall(obj.LayoutFinished, obj, nil, totalV)
		obj:ResumeLayout()
	end)
