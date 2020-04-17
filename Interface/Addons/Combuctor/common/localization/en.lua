--[[
	English Localization (default)
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'enUS', true, 'raw')

--keybindings
L.ToggleBags = 'Toggle Inventory'
L.ToggleBank = 'Toggle Bank'
L.ToggleGuild = 'Toggle Guild Bank'
L.ToggleVault = 'Toggle Void Storage'

--terminal
L.Commands = 'command list'
L.CmdShowInventory = 'Toggles your inventory'
L.CmdShowBank = 'Toggles your bank'
L.CmdShowGuild = 'Toggles your guild bank'
L.CmdShowVault = 'Toggles your void storage'
L.CmdShowVersion = 'Prints the current verison'
L.CmdShowOptions = 'Opens the configuration menu'
L.Updated = 'Updated to v%s'

--frame titles
L.TitleBags = '%s\'s Inventory'
L.TitleBank = '%s\'s Bank'
L.TitleVault = '%s\'s Void Storage'

--dropdowns
L.TitleFrames = '%s Frames'
L.SelectCharacter = 'Select Character'
L.ConfirmDelete = 'Are you sure you want to delete   %s\'s cached data?'

--interactions
L.Click = 'Click'
L.Drag = '<Drag>'
L.LeftClick = '<Left-Click>'
L.RightClick = '<Right-Click>'
L.DoubleClick = '<Double-Click>'
L.ShiftClick = '<Shift-Click>'

--tooltips
L.Total = 'Total'
L.GuildFunds = 'Guild Funds'
L.TipGoldOnRealm = '%s Totals'
L.NumWithdraw = '%d withdraw'
L.NumDeposit = '%d deposit'
L.NumRemainingWithdrawals = '%d Withdrawals Remaining'

--action tooltips
L.TipChangePlayer = '%s to view another character\'s items.'
L.TipCleanItems = '%s to clean items.'
L.TipConfigure = '%s to configure this window.'
L.TipDepositReagents = '%s to deposit reagents at the bank.'
L.TipDeposit = '%s to deposit.'
L.TipWithdraw = '%s to withdraw (%s remaining).'
L.TipFrameToggle = '%s to toggle other windows.'
L.TipHideBag = '%s to hide this bag.'
L.TipHideBags = '%s to hide the bags display.'
L.TipHideSearch = '%s to stop searching.'
L.TipMove = '%s to move.'
L.TipPurchaseBag = '%s to purchase this bank slot.'
L.TipResetPlayer = '%s to return to the current character.'
L.TipShowBag = '%s to show this bag.'
L.TipShowBags = '%s to show the bags display.'
L.TipShowBank = '%s to toggle your bank.'
L.TipShowInventory = '%s to toggle your inventory.'
L.TipShowOptions = '%s to open the options menu.'
L.TipShowSearch = '%s to search.'

--item tooltips
L.TipCountEquip = 'Equipped: %d'
L.TipCountBags = 'Bags: %d'
L.TipCountBank = 'Bank: %d'
L.TipCountVault = 'Vault: %d'
L.TipCountGuild = 'Guild: %d'
L.TipDelimiter = '|'

--dialogs
L.AskMafia = 'Ask Mafia'
L.ConfirmTransfer = 'Depositing any items will remove all modifications and make them non-tradeable and non-refundable.|n|nDo you wish to continue?'
L.CannotPurchaseVault = 'You do not have enough money to unlock the Void Storage service|n|n|cffff2020Cost: %s|r'
L.PurchaseVault = 'Would you like to unlock the Void Storage service?|n|n|cffffd200Cost:|r %s'


-- general
L.GeneralOptionsDesc = 'These are general features that can be toggled depending on your preferences.'
L.Locked = 'Lock Frames'
L.Fading = 'Fading Effects'
L.TipCount = 'Tooltip Item Count'
L.CountGuild = 'Include Guild Banks'
L.FlashFind = 'Flash Find'
L.DisplayBlizzard = 'Fallback Hidden Bags'
L.DisplayBlizzardTip = 'If enabled, the default Blizzard UI bag panels will be displayed for hidden inventory or bank containers.\n\n|cffff1919Requires UI reload.|r'
L.ConfirmGlobals = 'Are you sure you want to disable specific settings for this character? All specific settings will be lost.'
L.CharacterSpecific = 'Character Specific Settings'

-- frame
L.FrameOptions = 'Frame Settings'
L.FrameOptionsDesc = 'These are configuration settings specific to a %s frame.'
L.Frame = 'Frame'
L.Enabled = 'Enable Frame'
L.EnabledTip = 'If disabled, the default Blizzard UI will not be replaced for this frame.\n\n|cffff1919Requires UI reload.|r'
L.ActPanel = 'Act as Standard Panel'
L.ActPanelTip = [[
If enabled, this panel will automatically position
itself as the standard ones do, such as the |cffffffffSpellbook|r
or the |cffffffffDungeon Finder|r, and will not be movable.]]

L.BagToggle = 'Bags Toggle'
L.Money = 'Money'
L.Broker = 'Databroker Plugins'
L.Sort = 'Sort Button'
L.Search = 'Search Toggle'
L.Options = 'Options Button'
L.ExclusiveReagent = 'Separate Reagent Bank'
L.LeftTabs = 'Rulesets on Left'
L.LeftTabsTip = [[
If enabled, the side tabs will be
displayed on the left side of the panel.]]

L.Appearance = 'Appearance'
L.Layer = 'Layer'
L.BagBreak = 'Bag Break'
L.ReverseBags = 'Reverse Bag Order'
L.ReverseSlots = 'Reverse Slot Order'

L.Color = 'Background Color'
L.BorderColor = 'Border Color'

L.Strata = 'Frame Layer'
L.Columns = 'Columns'
L.Scale = 'Scale'
L.ItemScale = 'Item Scale'
L.Spacing = 'Spacing'
L.Alpha = 'Opacity'

-- auto display
L.DisplayOptions = 'Automatic Display'
L.DisplayOptionsDesc = 'These settings allow you to configure when your inventory automatically opens or closes due to game events.'
L.DisplayInventory = 'Display Inventory'
L.CloseInventory = 'Close Inventory'

L.DisplayBank = 'At the Bank'
L.DisplayGuildbank = 'At the Guild Bank'
L.DisplayAuction = 'At the Auction House'
L.DisplayMail = 'At a Mailbox'
L.DisplayTrade = 'Trading Items'
L.DisplayScrapping = 'Scrapping Gear'
L.DisplayGems = 'Socketing Items'
L.DisplayCraft = 'Crafting'
L.DisplayPlayer = 'Opening the Character Info'

L.CloseCombat = 'Entering Combat'
L.CloseVehicle = 'Entering a Vehicle'
L.CloseBank = 'Leaving the Bank'
L.CloseVendor = 'Leaving a Vendor'
L.CloseMap = 'Opening the World Map'

-- colors
L.ColorOptions = 'Color Settings'
L.ColorOptionsDesc = 'These settings allow you to change how item slots are presented on %s frames for easier identification.'
L.GlowQuality = 'Color by Quality'
L.GlowQuest = 'Color Quest Items'
L.GlowUnusable = 'Color Unusable Items'
L.GlowSets = 'Color Equipment Sets'
L.GlowNew = 'Flash New Items'
L.GlowPoor = 'Mark Poor Items'
L.GlowAlpha = 'Glow Brightness'

L.EmptySlots = 'Display Background'
L.ColorSlots = 'Color by Bag Type'
L.NormalColor = 'Normal Color'
L.KeyColor = 'Key Color'
L.QuiverColor = 'Quiver Color'
L.SoulColor = 'Soul Bag Color'
L.ReagentColor = 'Reagent Bank Color'
L.LeatherColor = 'Leatherworking Color'
L.InscribeColor = 'Inscription Color'
L.HerbColor = 'Herbalism Color'
L.EnchantColor = 'Enchanting Color'
L.EngineerColor = 'Engineering Color'
L.GemColor = 'Gem Color'
L.MineColor = 'Mining Color'
L.TackleColor = 'Tackle Box Color'
L.FridgeColor = 'Refrigerator Color'

-- rulesets
L.RuleOptions = 'Item Rulesets'
L.RuleOptionsDesc = 'These settings allow you to choose which item rulesets to display and in which order.'
