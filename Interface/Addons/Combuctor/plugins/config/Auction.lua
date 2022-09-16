CaerdonWardrobeConfigAuctionMixin = CreateFromMixins(CaerdonWardrobeConfigPanelMixin)


CAERDON_AUCTION_LABEL = "Auction"
CAERDON_AUCTION_SUBTEXT = "These are settings that apply to the auction house."

function CaerdonWardrobeConfigAuctionMixin:OnLoad()
    self.name = "拍卖行"  --Auction
    self.parent = "|cff00ff00[背包]|r属性增强"  --Caerdon Wardrobe
	self.options = {
        showLearnable = { text = "Show items learnable for current toon", tooltip = "Highlights items that can be learned and used for transmog by your current toon.", default = GetDefaultConfig().Icon.ShowLearnable.Auction and "1" or "0" },
        showLearnableByOther = { text = "Show items learnable for a different toon", tooltip = "Highlights items that can be learned and used for transmog but not by your current toon.", default = GetDefaultConfig().Icon.ShowLearnableByOther.Auction and "1" or "0" },
        showOldExpansion = { text = "Show old expansion icon", tooltip = "Highlights items from older expansions based on your General config.", default = GetDefaultConfig().Icon.ShowOldExpansion.Auction and "1" or "0" },
	}

	InterfaceOptionsPanel_OnLoad(self);
end
