CaerdonWardrobeConfigBankAndBagsMixin = CreateFromMixins(CaerdonWardrobeConfigPanelMixin)

CAERDON_BANKANDBAGS_LABEL = "Bank & Bags"
CAERDON_BANKANDBAGS_SUBTEXT = "These are settings that apply to your bank and bags."

function CaerdonWardrobeConfigBankAndBagsMixin:OnLoad()
    self.name = "背包&银行"  --Bank & Bags
    self.parent = "|cff00ff00[背包]|r属性增强"  --Caerdon Wardrobe
	self.options = {
        showLearnable = { text = "Show items learnable for current toon", tooltip = "Highlights items that can be learned and used for transmog by your current toon.", default = GetDefaultConfig().Icon.ShowLearnable.BankAndBags and "1" or "0" },
        showLearnableByOther = { text = "Show items learnable for a different toon", tooltip = "Highlights items that can be learned and used for transmog but not by your current toon.", default = GetDefaultConfig().Icon.ShowLearnableByOther.BankAndBags and "1" or "0" },
        showSellable = { text = "Show items that can probably be sold", tooltip = "Highlights items that are bound to you but not usable and can probably be sold.", default = GetDefaultConfig().Icon.ShowSellable.BankAndBags and "1" or "0" },
        showBindingText = { text = "Show binding text", tooltip = "Show binding text on items based on General configuration.", default = GetDefaultConfig().Binding.ShowStatus.BankAndBags and "1" or "0" },
	}

	InterfaceOptionsPanel_OnLoad(self);
end
