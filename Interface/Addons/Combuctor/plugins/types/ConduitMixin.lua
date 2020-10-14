CaerdonConduit = {}
CaerdonConduitMixin = {}

--[[static]] function CaerdonConduit:CreateFromCaerdonItem(caerdonItem)
	if type(caerdonItem) ~= "table" or not caerdonItem.GetCaerdonItemType then
		error("Usage: CaerdonConduit:CreateFromCaerdonItem(caerdonItem)", 2)
	end

    local itemType = CreateFromMixins(CaerdonConduitMixin)
    itemType.item = caerdonItem
    return itemType
end

function CaerdonConduitMixin:GetTypeInfo()
    local conduitTypes = { 
        Enum.SoulbindConduitType.Potency,
        Enum.SoulbindConduitType.Endurance,
        Enum.SoulbindConduitType.Finesse
    }

    local needsItem = true
    local conduitKnown = false
    for conduitTypeIndex = 1, #conduitTypes do
        if conduitKnown then break end

        local conduitCollection = C_Soulbinds.GetConduitCollection(conduitTypes[conduitTypeIndex])
        for conduitCollectionIndex = 1, #conduitCollection do
            local conduitData = conduitCollection[conduitCollectionIndex]
            if conduitData.conduitItemID == self.item:GetItemID() then
                conduitKnown = true
                break
            end
        end
    end

    if conduitKnown then
        -- TODO: May need to consider spec / class?  Not sure yet
        needsItem = false
    end

    return {
        needsItem = needsItem,
    }
end
