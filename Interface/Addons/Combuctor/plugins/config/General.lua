CaerdonWardrobeConfigGeneralMixin = CreateFromMixins(CaerdonWardrobeConfigPanelMixin)

CAERDON_GENERAL_LABEL = "General"
CAERDON_GENERAL_SUBTEXT = "These are general settings that apply broadly to Caerdon Wardrobe."

CAERDON_GENERAL_ICON_CONFIG = "Icon Configuration"
CAERDON_GENERAL_ICON_CONFIG_POSITION = "Icon Position:"

CAERDON_GENERAL_SHOW_OLD_EXPANSION = "Show Old Expansion Items:"

CAERDON_GENERAL_BINDING_CONFIG = "Binding Text Configuration"
CAERDON_GENERAL_BINDING_CONFIG_POSITION = "Binding Position:"

function CaerdonWardrobeConfigGeneralMixin:OnLoad()
    self.name = "通用"  --General
    self.parent = "|cff00ff00[背包]|r属性增强"  --Caerdon Wardrobe
	self.options = {
        enableDebug = { text = "Enable Debug", tooltip = "Enables debugging info in tooltips", default = GetDefaultConfig().Debug.Enabled and "1" or "0" },
        enableIconAnimation = { text = "Show Icon Animation", tooltip = "Turns icon animation on / off (largely in unlearned and openable items)", default = GetDefaultConfig().Icon.EnableAnimation and "1" or "0" },
        iconPosition = { text = "Select Icon Position", tooltip = "Configures placement of the primary collectible icon", default = "TOPLEFT" },
        sameLookDifferentItem = { text = "Include different items w/ the same look (you completionist, you)", tooltip = "Ensures that you learn every single item that provides the same exact appearance for no other reason than you know you don't have that one.", default = GetDefaultConfig().Icon.ShowLearnable.SameLookDifferentItem and "1" or "0" },
        sameLookDifferentLevel = { text = "Including identical items w/ lower levels", tooltip = "Enable this to ensure that an item will show as learnable if the item's level would allow a lower level toon to use it for transmog than the one you already know.", default = GetDefaultConfig().Icon.ShowLearnable.SameLookDifferentLevel and "1" or "0" },
        showOldExpansionReagents = { text = "Reagents", tooltip = "Add an icon to reagents from older expansions", default = GetDefaultConfig().Icon.ShowOldExpansion.Reagents and "1" or "0"},
        showOldExpansionUsable = { text = "Usable Items", tooltip = "Add an icon to usable items from older expansions", default = GetDefaultConfig().Icon.ShowOldExpansion.Usable and "1" or "0"},
        showOldExpansionOther = { text = "Other Items", tooltip = "Add an icon to any other items from older expansions", default = GetDefaultConfig().Icon.ShowOldExpansion.Other and "1" or "0"},
        showOldExpansionUnknown = { text = "Unknown Expansion", tooltip = "Add an icon to items that didn't indicate what expansion they were from.  This happens more often than I'd like to see, and it's probably not a super useful option (other than maybe for WoW devs that need to fix this.)", default = GetDefaultConfig().Icon.ShowOldExpansion.Unknown and "1" or "0"},
        showQuestItems = { text = "Show Quest Items", tooltip = "Adds an icon to any items that are tied to a quest", default = GetDefaultConfig().Icon.ShowQuestItems and "1" or "0"},
        showGearSetsAsIcon = { text = "Show Gear Set Icon", tooltip = "Show an icon on items associated with a gear set", default = GetDefaultConfig().Binding.ShowGearSetsAsIcon and "1" or "0"},
        showBoA = { text = "Show Bind on Account", tooltip = "Shows BoA on items that are bind on account", default = GetDefaultConfig().Binding.ShowBoA and "1" or "0"},
        showBoE = { text = "Show Bind on Equip", tooltip = "Shows BoE on items that are bind on equip", default = GetDefaultConfig().Binding.ShowBoE and "1" or "0"},
        showGearSets = { text = "Show Gear Sets", tooltip = "Shows gear set text on items associated with a gear set", default = GetDefaultConfig().Binding.ShowGearSets and "1" or "0"},
        bindingPosition = { text = "Select Binding Position", tooltip = "Configures placement of the binding text", default = "BOTTOM"},
	}

	InterfaceOptionsPanel_OnLoad(self);
end
