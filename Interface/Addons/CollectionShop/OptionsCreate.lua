--------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------------------------------------------------------------------
local NS = select( 2, ... );
local cfg = NS.options.cfg;
local MainFrame, SubFrameHeader, SubFrameTabs, SubFrames = nil, nil, {}, {};
--------------------------------------------------------------------------------------------------------------------------------------------
-- MAINFRAME
--------------------------------------------------------------------------------------------------------------------------------------------
MainFrame = NS.Frame( NS.addon .. "OptionsMainFrame", UIParent, {
	topLevel = true,
	template = "ButtonFrameTemplate",
	hidden = true,
	frameStrata = cfg.mainFrame.frameStrata,
	frameLevel = cfg.mainFrame.frameLevel,
	size = { cfg.mainFrame.width, cfg.mainFrame.height },
	registerForDrag = "LeftButton",
	OnShow = function( self )
		cfg.mainFrame.OnShow( self );
	end,
	OnHide = function( self )
		PanelTemplates_DeselectTab( SubFrameTabs[PanelTemplates_GetSelectedTab( SubFrameHeader )] );
		cfg.mainFrame.OnHide( self );
	end,
	OnEvent = function( self, event )
		if event == "PLAYER_LOGIN" then
			self:UnregisterEvent( event );
			self:SetScript( "OnEvent", nil );
			cfg.mainFrame.Init( self ); -- Init MainFrame
			tinsert( UISpecialFrames, self:GetName() );
			for i = 1, #cfg.subFrameTabs do
				cfg.subFrameTabs[i].Init( SubFrames[i] ); -- Init SubFrames
			end
		end
	end,
	OnLoad = function( self )
		-- Hide Portrait
		if not cfg.mainFrame.portrait then
			ButtonFrameTemplate_HidePortrait( self );
		end
		-- Hide Button Bar
		if not cfg.mainFrame.buttonBar then
			ButtonFrameTemplate_HideButtonBar( self );
		end
		-- Inset
		self.Inset:SetPoint( "TOPLEFT", 4, ( cfg.mainFrame.portrait and -58 or -50 ) );
		-- Register to run inits
		self:RegisterEvent( "PLAYER_LOGIN" );
		-- ShowTab()
		function self:ShowTab( index )
			self:Show();
			SubFrameTabs[index or 1]:Click();
		end
		-- ? Reposition()
		if cfg.mainFrame.Reposition then
			function self:Reposition()
				cfg.mainFrame.Reposition( self );
			end
		end
	end,
} );
--------------------------------------------------------------------------------------------------------------------------------------------
-- SUBFRAMEHEADER
--------------------------------------------------------------------------------------------------------------------------------------------
SubFrameHeader = NS.Frame( "SubFrameHeader", MainFrame, {
	size = { 0, 30 },
	setPoint = {
		{ "TOPLEFT", 20, -20 },
		{ "TOPRIGHT", -10, -20 },
	},
	OnLoad = function( self )
		PanelTemplates_SetNumTabs( self, #cfg.subFrameTabs );
	end,
} );
--------------------------------------------------------------------------------------------------------------------------------------------
-- SUBFRAMETABS/SUBFRAMES
--------------------------------------------------------------------------------------------------------------------------------------------
local CreateSubFrameTab = function( index )
	return NS.Button( "Tab" .. index, SubFrameHeader, cfg.subFrameTabs[index].tabText, {
		template = "TabButtonTemplate",
		id = index,
		setPoint = ( function( self )
			if index == 1 then
				return { "BOTTOMLEFT", ( cfg.mainFrame.portrait and 35 or 0 ), ( cfg.mainFrame.portrait and -8 or 0 ) };
			else
				return { "LEFT", "$parentTab" .. ( index - 1 ), "RIGHT", 0, 0 };
			end
		end )(),
		OnClick = function( self )
			PanelTemplates_SetTab( SubFrameHeader, self.id ); -- Select Tab clicked
			for i = 1, #SubFrames do
				SubFrames[i]:Hide(); -- Hide all SubFrames
			end
			_G[MainFrame:GetName() .. "TitleText"]:SetText( cfg.subFrameTabs[index].mainFrameTitle ); -- Change MainFrame Title
			SubFrames[self.id]:Show(); -- Show (and Refresh) selectedTab SubFrame
		end,
		OnLoad = function( self )
			PanelTemplates_TabResize( self, 0 ); -- Make the button fit text
		end,
	} );
end
--------------------------------------------------------------------------------------------------------------------------------------------
local CreateSubFrame = function( index )
	return NS.Frame( "Tab" .. index .. "SubFrame", MainFrame, {
		hidden = true,
		setPoint = {
			{ "TOPLEFT", 10, ( cfg.mainFrame.portrait and -63 or -55 ) },
			{ "BOTTOMRIGHT", -10, ( cfg.mainFrame.buttonBar and 30 or 6 ) },
		},
		OnShow = function( self )
			self:Refresh();
		end,
		OnLoad = function( self )
			function self:Refresh()
				cfg.subFrameTabs[index].Refresh( self );
			end
		end,
	} );
end
--------------------------------------------------------------------------------------------------------------------------------------------
for i = 1, #cfg.subFrameTabs do
	tinsert( SubFrameTabs, CreateSubFrameTab( i ) );
	tinsert( SubFrames, CreateSubFrame( i ) );
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- ADD TO NAMESPACE
--------------------------------------------------------------------------------------------------------------------------------------------
NS.options.MainFrame = MainFrame;
--NS.options.SubFrameHeader = SubFrameHeader;
--NS.options.SubFrameTabs = SubFrameTabs;
--NS.options.SubFrames = SubFrames;
