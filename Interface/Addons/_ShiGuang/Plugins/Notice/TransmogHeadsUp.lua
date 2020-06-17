--## Author: Kalief   ## Version: 2.5   ## Notes: Writes a chat message if you pick up a BoE item with transmog that you havent collected yet
local TransmogHeadsUp = CreateFrame("FRAME", "AddonFrame");
TransmogHeadsUp:RegisterEvent("CHAT_MSG_LOOT");

local tooltip = CreateFrame('GameTooltip', 'TransmogTooltipScan', UIParent, 'GameTooltipTemplate')
local function ScanForTransmogState(itemLink)
	if itemLink:find('item:') then
		tooltip:ClearLines()
		tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		tooltip:SetHyperlink(itemLink)

		local TextLeft, text
		for i = 1, tooltip:NumLines() do
			TextLeft = _G['TransmogTooltipScanTextLeft'..i]
			if TextLeft and TextLeft:IsShown() then
				text = TextLeft:GetText()
				if text:match(TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN) then
					return 3 -- have not collected
				elseif text:match(TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN) then
					return 2 -- known by another item
				end
			end
		end
	end
	return 1
end

local function GetTransmogItemInfoByLink(itemLink)
	local item = GetItemInfoInstant(itemLink)
	if not item then return end
	return C_Transmog.GetItemInfo(item)
end

local function collectedApperance(itemLink)
	local _, _, usableSource = GetTransmogItemInfoByLink(itemLink)
	if not usableSource then return 4 end
	return ScanForTransmogState(itemLink)
end

TransmogHeadsUp:SetScript("OnEvent", function(self, event, ...)
	local message = select(1, ...);
	local playername = select(5, ...);  	--find playername
	local playername1  = UnitName("Player");
	local realmName = string.gsub(GetRealmName(), "%s+", "")
	local newPlayername = playername1 .. "-" .. realmName;
	if playername == newPlayername then		
		local itemID = message:match("|%x-|Hitem:(%d-):.-|h.-|h|r")	
		if(itemID ~= nil)then
		local ItemBoE = select(14,GetItemInfo(itemID));
		local ItemType = select(6,GetItemInfo(itemID));
		local ItemSlot = select(9,GetItemInfo(itemID));
		if ItemSlot == "INVTYPE_NECK" or ItemSlot == "INVTYPE_TRINKET" or ItemSlot == "INVTYPE_FINGER" or ItemSlot == "INVTYPE_RELIC" then return end
		--if not IsJewelery(ItemSlot) then  		--if its NOT jewelery
			if ItemBoE == 2 then
				local itemLink = select(2,GetItemInfo(itemID));         --find itemLink from ItemID
				local itemLinkString = string.match(itemLink, "item[%-?%d:]+")
				if not C_TransmogCollection.PlayerHasTransmog(itemID) then 
					local info = collectedApperance(itemLinkString);
---- 1 = has collected or not available to your class (basically: no info about transmog show in the tooltip for said item)
---- 2 = has apperance from another item
---- 3 = have not collected
---- 4 = unusable transmog ??
					if info == 3 then
						PlaySound(4147, "Master", false);
						--RaidNotice_AddMessage(RaidWarningFrame, "----------   "..TRANSMOGRIFY ..(itemLink or "").. "   ----------", ChatTypeInfo["RAID_WARNING"])
						UIErrorsFrame:AddMessage("----------   "..TRANSMOGRIFY.. itemLink .."   ----------")
						--print("|cffff0000 !!!!!NEW TRANSMOG: " .. itemLink .. "|cffff0000 !!!!!");
						--print("|cffff0000 !!!Dont forget to equip it!!!");
					elseif info == 2 then
						--print("|cffff0000 !!!!!" .. itemLink .. "|cffff0000 is a new transmog scource, but transmog allready known!!!!!");
						--print("|cffff0000 !Dont forget to equip it, if you are collecting all scources!");
					elseif info == 1 then
						--PlaySound(4147, "Master", false);
						print("|cffff0000 !!!!!"..NEW..TRANSMOGRIFY.. itemLink .. "|cffff0000 !!!!!");
						--print("|cffff0000 !Not available to your class, dont forget to mail to alt!");
					elseif info == 4 then
						--PlaySound(17341, "Master", false);
						--print(itemLink .. "??!!** ERROR: Unusable transmog **!!??");
						end
					else
						--print("|cffff0000 Transmog "  .. itemLink ..  " |cffff0000 allready known");
					end
				end
			end
		end
	--end
end);