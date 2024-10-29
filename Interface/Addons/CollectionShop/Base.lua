--------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------------------------------------------------------------------
local NS = select( 2, ... );
NS.addon = ...;
NS.title = C_AddOns.GetAddOnMetadata( NS.addon, "Title" );
NS.patch = GetBuildInfo();
NS.UI = {};
--------------------------------------------------------------------------------------------------------------------------------------------
-- FRAME CREATION
--------------------------------------------------------------------------------------------------------------------------------------------
NS.LastChild = function( parent )
	local children = { parent:GetChildren() };
	return children[#children - 1]:GetName();
end
--
NS.SetPoint = function( frame, parent, setPoint )
	if type( setPoint[1] ) ~= "table" then
		setPoint = { setPoint };
	end
	for _,point in ipairs( setPoint ) do
		for k, v in ipairs( point ) do
			if v == "#sibling" then
				point[k] = NS.LastChild( parent );
			end
		end
		frame:SetPoint( unpack( point ) );
	end
end
--
NS.Tooltip = function( frame, tooltip, tooltipAnchor )
	frame.tooltip = tooltip;
	frame.tooltipAnchor = tooltipAnchor;
	frame:SetScript( "OnEnter", function( self )
		GameTooltip:SetOwner( unpack( self.tooltipAnchor ) );
		local tooltipText = type( self.tooltip ) ~= "function" and self.tooltip or self.tooltip( self );
		if tooltipText then -- Function may have only SetHyperlink, etc. without returning text
			GameTooltip:SetText( tooltipText );
		end
		GameTooltip:Show();
	end );
	frame:SetScript( "OnLeave", GameTooltip_Hide );
end
--
NS.TextFrame = function( name, parent, text, set )
	local f = CreateFrame( "Frame", "$parent" .. name, parent );
	local fs = f:CreateFontString( "$parentText", set.layer or "ARTWORK", set.fontObject or "GameFontNormal" );
	--
	fs:SetText( text );
	--
	if set.hidden then
		f:Hide();
	end
	--
	if set.size then
		f:SetSize( set.size[1], set.size[2] );
	end
	--
	if set.setAllPoints then
		f:SetAllPoints();
	end
	--
	if set.setPoint then
		NS.SetPoint( f, parent, set.setPoint );
	end
	-- Text alignment
	fs:SetJustifyH( set.justifyH or "LEFT" );
	fs:SetJustifyV( set.justifyV or "MIDDLE" );
	-- Stretch Fontstring to fill container frame or, if no size is set, stretch container frame to fit Fontstring
	fs:SetPoint( "TOPLEFT" );
	if not set.size then
		f:SetHeight( fs:GetHeight() + ( set.addHeight or 0 ) ); -- Sometimes height is slightly less than needed, addHeight to fit
	end
	fs:SetPoint( "BOTTOMRIGHT" );
	--
	if set.OnShow then
		f:SetScript( "OnShow", set.OnShow );
	end
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--
NS.InputBox = function( name, parent, set  )
	local f = CreateFrame( "EditBox", "$parent" .. name, parent, set.template or "InputBoxTemplate" );
	--
	f:SetSize( set.size[1], set.size[2] );
	NS.SetPoint( f, parent, set.setPoint );
	--
	f:SetJustifyH( set.justifyH or "LEFT" );
	f:SetFontObject( set.fontObject or ChatFontNormal );
	f:SetAutoFocus( set.autoFocus or false );
	if set.numeric ~= nil then
		f:SetNumeric( set.numeric );
	end
	if set.maxLetters then
		f:SetMaxLetters( set.maxLetters );
	end
	-- Tooltip
	if set.tooltip then
		NS.Tooltip( f, set.tooltip, set.tooltipAnchor or { f, "ANCHOR_TOPRIGHT", 20, 0 } );
	end
	--
	if set.OnTabPressed then
		f:SetScript( "OnTabPressed", set.OnTabPressed );
	end
	if set.OnEnterPressed then
		f:SetScript( "OnEnterPressed", set.OnEnterPressed );
	end
	if set.OnEditFocusGained then
		f:SetScript( "OnEditFocusGained", set.OnEditFocusGained );
	end
	if set.OnEditFocusLost then
		f:SetScript( "OnEditFocusLost", set.OnEditFocusLost );
	end
	if set.OnTextChanged then
		f:SetScript( "OnTextChanged", set.OnTextChanged );
	end
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--
NS.Button = function( name, parent, text, set )
	local f = CreateFrame( "Button", ( set.topLevel and name or "$parent" .. name ), parent, ( set.template == nil and "UIPanelButtonTemplate" ) or ( set.template ~= false and set.template ) or nil );
	f.id = set.id or nil;
	if set.hidden then
		f:Hide();
	end
	if set.size then
		f:SetSize( set.size[1], set.size[2] );
	end
	if set.setAllPoints then
		f:SetAllPoints();
	end
	if set.setPoint then
		NS.SetPoint( f, parent, set.setPoint );
	end
	-- Text
	if text then
		local fs = f:GetFontString();
		if not fs then
			fs = f:CreateFontString( "$parentText" );
			f:SetNormalFontObject( "GameFontNormal" );
			f:SetHighlightFontObject( "GameFontHighlight" );
			f:SetDisabledFontObject( "GameFontDisable" );
		end
		f:SetText( text );
		if set.fontObject then
			f:SetNormalFontObject( set.fontObject );
			f:SetHighlightFontObject( set.fontObject );
			f:SetDisabledFontObject( set.fontObject );
		end
		if set.textColor then
			fs:SetTextColor( set.textColor[1], set.textColor[2], set.textColor[3] );
		end
		if set.justifyV then
			fs:SetJustifyV( set.justifyV );
		end
		if set.justifyH then
			fs:SetJustifyH( set.justifyH );
		end
		if set.textSetAllPoints then
			fs:SetAllPoints();
		end
	end
	-- Textures
	if set.normalTexture then
		f:SetNormalTexture( set.normalTexture );
	end
	if set.pushedTexture then
		f:SetPushedTexture( set.pushedTexture );
	end
	if set.highlightTexture then
		f:SetHighlightTexture( set.highlightTexture, "ADD" );
	end
	if set.disabledTexture then
		f:SetDisabledTexture( set.disabledTexture );
	end
	if set.texCoord then
		f:GetNormalTexture():SetTexCoord( unpack( set.texCoord ) );
	end
	-- Tooltip
	if set.tooltip then
		NS.Tooltip( f, set.tooltip, set.tooltipAnchor or { f, "ANCHOR_TOPRIGHT", 3, 0 } );
	end
	--
	if set.OnClick then
		if f:GetScript( "OnClick" ) then
			f:HookScript( "OnClick", set.OnClick );
		else
			f:SetScript( "OnClick", set.OnClick );
		end
	end
	if set.OnEnable then
		f:SetScript( "OnEnable", set.OnEnable );
	end
	if set.OnDisable then
		f:SetScript( "OnDisable", set.OnDisable );
	end
	if set.OnShow then
		f:SetScript( "OnShow", set.OnShow );
	end
	if set.OnHide then
		f:SetScript( "Onhide", set.OnHide );
	end
	if set.OnEnter then
		f:SetScript( "OnEnter", set.OnEnter );
	end
	if set.OnLeave then
		f:SetScript( "OnLeave", set.OnLeave );
	end
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--
NS.CheckButton = function( name, parent, text, set )
	local f = CreateFrame( "CheckButton", "$parent" .. name, parent, set.template or "UICheckButtonTemplate" );
	--
	_G[f:GetName() .. 'Text']:SetText( text );
	--
	if set.size then
		f:SetSize( set.size[1], set.size[2] );
	end
	--
	if set.setPoint then
		NS.SetPoint( f, parent, set.setPoint );
	end
	--
	if set.tooltip then
		NS.Tooltip( f, set.tooltip, set.tooltipAnchor or { f, "ANCHOR_TOPLEFT", 25, 0 } );
	end
	--
	f:SetScript( "OnClick", function( cb )
		local checked = cb:GetChecked();
		if cb.db then
			NS.db[cb.db] = checked;
		elseif cb.dbpc then
			NS.dbpc[cb.dbpc] = checked;
		end
		if set.OnClick then
			set.OnClick( checked, cb );
		end
	end );
	--
	f.db = set.db or nil;
	f.dbpc = set.dbpc or nil;
	--
	return f;
end
--
NS.ScrollFrame = function( name, parent, set )
	local f = CreateFrame( "ScrollFrame", "$parent" .. name, parent, "FauxScrollFrameTemplate" );
	--
	f:SetSize( set.size[1], set.size[2] );
	NS.SetPoint( f, parent, set.setPoint );
	--
	f:SetScript( "OnVerticalScroll", function ( self, offset )
		FauxScrollFrame_OnVerticalScroll( self, offset, self.buttonHeight, self.UpdateFunction );
	end );
	-- Add properties for use with vertical scroll and update function ... FauxScrollFrame_Update( frame, numItems, numToDisplay, buttonHeight, button, smallWidth, bigWidth, highlightFrame, smallHighlightWidth, bigHighlightWidth, alwaysShowScrollBar );
	for k, v in pairs( set.update ) do
		f[k] = v;
	end
	-- Create buttons
	local buttonName = "_ScrollFrameButton";
	NS.Button( buttonName .. 1, parent, nil, {
		template = set.buttonTemplate,
		setPoint = { "TOPLEFT", "$parent" .. name, "TOPLEFT", 0, 3 },
	} );
	for i = 2, f.numToDisplay do
		NS.Button( buttonName .. i, parent, nil, {
			template = set.buttonTemplate,
			setPoint = { "TOP", "$parent" .. buttonName .. ( i - 1 ), "BOTTOM" },
		} );
	end
	-- Button name for use with update function
	f.buttonName = parent:GetName() .. buttonName;
	-- Update()
	function f:Update()
		self.UpdateFunction( self );
	end
	-- Scrollbar Textures
	local tx = f:CreateTexture( nil, "ARTWORK" );
	tx:SetTexture( "Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar" );
	tx:SetSize( 31, 250 );
	tx:SetPoint( "TOPLEFT", "$parent", "TOPRIGHT", -2, 5 );
	tx:SetTexCoord( 0, 0.484375, 0, 1.0 );
	--
	local baseScrollbarSize = ( 250 - 5 ) + ( 100 - 2 );
	if set.size[2] > baseScrollbarSize then
		tx = f:CreateTexture( nil, "ARTWORK" );
		tx:SetTexture( "Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar" );
		tx:SetSize( 31, set.size[2] - baseScrollbarSize  );
		tx:SetPoint( "TOPLEFT", "$parent", "TOPRIGHT", -2, ( -250 + 5 ) );
		tx:SetTexCoord( 0, 0.484375, 0.1, 0.9 );
	end
	--
	tx = f:CreateTexture( nil, "ARTWORK" );
	tx:SetTexture( "Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar" );
	tx:SetSize( 31, 100 );
	tx:SetPoint( "BOTTOMLEFT", "$parent", "BOTTOMRIGHT", -2, -2 );
	tx:SetTexCoord( 0.515625, 1.0, 0, 0.4140625 );
	--
	function f:Reset()
		self:SetVerticalScroll( 0 );
		self:Update();
	end
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--
NS.Frame = function( name, parent, set )
	local f = CreateFrame( set.type or "Frame", ( set.topLevel and name or "$parent" .. name ), parent, set.template or nil );
	--
	if set.hidden then
		f:Hide();
	end
	if set.size then
		f:SetSize( set.size[1], set.size[2] );
	end
	if set.frameStrata then
		f:SetFrameStrata( set.frameStrata );
	end
	if set.frameLevel then
		if set.frameLevel == "TOP" then
			f:SetToplevel( true );
		else
			f:SetFrameLevel( set.frameLevel );
		end
	end
	if set.setAllPoints then
		f:SetAllPoints();
	end
	if set.setPoint then
		NS.SetPoint( f, parent, set.setPoint );
	end
	if set.bg then
		f.Bg = f.Bg or f:CreateTexture( "$parentBG", "BACKGROUND" );
		if type( set.bg[1] ) == "number" then
			f.Bg:SetColorTexture( unpack( set.bg ) );
		else
			f.Bg:SetTexture( unpack( set.bg ) );
		end
	end
	if set.bgSetAllPoints then
		f.Bg:SetAllPoints();
	end
	if set.registerForDrag then
		f:EnableMouse( true );
		f:SetMovable( true );
		f:RegisterForDrag( set.registerForDrag );
		f:SetScript( "OnDragStart", f.StartMoving );
		f:SetScript( "OnDragStop", f.StopMovingOrSizing );
	end
	if set.OnShow then
		f:SetScript( "OnShow", set.OnShow );
	end
	if set.OnHide then
		f:SetScript( "OnHide", set.OnHide );
	end
	if set.OnEvent then
		f:SetScript( "OnEvent", set.OnEvent );
	end
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--
NS.DropDownMenu = function( name, parent, set )
	local f = CreateFrame( "Frame", "$parent" .. name, parent, "UIDropDownMenuTemplate" );
	--
	NS.SetPoint( f, parent, set.setPoint );
	--
	if set.tooltip then
		NS.Tooltip( f, set.tooltip, set.tooltipAnchor or { f, "ANCHOR_TOPRIGHT", 3, 0 } );
	end
	--
	UIDropDownMenu_SetWidth( f, set.width );
	--
	f.buttons = set.buttons;
	f.OnClick = set.OnClick or nil;
	f.db = set.db or nil;
	f.dbpc = set.dbpc or nil;
	--
	function f:Reset( selectedValue )
		UIDropDownMenu_Initialize( self, NS.DropDownMenu_Initialize );
		UIDropDownMenu_SetSelectedValue( self, selectedValue );
	end
	--
	return f;
end
--
NS.DropDownMenu_Initialize = function( dropdownMenu )
	local dm = dropdownMenu;
	for _,button in ipairs( type( dm.buttons ) == "function" and dm.buttons() or dm.buttons ) do
		local info, text, value = {}, unpack( button );
		info.owner = dm;
		info.text = text;
		info.value = value;
		info.checked = nil;
		info.func = function()
			UIDropDownMenu_SetSelectedValue( info.owner, info.value );
			if dm.db and NS.db[dm.db] then
				NS.db[dm.db] = info.value;
			elseif dm.dbpc and NS.dbpc[dm.dbpc] then
				NS.dbpc[dm.dbpc] = info.value;
			end
			if dm.OnClick then
				dm.OnClick( info );
			end
		end
		UIDropDownMenu_AddButton( info );
	end
end
--
NS.MinimapButton = function( name, texture, set )
	-- In a revision on 09/01/2017, bits and pieces were borrowed from LibDBIcon-1.0 by funkydude
	-- in an effort to increase compatibility with non-standard Minimap shapes.
	local f = CreateFrame( "Button", name, Minimap );
	f.db = set.db; -- Saved position variable
	f.docked = true;
	f.locked = false;
	local i,b,bg,radius,diagRadius;
	local minimapShapes = {
		["ROUND"] = { true, true, true, true },
		["SQUARE"] = { false, false, false, false },
		["CORNER-TOPLEFT"] = { false, false, false, true },
		["CORNER-TOPRIGHT"] = { false, false, true, false },
		["CORNER-BOTTOMLEFT"] = { false, true, false, false },
		["CORNER-BOTTOMRIGHT"] = { true, false, false, false },
		["SIDE-LEFT"] = { false, true, false, true },
		["SIDE-RIGHT"] = { true, false, true, false },
		["SIDE-TOP"] = { false, false, true, true },
		["SIDE-BOTTOM"] = { true, true, false, false },
		["TRICORNER-TOPLEFT"] = { false, true, true, true },
		["TRICORNER-TOPRIGHT"] = { true, false, true, true },
		["TRICORNER-BOTTOMLEFT"] = { true, true, false, true },
		["TRICORNER-BOTTOMRIGHT"] = { true, true, true, false },
	};
	-- Position and Dragging
	f:EnableMouse( true );
	f:SetMovable( true );
	f:RegisterForClicks( "LeftButtonUp", "RightButtonUp", "MiddleButtonUp" );
	f:RegisterForDrag( "LeftButton", "RightButton" );
	local BeingDragged = function()
		-- Locked
		if f.locked then
			return;
		end
		-- Undocked
		if not f.docked then
			f:StartMoving();
		-- Docked
		else
			local mx, my = Minimap:GetCenter();
			local cx, cy = GetCursorPosition();
			local scale = Minimap:GetEffectiveScale();
			cx, cy = ( cx / scale ), ( cy / scale );
			local pos = math.deg( math.atan2( cy - my, cx - mx ) ) % 360;
			NS.db[f.db] = pos;
			f:UpdatePos();
		end
	end
	f:SetScript( "OnDragStart", function()
		f:SetScript( "OnUpdate", BeingDragged );
	end );
	f:SetScript( "OnDragStop", function()
		f:SetScript( "OnUpdate", nil );
		-- Undocked
		if not f.docked then
			f:StopMovingOrSizing();
			local point, relativeTo, relativePoint, xOffset, yOffset = f:GetPoint( 1 );
			NS.db[f.db] = ( point and point == relativePoint and xOffset and yOffset ) and { point, xOffset, yOffset } or { "CENTER", 0, 150 };
		end
	end );
	function f:UpdatePos()
		f:ClearAllPoints();
		-- Undocked
		if not f.docked then
			f:SetParent( UIParent );
			f:SetPoint( unpack( NS.db[f.db] ) );
		-- Docked
		else
			local angle = math.rad( NS.db[f.db] );
			local x, y, q = math.cos( angle ), math.sin( angle ), 1;
			q = x < 0 and q + 1 or q;
			q = y > 0 and q + 2 or q;
			local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND";
			local quadTable = minimapShapes[minimapShape];
			if quadTable[q] then
				x, y = ( x * radius ), ( y * radius );
			else
				x = math.max( 0 - radius, math.min( x * diagRadius, radius ) );
				y = math.max( 0 - radius, math.min( y * diagRadius, radius ) );
			end
			f:SetParent( Minimap );
			f:SetPoint( "CENTER", Minimap, "CENTER", x, y );
		end
		f:SetFrameStrata( "MEDIUM" );
		f:SetFrameLevel( 8 );
	end
	function f:UpdateSize( large )
		local iSize,iOffsetX,iOffsetY;
		if large then
			-- Large
			if set.square then
				iSize = 22;
				iOffsetX,iOffsetY = 11.5,-10.5;
			end
			radius = 61.5;
			diagRadius = 76.9741340859;
			f:SetScale( 1.4 );
		else
			-- Normal
			if set.square then
				iSize = 16;
				iOffsetX,iOffsetY = 8,-7;
			end
			radius = 80;
			diagRadius = 103.13708498985;
			f:SetScale( 1 );
		end
		if set.square then
			i:SetSize( iSize, iSize );
			i:SetPoint( "TOPLEFT", iOffsetX, iOffsetY );
		end
	end
	-- Highlight
	f:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD" );
	-- Icon
	i = f:CreateTexture( nil, "ARTWORK" );
	i:SetSize( 21, 21 ); -- Non-standard size
	i:SetPoint( "TOPLEFT", 5.7, -5 ); -- Non-standard offsets
	i:SetTexture( texture );
	if set.texCoord then
		i:SetTexCoord( unpack( set.texCoord ) );
	end
	-- Border
	b = f:CreateTexture( nil, "BORDER" );
	b:SetSize( 54, 54 ); -- Standard size
	b:SetPoint( "TOPLEFT" );
	b:SetTexture( "Interface\\Minimap\\MiniMap-TrackingBorder" );
	-- Background
	bg = f:CreateTexture( nil, "BACKGROUND" );
	bg:SetSize( 25, 25 ); -- Standard size
	bg:SetPoint( "TOPLEFT", 2, -4 ); -- Standard offsets
	bg:SetTexture( "Interface\\Minimap\\UI-Minimap-Background" );
	-- Size
	f:SetSize( 32, 32 ); -- Standard size
	f:UpdateSize();
	-- Tooltip
	if set.tooltip then
		NS.Tooltip( f, set.tooltip, set.tooltipAnchor or { f, "ANCHOR_LEFT", 3, 0 } );
	end
	-- LeftClick / RightClick
	f:SetScript( "OnClick", function( self, ... )
		local btn = select( 1, ... );
		if btn == "LeftButton" and set.OnLeftClick then
			set.OnLeftClick( self, ... );
		elseif btn == "RightButton" and set.OnRightClick then
			set.OnRightClick( self, ... );
		elseif btn == "MiddleButton" and set.OnMiddleClick then
			set.OnMiddleClick( self, ... );
		end
	end );
	if set.OnLoad then
		set.OnLoad( f );
	end
	return f;
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- GENERAL
--------------------------------------------------------------------------------------------------------------------------------------------
NS.Explode = function( sep, str, limit )
	local t = {};
	for v in string.gmatch( str, "[^%" .. sep .. "]+" ) do
		table.insert( t, v );
		if limit and #t == limit then break end
	end
	return t;
end
--
NS.TruncatedText_OnEnter = function( self )
	local fs = _G[self:GetName() .. "Text"];
	if fs:IsTruncated() then
		GameTooltip:SetOwner( self, "ANCHOR_TOP" );
		GameTooltip:SetText( fs:GetText() );
	end
end
--
NS.Count = function( t )
	local count = 0;
	for _ in pairs( t ) do
		count = count + 1;
	end
	return count;
end
--
NS.Print = function( msg )
	print( ORANGE_FONT_COLOR_CODE .. "<|r" .. NORMAL_FONT_COLOR_CODE .. NS.addon .. "|r" .. ORANGE_FONT_COLOR_CODE .. ">|r " .. msg );
end
--
NS.Debug = function( msg )
	if not NS.debug then return end
	NS.Print( "DEBUG: " .. msg );
end
--
NS.SecondsToStrTime = function( seconds, colorCode )
	-- Seconds In Min, Hour, Day
    local secondsInAMinute = 60;
    local secondsInAnHour  = 60 * secondsInAMinute;
    local secondsInADay    = 24 * secondsInAnHour;
    -- Days
    local days = math.floor( seconds / secondsInADay );
    -- Hours
    local hourSeconds = seconds % secondsInADay;
    local hours = math.floor( hourSeconds / secondsInAnHour );
    -- Minutes
    local minuteSeconds = hourSeconds % secondsInAnHour;
    local minutes = floor( minuteSeconds / secondsInAMinute );
    -- Seconds
    local remainingSeconds = minuteSeconds % secondsInAMinute;
    local seconds = math.ceil( remainingSeconds );
	--
	local strTime = ( days > 0 and hours == 0 and days .. " Day" ) or ( days > 0 and days .. " Day " .. hours .. " Hr" ) or ( hours > 0 and minutes == 0 and hours .. " Hr" ) or ( hours > 0 and hours .. " Hr " .. minutes .. " Min" ) or ( minutes > 0 and minutes .. " Min" ) or seconds .. " sec";
	return colorCode and ( colorCode .. strTime .. "|r" ) or strTime;
end
--
NS.StrTimeToSeconds = function( str )
	if not str then return 0; end
	local t1, i1, t2, i2 = strsplit( " ", str ); -- x day   -   x day x hr   -   x hr y min   -   x hr   -   x min   -   x sec
	local M = function( i )
		i = string.lower( i );
		if i == "hr" then
			return 3600;
		elseif i == "min" then
			return 60;
		elseif i == "sec" then
			return 1;
		else
			return 86400; -- day
		end
	end
	return t1 * M( i1 ) + ( t2 and t2 * M( i2 ) or 0 );
end
--
NS.FormatNum = function( num )
	local k;
	while true do
		num, k = string.gsub( num, "^(-?%d+)(%d%d%d)", "%1,%2" );
		if ( k == 0 ) then break end
	end
	return num;
end
--
NS.MoneyToString = function( money, colorCode )
	local negative = money < 0;
	money = math.abs( money );
	colorCode = colorCode or HIGHLIGHT_FONT_COLOR_CODE;
	--
	local gold = money >= COPPER_PER_GOLD and NS.FormatNum( math.floor( money / COPPER_PER_GOLD ) ) or nil;
	local silver = math.floor( ( money % COPPER_PER_GOLD ) / COPPER_PER_SILVER );
	local copper = math.floor( money % COPPER_PER_SILVER );
	--
	gold = ( gold and colorCode ) and ( colorCode .. gold .. FONT_COLOR_CODE_CLOSE ) or gold;
	silver = ( silver > 0 and colorCode ) and ( colorCode .. silver .. FONT_COLOR_CODE_CLOSE ) or ( silver > 0 and silver ) or nil;
	copper = ( copper > 0 and colorCode ) and ( colorCode .. copper .. FONT_COLOR_CODE_CLOSE ) or ( copper > 0 and copper ) or nil;
	--
	local g,s,c = "|cffffd70ag|r","|cffc7c7cfs|r","|cffeda55fc|r";
	local moneyText = "";
	if copper then
		moneyText = copper .. c;
	end
	if silver then
		moneyText = copper and ( silver .. s .. " " .. moneyText ) or ( silver .. s );
	end
	if gold then
		moneyText = ( copper or silver ) and ( gold .. g .. " " .. moneyText ) or ( gold .. g );
	end
	if negative then
		moneyText = colorCode and ( colorCode "-|r" .. moneyText ) or ( "-" .. moneyText );
	end
	return moneyText;
end
--
NS.FindKeyByField = function( t, f, v )
	if not v then return nil end
	for k = 1, #t do
		if t[k][f] == v then
			return k;
		end
	end
	return nil;
end
--
NS.PairsFindKeyByField = function( t, f, v )
	if not v then return nil end
	for k,_ in pairs( t ) do
		if t[k][f] == v then
			return k;
		end
	end
	return nil;
end
--
NS.FindKeyByValue = function( t, v )
	if not v then return nil end
	for k = 1, #t do
		if t[k] == v then
			return k;
		end
	end
	return nil;
end
--
NS.PairsFindKeyByValue = function( t, v )
	if not v then return nil end
	for k,_ in pairs( t ) do
		if t[k] == v then
			return k;
		end
	end
	return nil;
end
--
NS.RemoveKeysByFunction = function( t, func )
	local k, r = 1, 0;
	while k <= #t do
		if func( t[k] ) then
			table.remove( t, k );
			r = r + 1;
		else
			k = k + 1;
		end
	end
	return r;
end
--
NS.Sort = function( t, k, order )
	table.sort ( t,
		function ( e1, e2 )
			if order == "ASC" then
				return e1[k] < e2[k];
			elseif order == "DESC" then
				return e1[k] > e2[k];
			end
		end
	);
end
--
NS.GetItemInfo = function( itemIdNameLink, Callback, maxAttempts, after )
	if not itemIdNameLink or itemIdNameLink == 0 then return Callback(); end
	local attempts,CheckItemInfo;
	CheckItemInfo = function()
		local name,link,quality,level,minLevel,type,subType,stackCount,equipLoc,texture,sellPrice,classID,subClassID = GetItemInfo( itemIdNameLink );
		if not name and attempts < maxAttempts then
			attempts = attempts + 1;
			return C_Timer.After( after, CheckItemInfo );
		elseif not name then
			return Callback();
		else
			return Callback( name,link,quality,level,minLevel,type,subType,stackCount,equipLoc,texture,sellPrice,classID,subClassID );
		end
	end
	attempts = 1;
	maxAttempts = maxAttempts or 50;
	after = after or 0.10;
	CheckItemInfo();
end
--
NS.GetWeeklyQuestResetTime = function()
	local TUE,WED,THU = 2, 3, 4;
	local resetWeekdays = { ["BETA"] = TUE, ["US"] = TUE, ["EU"] = WED, ["CN"] = THU, ["KR"] = THU, ["TW"] = THU };
	local resetWeekday = resetWeekdays[GetCVar( "portal" ):upper()];
	local resetTime = time() + GetQuestResetTime();
	while tonumber( date( "%w", resetTime ) ) ~= resetWeekday do
		resetTime = resetTime + 86400;
	end
	return resetTime;
end
--
NS.BatchDataLoop = function( set )
	--------------------------------------------------------
	-- Set can including the following:
	--------------------------------------------------------
	-- data 				(required)
	-- batchSize
	-- attemptsMax
	-- EndBatchFunction
	-- AbortFunction
	-- DataFunction 		(required)
	-- CompleteFunction 	(required)
	--------------------------------------------------------
	local dataNum,batchNum,batchSize,batchRetry,AdvanceBatch,NextData;
	--
	AdvanceBatch = function()
		if batchNum == batchSize or dataNum == #set.data then
			-- Batch Complete
			if set.EndBatchFunction then
				set.EndBatchFunction( set.data, dataNum );
			end
			--
			if batchRetry.count > 0 and ( not batchRetry.inProgress or ( batchRetry.inProgress and batchRetry.attempts < batchRetry.attemptsMax ) ) then
				-- Retry Batch
				batchRetry.inProgress = true;
				batchRetry.attempts = batchRetry.attempts + 1;
				dataNum = dataNum - batchNum; -- Reset dataNum to start of batch for retry
				batchNum = 1;
				return C_Timer.After( batchRetry.attempts * 0.01, NextData );
			else
				-- Fresh Batch
				batchRetry.inProgress = false;
				batchRetry.count = 0;
				batchRetry.attempts = 0;
				wipe( batchRetry.batchNum );
				batchNum = 1;
				return C_Timer.After( 0.001, NextData );
			end
		else
			-- Increment Batch
			batchNum = batchNum + 1;
			return NextData();
		end
	end
	--
	NextData = function()
		dataNum = dataNum + 1;
		--
		if set.AbortFunction and set.AbortFunction() then return end
		if dataNum > #set.data then return set.CompleteFunction(); end -- Data complete
		--
		if not batchRetry.inProgress or ( batchRetry.inProgress and batchRetry.batchNum[batchNum] ) then -- Not currently retrying or retrying and match
			local dataReturn = set.DataFunction( set.data, dataNum ); -- retry, complete or {anything-else}
			if dataReturn == "retry" then
				-- Add new retry
				if not batchRetry.inProgress then
					batchRetry.count = batchRetry.count + 1;
					batchRetry.batchNum[batchNum] = true;
				end
			elseif dataReturn == "complete" then
				-- Completed early, no more data required
				return set.CompleteFunction();
			elseif batchRetry.inProgress then
				-- Remove successful retry
				batchRetry.count = batchRetry.count - 1;
				batchRetry.batchNum[batchNum] = nil;
			end
		end
		return AdvanceBatch();
	end
	--
	dataNum = 0;
	batchNum = 1;
	batchSize = set.batchSize or 50;
	batchRetry = { inProgress = false, count = 0, attempts = 0, attemptsMax = set.attemptsMax or 50, batchNum = {} };
	NextData();
end
--
NS.GetAtlasInlineTexture = function( name, height, width )
	-- https://wowpedia.fandom.com/wiki/API_C_Texture.GetAtlasInfo
	-- info: width, height, leftTexCoord, rightTexCoord, topTexCoord, bottomTexCoord, tilesHorizontally, titlesVertically, file, filename
	height, width = ( height or 0 ), ( width or 0 );
	local info = C_Texture.GetAtlasInfo( name );
	if height == 0 and width > 0 then
		height = ( info.height / info.width ) * width;
	elseif width == 0 and height > 0 then
		width = ( info.width / info.height ) * height;
	end
	-- https://wowpedia.fandom.com/wiki/UI_escape_sequences#Texture_atlas
	-- |A:atlas:height:width[:offsetX:offsetY[:rVertexColor:gVertexColor:bVertexColor]]|a
	return string.format( "|A:%s:%d:%d|a", name, height, width );
end
--
NS.AddLinesToTooltip = function( lines, double, tooltip )
	-- https://wow.gamepedia.com/API_GameTooltip_AddLine
	-- https://wow.gamepedia.com/API_GameTooltip_AddDoubleLine
	-- GameTooltip:AddLine(tooltipText [, r, g, b [, wrapText]])
	-- GameTooltip:AddDoubleLine(leftText, rightText[, leftR, leftG, leftB[, rightR, rightG, rightB]])
	tooltip = tooltip or GameTooltip;
	local tooltipName = tooltip:GetName();
	if type( lines ) == "table" then
		for i = 1, #lines do
			if type( lines[i] ) == "table" then
				if double then
					tooltip:AddDoubleLine( lines[i][1], lines[i][2], ( lines[i][3] or nil ), ( lines[i][4] or nil ), ( lines[i][5] or nil ), ( lines[i][6] or nil ), ( lines[i][7] or nil ), ( lines[i][8] or nil ) );
				else
					tooltip:AddLine( lines[i][1], ( lines[i][2] or nil ), ( lines[i][3] or nil ), ( lines[i][4] or nil ), ( lines[i][5] or nil ) );
				end
			else
				tooltip:AddLine( lines[i] );
			end
		end
	elseif lines then
		tooltip:AddLine( lines );
	end
end
