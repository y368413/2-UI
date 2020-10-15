--------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------------------------------------------------------------------
local NS = select( 2, ... );
local L = NS.localization;
--------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
--------------------------------------------------------------------------------------------------------------------------------------------
NS.options.cfg = {
	--
	mainFrame = {
		width		= 600,
		height		= 440,
		portrait	= true,
		frameStrata	= "MEDIUM",
		frameLevel	= "TOP",
		Init		= function( MainFrame )
			SetPortraitToTexture( MainFrame.portrait, "Interface\\Icons\\MountJournalPortrait" );
		end,
		OnShow		= function( MainFrame )
			MainFrame:ClearAllPoints();
			MainFrame:SetPoint( "CENTER", 0, 0 );
		end,
		OnHide		= function( MainFrame ) end,
	},
	--
	subFrameTabs = {
		{
			-- Options
			mainFrameTitle	= NS.title,
			tabText			= OPTIONS,
			Init			= function( SubFrame )
				NS.TextFrame( "Description", SubFrame, string.format( L["These options apply to all characters on your account.\nMaking changes will interupt or reset %s Auction House scans."], NS.title ), {
					setPoint = {
						{ "TOPLEFT", "$parent", "TOPLEFT", 8, -8 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontRedSmall",
				} );
				NS.CheckButton( "AuctionsWonReminderCheckButton", SubFrame, L["Auctions Won Reminder"], {
					setPoint = { "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -18 },
					tooltip = string.format( L["Remind me to use or\nequip auctions I've won\nafter leaving %s."], NS.title ),
					db = "auctionsWonReminder",
				} );
				NS.TextFrame( "MaxItemPriceLabel", SubFrame, L["Max Item Prices"], {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 4, -8 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontHighlight"
				} );
				NS.TextFrame( "MaxItemPriceInfo", SubFrame, L["Hide auctions above this Item Price, 0 to show all."], {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -4 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontNormalSmall"
				} );
				for i = 1, #NS.modes do
					NS.InputBox( "MaxItemPriceMode" .. i .. "Editbox", SubFrame, {
						size = { 52, 20 },
						setPoint = { "TOPLEFT", ( i == 1 and "#sibling" or "$parentMaxItemPriceMode" .. ( i - 1 ) .. "Editbox" ), "BOTTOMLEFT", ( i == 1 and 4 or 0 ), -8 },
						numeric = true,
						maxLetters = 6,
						OnTabPressed = function()
							_G[SubFrame:GetName() .. "MaxItemPriceMode" .. ( ( i + 1 ) <= #NS.modes and ( i + 1 ) or 1 ) .. "Editbox"]:SetFocus();
						end,
						OnEnterPressed = function( self )
							self:ClearFocus();
						end,
						OnEditFocusGained = function( self )
							self:HighlightText();
						end,
						OnEditFocusLost = function( self )
							self:HighlightText( 0, 0 );
							if self:GetNumber() == 0 then
								self:SetNumber( 0 );
							end
						end,
						OnTextChanged = function( self, userInput )
							local copper = self:GetNumber() * 10000; -- Convert gold to copper
							if copper ~= NS.db["maxItemPriceCopper"][NS.modes[i]] then
								NS.db["maxItemPriceCopper"][NS.modes[i]] = copper;
								if NS.mode == NS.modes[i] and NS.IsTabShown() then
									NS.Reset(); -- Reset, option changed
								end
							end
						end,
					} );
					NS.TextFrame( "MaxItemPriceGoldIcon", SubFrame, "|TInterface\\MONEYFRAME\\UI-GoldIcon:14|t   " .. NS.modeColorCodes[i] .. NS.modeNames[i] .. FONT_COLOR_CODE_CLOSE, {
						size = { 200, 14 },
						setPoint = { "LEFT", "#sibling", "RIGHT", 3, 0 },
					} );
				end
				NS.TextFrame( "TSMItemValueSourceLabel", SubFrame, L["Item Value Source"], {
					setPoint = {
						{ "TOPLEFT", "$parentMaxItemPriceMode" .. #NS.modes .. "Editbox", "BOTTOMLEFT", -4, -12 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontHighlight",
				} );
				NS.TextFrame( "TSMItemValueSourceInfo", SubFrame, L["TradeSkillMaster price source or custom price source. For a list of price sources type /tsm sources."], {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -4 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontNormalSmall",
				} );
				NS.InputBox( "TSMItemValueSourceEditbox", SubFrame, {
					size = { 190, 20 },
					setPoint = { "TOPLEFT", "#sibling", "BOTTOMLEFT", 4, -4 },
					maxLetters = 50,
					OnEnterPressed = function( self )
						self:ClearFocus();
					end,
					OnEditFocusGained = function( self )
						self:HighlightText();
					end,
					OnEditFocusLost = function( self )
						self:HighlightText( 0, 0 );
						local source = strtrim( self:GetText() );
						if source ~= NS.db["tsmItemValueSource"] then
							-- Validate Source
							if TSM_API and source ~= "" then
								if not ( TSM_API and TSM_API.IsCustomPriceValid( source ) ) then
									NS.Print( RED_FONT_COLOR_CODE .. L["Not a valid price source or custom price source."] .. FONT_COLOR_CODE_CLOSE );
								end
							end
							--
							NS.db["tsmItemValueSource"] = source; -- Always update source regardless of validity
							NS.adjustScrollFrame = true; -- Always adjust when changed regardless of whether it's required
							if NS.IsTabShown() then
								NS.Reset(); -- Reset, option changed
							end
						end
					end,
				} );
				NS.TextFrame( "TSMItemValueSourceInfo2", SubFrame, L["(adds Item Value % column to results, leave blank to disable)"], {
					setPoint = {
						{ "LEFT", "#sibling", "RIGHT", 8, 0 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontNormalSmall",
				} );
				NS.CheckButton( "AutoselectAfterAuctionUnavailableCheckButton", SubFrame, L["Auto-select After Auction Unavailable"], {
					setPoint = { "TOPLEFT", "$parentTSMItemValueSourceEditbox", "BOTTOMLEFT", -8, -12 },
					tooltip = L["When not using BuyAll, this\noption will auto-select and scroll\nto the next cheapest auction of the\nsame appearance, same pet, etc.\n\nWhen using BuyAll, this option is\nignored because the next (first)\nauction is always auto-selected."],
					db = "autoselectAfterAuctionUnavailable",
				} );
			end,
			Refresh			= function( SubFrame )
				local sfn = SubFrame:GetName();
				_G[sfn .. "AuctionsWonReminderCheckButton"]:SetChecked( NS.db["auctionsWonReminder"] );
				for i = 1, #NS.modes do
					_G[sfn .. "MaxItemPriceMode" .. i .. "Editbox"]:SetNumber( NS.db["maxItemPriceCopper"][NS.modes[i]] / 10000 ); -- Convert copper to gold
				end
				_G[sfn .. "TSMItemValueSourceEditbox"]:SetText( NS.db["tsmItemValueSource"] );
				_G[sfn .. "AutoselectAfterAuctionUnavailableCheckButton"]:SetChecked( NS.db["autoselectAfterAuctionUnavailable"] );
			end,
		},
		{
			-- Buyouts
			mainFrameTitle	= NS.title,
			tabText			= L["Buyouts"],
			Init			= function( SubFrame )
				NS.Button( "NameColumnHeaderButton", SubFrame, NAME, {
					template = "CollectionShop_AuctionsWon_ColumnHeaderButtonTemplate",
					size = { 253, 19 },
					setPoint = { "TOPLEFT", "$parent", "TOPLEFT", -2, 0 },
				} );
				NS.Button( "ModeColumnHeaderButton", SubFrame, L["Mode"], {
					template = "CollectionShop_AuctionsWon_ColumnHeaderButtonTemplate",
					size = { 112, 19 },
					setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
				} );
				NS.Button( "ItemPriceColumnHeaderButton", SubFrame, L["Item Price"], {
					template = "CollectionShop_AuctionsWon_ColumnHeaderButtonTemplate",
					size = { 188, 19 },
					setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
				} );
				NS.Button( "RefreshButton", SubFrame, L["Refresh"], {
					size = { 96, 20 },
					setPoint = { "BOTTOMRIGHT", "#sibling", "TOPRIGHT", 2, 7 },
					fontObject = "GameFontNormalSmall",
					OnClick = function()
						SubFrame:Refresh();
						NS.Print( L["Buyouts Refreshed"] );
					end,
				} );
				NS.ScrollFrame( "ScrollFrame", SubFrame, {
					size = { 553, ( 26 * 11 - 5 ) },
					setPoint = { "TOPLEFT", "$parentNameColumnHeaderButton", "BOTTOMLEFT", 1, -3 },
					buttonTemplate = "CollectionShop_AuctionsWon_ScrollFrameButtonTemplate",
					update = {
						numToDisplay = 11,
						buttonHeight = 26,
						alwaysShowScrollBar = true,
						UpdateFunction = function( sf )
							local items = NS.auctionsWon;
							local numItems = #items;
							local sfn = SubFrame:GetName();
							FauxScrollFrame_Update( sf, numItems, sf.numToDisplay, sf.buttonHeight, nil, nil, nil, nil, nil, nil, sf.alwaysShowScrollBar );
							local offset = FauxScrollFrame_GetOffset( sf );
							for num = 1, sf.numToDisplay do
								local bn = sf.buttonName .. num; -- button name
								local b = _G[bn]; -- button
								local k = offset + num; -- key
								b:UnlockHighlight();
								if k <= numItems then
									_G[bn .. "_Name"]:SetText( ITEM_QUALITY_COLORS[items[k][4]].hex .. string.match( items[k][2], "%|h%[(.+)%]%|h" ) .. FONT_COLOR_CODE_CLOSE ); -- quality(4), itemLink(2)
									_G[bn .. "_Name"]:SetScript( "OnEnter", function( self )
										GameTooltip:SetOwner( self, "ANCHOR_TOP" );
										if string.match( items[k][2], "|Hbattlepet:" ) then -- itemLink(2)
											local _,speciesID,level,breedQuality,maxHealth,power,speed,customName = strsplit( ":", items[k][2] )
											BattlePetToolTip_Show( tonumber( speciesID ), tonumber( level ), tonumber( breedQuality ), tonumber( maxHealth ), tonumber( power ), tonumber( speed ), customName );
										else
											GameTooltip:SetHyperlink( items[k][2] );
										end
										b:LockHighlight();
									end );
									_G[bn .. "_Name"]:SetScript( "OnLeave", function() GameTooltip_Hide(); b:UnlockHighlight(); end );
									_G[bn .. "_ModeText"]:SetText( NS.modeColorCodes[items[k].modeNum] .. NS.modeNames[items[k].modeNum] .. FONT_COLOR_CODE_CLOSE );
									MoneyFrame_Update( bn .. "_ItemPriceSmallMoneyFrame", items[k][1] ); -- itemPrice(1)
									b:Show();
								else
									b:Hide();
								end
							end
						end
					},
				} );
				NS.TextFrame( "AuctionsWon", SubFrame, "", {
					size = { 553, 63 },
					setPoint = { "TOP", "#sibling", "BOTTOM" },
					fontObject = "GameFontNormal",
					justifyH = "CENTER",
				} );
			end,
			Refresh			= function( SubFrame )
				local sfn = SubFrame:GetName();
				--
				_G[sfn .. "ScrollFrame"]:Reset();
				_G[sfn .. "AuctionsWonText"]:SetText( string.format( L["%s\n%sBuyout tracking is reset when %s is closed|r"], #NS.auctionsWon .. " " .. GREEN_FONT_COLOR_CODE .. ( #NS.auctionsWon == 1 and L["Buyout"] or L["Buyouts"] ) .. FONT_COLOR_CODE_CLOSE .. ( NS.copperAuctionsWon > 0 and " (" .. NS.MoneyToString( NS.copperAuctionsWon, HIGHLIGHT_FONT_COLOR_CODE ) .. ")" or "" ), RED_FONT_COLOR_CODE, NS.title ) );
			end,
		},
		{
			-- GetAll Scan Data
			mainFrameTitle	= NS.title,
			tabText			= L["GetAll Scan Data"],
			Init			= function( SubFrame )
				NS.TextFrame( "NoDataFoundMessage", SubFrame, L["No GetAll scan data for any realms."], {
					setPoint = {
						{ "TOPLEFT", "$parent", "TOPLEFT", 8, -8 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontRedSmall",
				} );
				NS.TextFrame( "RealmLabel", SubFrame, L["Realm:"], {
					size = { 45, 16 },
					setPoint = { "TOPLEFT", "$parent", "TOPLEFT", 8, -8 },
				} );
				NS.DropDownMenu( "RealmDropDownMenu", SubFrame, {
					setPoint = { "LEFT", "#sibling", "RIGHT", -12, -1 },
					buttons = function()
						local t = {};
						for realmName,_ in pairs( NS.db["getAllScan"] ) do
							tinsert( t, { realmName .. " : " .. NS.SecondsToStrTime( time() - NS.db["getAllScan"][realmName]["time"] ) .. " " .. L["ago"], realmName } );
						end
						return t;
					end,
					width = 195,
				} );
				NS.Button( "DeleteDataButton", SubFrame, L["Delete Data"], {
					size = { 126, 22 },
					setPoint = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -8, 8 },
					OnClick = function()
						StaticPopup_Show( "CS_REALM_DELETE", UIDropDownMenu_GetSelectedValue( _G[SubFrame:GetName() .. "RealmDropDownMenu"] ), NS.title, { ["realmName"] = UIDropDownMenu_GetSelectedValue( _G[SubFrame:GetName() .. "RealmDropDownMenu"] ) } );
					end,
				} );
				StaticPopupDialogs["CS_REALM_DELETE"] = {
					text = L["Delete GetAll scan data? %s\n\nThis will interupt or reset %s Auction House scans"];
					button1 = YES,
					button2 = NO,
					OnAccept = function ( self, data )
						-- Interupt Auction House scans
						if NS.scan.status == "scanning" then
							NS.Reset();
						end
						-- Delete
						NS.db["getAllScan"][data["realmName"]] = nil;
						collectgarbage( "collect" );
						NS.Print( RED_FONT_COLOR_CODE .. string.format( L["GetAll scan data deleted: %s"], data["realmName"] ) .. FONT_COLOR_CODE_CLOSE );
						-- Refresh
						SubFrame:Refresh();
						-- Reset
						if AuctionFrameCollectionShop and AuctionFrameCollectionShop:IsShown() then
							NS.Reset();
						end
					end,
					OnCancel = function ( self ) end,
					showAlert = 1,
					hideOnEscape = 1,
					timeout = 0,
					exclusive = 1,
					whileDead = 1,
				};
			end,
			Refresh			= function( SubFrame )
				local sfn = SubFrame:GetName();
				local firstRealm = next( NS.db["getAllScan"] );
				if firstRealm then
					_G[sfn .. "NoDataFoundMessage"]:Hide();
					_G[sfn .. "RealmLabel"]:Show();
					_G[sfn .. "RealmDropDownMenu"]:Show();
					_G[sfn .. "DeleteDataButton"]:Show();
					--
					_G[sfn .. "RealmDropDownMenu"]:Reset( firstRealm );
				else
					_G[sfn .. "NoDataFoundMessage"]:Show();
					_G[sfn .. "RealmLabel"]:Hide();
					_G[sfn .. "RealmDropDownMenu"]:Hide();
					_G[sfn .. "DeleteDataButton"]:Hide();
				end
			end,
		},
		{
			-- Help
			mainFrameTitle	= NS.title,
			tabText			= HELP_LABEL,
			Init			= function( SubFrame )
				NS.TextFrame( "Description", SubFrame, string.format( L["%s version %s for patch %s"], NS.title, NS.versionString, NS.releasePatch ), {
					setPoint = {
						{ "TOPLEFT", "$parent", "TOPLEFT", 8, -8 },
						{ "RIGHT", -8 },
					},
					fontObject = "GameFontRedSmall",
				} );
				NS.TextFrame( "SlashCommandsHeader", SubFrame, string.format( L["%sSlash Commands|r"], BATTLENET_FONT_COLOR_CODE ), {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -18 },
						{ "RIGHT", 0 },
					},
					fontObject = "GameFontNormalLarge",
				} );
				NS.TextFrame( "SlashCommands", SubFrame, string.format(
						L["%s/cs|r - Opens options frame to \"Options\"\n" ..
						"%s/cs buyouts|r - Opens options frame to \"Buyouts\"\n" ..
						"%s/cs getallscandata|r - Opens options frame to \"GetAll Scan Data\"\n" ..
						"%s/cs help|r - Opens options frame to \"Help\"\n" ..
						"%s/cs buyoutbuttonclick|r - Clicks the Buyout button on the Auction House tab.\n                                     Use in a Macro for fast key or mouse bound buying."],
						NORMAL_FONT_COLOR_CODE, NORMAL_FONT_COLOR_CODE, NORMAL_FONT_COLOR_CODE, NORMAL_FONT_COLOR_CODE, NORMAL_FONT_COLOR_CODE
					), {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -8 },
						{ "RIGHT", 0 },
					},
					fontObject = "GameFontHighlight",
				} );
				NS.TextFrame( "NeedMoreHelpHeader", SubFrame, string.format( L["%sNeed More Help?|r"], BATTLENET_FONT_COLOR_CODE ), {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -18 },
						{ "RIGHT", 0 },
					},
					fontObject = "GameFontNormalLarge",
				} );
				NS.TextFrame( "NeedMoreHelp", SubFrame, string.format(
						L["%sQuestions, Comments, Bugs, and Suggestions|r\n\n" ..
						"https://www.curseforge.com/wow/addons/collectionshop"],
						NORMAL_FONT_COLOR_CODE
					), {
					setPoint = {
						{ "TOPLEFT", "#sibling", "BOTTOMLEFT", 0, -8 },
						{ "RIGHT", 0 },
					},
					fontObject = "GameFontHighlight",
				} );
			end,
			Refresh			= function( SubFrame ) return end,
		},
	},
};
