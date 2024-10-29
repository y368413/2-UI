local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	TradePlayerEnchantInset:Hide()
	TradePlayerItemsInset:Hide()
	TradeRecipientEnchantInset:Hide()
	TradeRecipientItemsInset:Hide()
	TradePlayerInputMoneyInset:Hide()
	TradeRecipientMoneyInset:Hide()
	TradeRecipientBG:Hide()
	TradeRecipientMoneyBg:Hide()
	TradeRecipientBotLeftCorner:Hide()
	TradeRecipientLeftBorder:Hide()
	select(4, TradePlayerItem7:GetRegions()):Hide()
	select(4, TradeRecipientItem7:GetRegions()):Hide()

	M.ReskinPortraitFrame(TradeFrame)
	TradeFrame.RecipientOverlay:Hide()
	M.Reskin(TradeFrameTradeButton)
	M.Reskin(TradeFrameCancelButton)
	M.ReskinInput(TradePlayerInputMoneyFrameGold)
	M.ReskinInput(TradePlayerInputMoneyFrameSilver)
	M.ReskinInput(TradePlayerInputMoneyFrameCopper)

	TradePlayerInputMoneyFrameSilver:SetPoint("LEFT", TradePlayerInputMoneyFrameGold, "RIGHT", 1, 0)
	TradePlayerInputMoneyFrameCopper:SetPoint("LEFT", TradePlayerInputMoneyFrameSilver, "RIGHT", 1, 0)

	local function reskinButton(bu)
		bu:SetNormalTexture(0)
		bu:SetPushedTexture(0)
		local hl = bu:GetHighlightTexture()
		hl:SetColorTexture(1, 1, 1, .25)
		hl:SetInside()
		bu.icon:SetTexCoord(unpack(I.TexCoord))
		bu.icon:SetInside()
		bu.IconOverlay:SetInside()
		bu.IconOverlay2:SetInside()
		bu.bg = M.CreateBDFrame(bu.icon, .25)
		M.ReskinIconBorder(bu.IconBorder)
	end

	for i = 1, MAX_TRADE_ITEMS do
		_G["TradePlayerItem"..i.."SlotTexture"]:Hide()
		_G["TradePlayerItem"..i.."NameFrame"]:Hide()
		_G["TradeRecipientItem"..i.."SlotTexture"]:Hide()
		_G["TradeRecipientItem"..i.."NameFrame"]:Hide()

		reskinButton(_G["TradePlayerItem"..i.."ItemButton"])
		reskinButton(_G["TradeRecipientItem"..i.."ItemButton"])
	end

	local tradeHighlights = {
		TradeHighlightPlayer,
		TradeHighlightPlayerEnchant,
		TradeHighlightRecipient,
		TradeHighlightRecipientEnchant,
	}
	for _, highlight in pairs(tradeHighlights) do
		M.StripTextures(highlight)
		highlight:SetFrameStrata("HIGH")
		local bg = M.CreateBDFrame(highlight, 1)
		bg:SetBackdropColor(0, 1, 0, .15)
	end
end)