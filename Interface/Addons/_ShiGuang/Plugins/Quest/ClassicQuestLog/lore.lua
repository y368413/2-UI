local cql = ClassicQuestLog

-- indexed by campaignID, whether the campaignID has lore
cql.lore.campaignHasLore = {}

-- I don't trust that Blizzard's pools will remain taint-free, so creating simple one here
cql.lore.fontstringPool = {}
cql.lore.texturePool = {}

function cql.lore:GetAvailableFontString(isHeader)
    for _,fontstring in ipairs(cql.lore.fontstringPool) do
        if not fontstring.used then
            fontstring.used = true
            return fontstring
        end
    end
    -- if we reached here, we need to create a new fontstring
    local fontstring = cql.lore.content:CreateFontString(nil,"ARTWORK","GameFontNormal")
    fontstring.used = true
    tinsert(cql.lore.fontstringPool,fontstring)
    return fontstring
end

function cql.lore:GetAvailableTexture()
    for _,texture in ipairs(cql.lore.texturePool) do
        if not texture.used then
            texture.used = true
            return texture
        end
    end
    -- if we reached here, we need to create a new dividing texture
    local texture = cql.lore.content:CreateTexture(nil,"ARTWORK")
    texture.used = true
    texture:SetHeight(16)
    texture:SetAtlas("Campaign-QuestLog-LoreDivider",true)
    tinsert(cql.lore.texturePool,texture)
    return texture
end

function cql.lore:FreePools()
    for _,fontstring in ipairs(cql.lore.fontstringPool) do
        fontstring.used = nil
        fontstring:ClearAllPoints()
        fontstring:Hide()
    end
    for _,texture in ipairs(cql.lore.texturePool) do
        texture.used = nil
        texture:ClearAllPoints()
        texture:Hide()
    end
end

-- lore is the campaign overview and takes up the same space as the detail
function cql.lore:SetLore(campaignID)
    cql:RegisterEvent("LORE_TEXT_UPDATED_CAMPAIGN")
    C_LoreText.RequestLoreTextForCampaignID(campaignID)
end

-- called from the LORE_TEXT_UPDATED_CAMPAIGN event handler, updates the lore (only if
-- lore is visible)
function cql.lore:Update(campaignID,lore)
    -- if campaignID not defined, get one from loreButton if it has one
    if not campaignID then
        if cql.loreButton.campaignID then
            cql.lore:SetLore(cql.loreButton.campaignID)
            return
        end
    end
    -- if campaignID was defined, make sure lore was too
    if not lore or type(lore)~="table" then return end
    cql.lore.campaignID = campaignID
    tinsert(lore,{text=" "}) -- add a line at the end to add some padding
    cql.lore:FreePools() -- wipe anything already on the page
    -- update faction-colored header the top
    local campaign = CampaignCache:Get(campaignID)
    cql.lore.content.headerTitle:SetText(campaign.name)
    cql.lore.content.headerProgress:SetText(CampaignUtil.BuildChapterProgressText(campaign))
    if UnitFactionGroup("player")=="Alliance" then
        cql.lore.content.headerBack:SetTexCoord(0.283203, 0.537109, 0.785156, 0.841797)
    else
        cql.lore.content.headerBack:SetTexCoord(0.283203, 0.537109, 0.84375, 0.900391)
    end
    -- add lore text using the fontstring/texture pools
    local yoff = -12
    local xoff = 16
    local lastObject = nil
    for index,info in ipairs(lore) do
        local fontstring = cql.lore:GetAvailableFontString()
        fontstring:SetPoint("TOPLEFT",lastObject or cql.lore.content,lastObject and "BOTTOMLEFT" or "TOPLEFT",lastObject and 0 or xoff,lastObject and yoff or -64)
        fontstring:SetPoint("TOPRIGHT",lastObject or cql.lore.content,lastObject and "BOTTOMRIGHT" or "TOPRIGHT",lastObject and 0 or -xoff,lastObject and yoff or -64)
        fontstring:SetText(info.text)
        if info.isHeader then
            info.text = "\n"..info.text
            fontstring:SetFontObject(Game13FontShadow)
            fontstring:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGBA())
            fontstring:SetJustifyH("CENTER")
            fontstring:SetJustifyV("BOTTOM")
            local texture = cql.lore:GetAvailableTexture()
            texture:SetPoint("BOTTOM",fontstring,"BOTTOM",0,-6)
            texture:SetWidth(250)
            texture:Show()
        else
            fontstring:SetFontObject(SystemFont_Shadow_Med1)
            fontstring:SetTextColor(LORE_TEXT_BODY_COLOR:GetRGBA())
            fontstring:SetJustifyH("LEFT")
            fontstring:SetJustifyV("TOP")
        end
        fontstring:Show()
        lastObject = fontstring
    end
end

--[[ lore button ]]

-- displays the lore button where the tag would be on the right of a button campaign header
function cql.lore:ShowLoreButton(parent)
    local info = parent and parent.index and cql.log.quests[parent.index] and cql.log.quests[parent.index]
    if info and info.isHeader and info.campaignID then
        cql.loreButton.campaignID = info.campaignID
        cql.loreButton.parent = parent
        -- if campaign has ever been seen with lore, then skip the check and immediately display the button
        if cql.lore.campaignHasLore[info.campaignID] then
            cql.lore:UpdateLoreButtonVisibility()
        else -- if campaign has not had lore seen, then check whether campaign has lore before showing button
            cql:RegisterEvent("LORE_TEXT_UPDATED_CAMPAIGN")
            C_LoreText.RequestLoreTextForCampaignID(info.campaignID)
            -- event handler for LORE_TEXT_UPDATED_CAMPAIGN will call UpdateLoreButtonVisibility
        end
    end
end

-- called from LORE_TEXT_UPDATED_CAMPAIGN event, when lore retrieved for a campaign ID
function cql.lore:UpdateLoreButtonVisibility()
    -- if mouse is still over the header with the campaign ID, and it has lore, show the button
    local parent = cql.loreButton.parent
    if GetMouseFocus()==parent then
        if cql.lore.campaignHasLore[cql.loreButton.campaignID] then
            cql.loreButton:SetParent(parent)
            cql.loreButton:SetPoint("RIGHT",parent,"RIGHT",3,0)
            cql.loreButton:Show()
            parent.tag:Hide()
        else
            parent.tag:Show()
        end
    end
end


-- periodically checks if it should hide itself and restore the tag it replaces
function cql.lore:LoreButtonOnUpdate()
    local focus = GetMouseFocus()
    local parent = self:GetParent()
    local info = parent and parent.index and cql.log.quests[parent.index]
    -- if we've moved off the original parent or we've scrolled off a campaign header
    if not info or (focus~=self and focus~=parent) or not (info.isHeader and info.campaignID) then
        self:Hide() -- hide the lore
        parent.tag:SetShown(info.isHeader and info.campaignID)
    end
end

-- click of lore button toggles the lore
function cql.lore:LoreButtonOnClick()
    if cql.mode=="lore" and cql.lore.campaignID==cql.loreButton.campaignID then
        cql:SetMode("detail")
        PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
    elseif cql.loreButton:IsVisible() and cql.loreButton:GetParent()~=nil then
        local info = cql.log.quests[cql.loreButton:GetParent().index]
        if info then
            cql.lore:SetLore(info.campaignID)
            cql:SetMode("lore")
            PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
        end
    end
end
