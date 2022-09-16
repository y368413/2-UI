CaerdonWardrobeConfigMerchantMixin = CreateFromMixins(CaerdonWardrobeConfigPanelMixin)
CAERDON_MERCHANT_LABEL = "Merchant"
CAERDON_MERCHANT_SUBTEXT = "These are settings that apply to vendors."

function CaerdonWardrobeConfigMerchantMixin:OnLoad()
    self.name = "商店"  --Merchant
    self.parent = "|cff00ff00[背包]|r属性增强"  --Caerdon Wardrobe
	self.options = {
        showLearnable = { text = "Show items learnable for current toon", tooltip = "Highlights items that can be learned and used for transmog by your current toon.", default = GetDefaultConfig().Icon.ShowLearnable.Merchant and "1" or "0" },
        showLearnableByOther = { text = "Show items learnable for a different toon", tooltip = "Highlights items that can be learned and used for transmog but not by your current toon.", default = GetDefaultConfig().Icon.ShowLearnableByOther.Merchant and "1" or "0" },
        showBindingText = { text = "Show binding text", tooltip = "Show binding text on items based on General configuration.", default = GetDefaultConfig().Binding.ShowStatus.Merchant and "1" or "0" },
	}

	InterfaceOptionsPanel_OnLoad(self);
end
