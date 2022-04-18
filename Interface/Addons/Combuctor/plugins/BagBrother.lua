local Brother = CreateFrame('Frame', 'BagBrother')
Brother:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
Brother:RegisterEvent('PLAYER_LOGIN')


--[[ Server Ready ]]--

function Brother:PLAYER_LOGIN()
	self:RemoveEvent('PLAYER_LOGIN')
	self:StartupCache()
	self:SetupEvents()
	self:UpdateData()
end

function Brother:StartupCache()
	local player, realm = UnitFullName('player')
	BrotherBags = BrotherBags or {}
	BrotherBags[realm] = BrotherBags[realm] or {}

	self.Realm = BrotherBags[realm]
	self.Realm[player] = self.Realm[player] or {equip = {}}
	self.Player = self.Realm[player]

	local player = self.Player
	player.faction = UnitFactionGroup('player') == 'Alliance'
	player.class = select(2, UnitClass('player'))
	player.race = select(2, UnitRace('player'))
	player.sex = UnitSex('player')
end

function Brother:SetupEvents()
	self:RegisterEvent('BAG_UPDATE')
	self:RegisterEvent('PLAYER_MONEY')
	self:RegisterEvent('GUILD_ROSTER_UPDATE')
	self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
	self:RegisterEvent('BANKFRAME_OPENED')
	self:RegisterEvent('BANKFRAME_CLOSED')

	if CanUseVoidStorage then
		self:RegisterEvent('VOID_STORAGE_OPEN')
		self:RegisterEvent('VOID_STORAGE_CLOSE')
	end

	if CanGuildBankRepair then
		self:RegisterEvent('GUILDBANKFRAME_OPENED')
		self:RegisterEvent('GUILDBANKFRAME_CLOSED')
		self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED')
	end
end

function Brother:UpdateData()
	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		self:BAG_UPDATE(i)
	end

	for i = 1, INVSLOT_LAST_EQUIPPED do
		self:PLAYER_EQUIPMENT_CHANGED(i)
	end

	if HasKey and HasKey() then
		self:BAG_UPDATE(KEYRING_CONTAINER)
	end

	self:GUILD_ROSTER_UPDATE()
	self:PLAYER_MONEY()
end


--[[ API ]]--

function Brother:RemoveEvent(event)
	self:UnregisterEvent(event)
	self[event] = nil
end

-------------------------------------------------------------

local NUM_VAULT_SLOTS = 80 * 2
local FIRST_BANK_SLOT = 1 + NUM_BAG_SLOTS
local LAST_BANK_SLOT = NUM_BANKBAGSLOTS + NUM_BAG_SLOTS

--[[ Continuous Events ]]--

function BagBrother:BAG_UPDATE(bag)
	if bag <= NUM_BAG_SLOTS then
  	self:SaveBag(bag, bag <= BACKPACK_CONTAINER, bag == BACKPACK_CONTAINER or bag == KEYRING_CONTAINER and HasKey and HasKey())
	end
end

function BagBrother:PLAYER_EQUIPMENT_CHANGED(slot)
	self:SaveEquip(slot)
end

function BagBrother:PLAYER_MONEY()
	self.Player.money = GetMoney()
end


--[[ Bank Events ]]--

function BagBrother:BANKFRAME_OPENED()
	self.atBank = true
end

function BagBrother:BANKFRAME_CLOSED()
	if self.atBank then
		for i = FIRST_BANK_SLOT, LAST_BANK_SLOT do
			self:SaveBag(i)
		end

		if REAGENTBANK_CONTAINER and IsReagentBankUnlocked() then
			self:SaveBag(REAGENTBANK_CONTAINER, true)
		end

		self:SaveBag(BANK_CONTAINER, true)
		self.atBank = nil
	end
end


--[[ Void Storage Events ]]--

function BagBrother:VOID_STORAGE_OPEN()
	self.atVault = true
end

function BagBrother:VOID_STORAGE_CLOSE()
	if self.atVault then
		self.Player.vault = {}
		self.atVault = nil

		for i = 1, NUM_VAULT_SLOTS do
			local id = GetVoidItemInfo(1, i)
    		self.Player.vault[i] = id and tostring(id) or nil
  		end
  	end
end


--[[ Guild Events ]]--

function BagBrother:GUILDBANKFRAME_OPENED()
	self.atGuild = true
end

function BagBrother:GUILDBANKFRAME_CLOSED()
	self.atGuild = nil
end

function BagBrother:GUILD_ROSTER_UPDATE()
	self.Player.guild = GetGuildInfo('player')
end

function BagBrother:GUILDBANKBAGSLOTS_CHANGED()
	if self.atGuild then
		local id = GetGuildInfo('player') .. '*'
		local guild = self.Realm[id] or {}
		guild.faction = UnitFactionGroup('player') == 'Alliance'

		for i = 1, GetNumGuildBankTabs() do
			guild[i] = guild[i] or {}
			guild[i].name, guild[i].icon, guild[i].view = GetGuildBankTabInfo(i)
		end

		local tab = GetCurrentGuildBankTab()
		local items = guild[tab]
		if items then
			items.deposit, items.withdraw, items.remaining = select(4, GetGuildBankTabInfo(tab))

			for i = 1, 98 do
				local link = GetGuildBankItemLink(tab, i)
				local _, count = GetGuildBankItemInfo(tab, i)

				items[i] = self:ParseItem(link, count)
			end
		end

		self.Realm[id] = guild
	end
end

--------------------------------------------------------------------

function BagBrother:SaveBag(bag, onlyItems, saveSize)
	local size = GetContainerNumSlots(bag)
	if size > 0 then
		local items = {}
		--local pets = {}
		for slot = 1, size do
			local _, count, _,_,_,_, link = GetContainerItemInfo(bag, slot)
			--[[if link then
				local itemID = tonumber(link:match("item:(%d+)"))
				if itemID == nil then
					local _, speciesID, level, breedQuality, maxHealth, power, speed, battlePetID = strsplit(":", link)
					if speciesID then
						count = 1
					end
				end
			end]]
			items[slot] = self:ParseItem(link, count)
		end

		if not onlyItems then
			self:SaveEquip(ContainerIDToInventoryID(bag), size)
		elseif saveSize then
			items.size = size
		end

		self.Player[bag] = items
	else
		self.Player[bag] = nil
	end
end

function BagBrother:SaveEquip(i, count)
	local link = GetInventoryItemLink('player', i)
	local count = count or GetInventoryItemCount('player', i)

	self.Player.equip[i] = self:ParseItem(link, count)
end

function BagBrother:ParseItem(link, count)
	if link then
		local id = tonumber(link:match('item:(%d+):')) -- check for profession window bug
		if id == 0 and TradeSkillFrame then
			local focus = GetMouseFocus():GetName()

			if focus == 'TradeSkillSkillIcon' then
				link = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill)
			else
				local i = focus:match('TradeSkillReagent(%d+)')
				if i then
					link = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, tonumber(i))
				end
			end
		end

		if link:find('0:0:0:0:0:%d+:%d+:%d+:0:0') then
			link = link:match('|H%l+:(%d+)')
		else
			link = link:match('|H%l+:([%d:]+)')
		end

		if count and count > 1 then
			link = link .. ';' .. count
		end

		return link
	end
end


local Interface = LibStub:NewLibrary('BagBrotherInterface', 1)
Interface.IsItemCache = true


--[[ Realms ]]--

function Interface:GetPlayers(realm)
  local realm = BrotherBags[realm] or {}
  local owner

  return function()
    while true do
      owner = next(realm, owner)

      if not owner or not owner:find('*$') then
        return owner
      end
    end
  end
end

function Interface:GetGuilds(realm)
  local realm = BrotherBags[realm] or {}
  local owner

  return function()
    while true do
      owner = next(realm, owner)

      if not owner or owner:find('*$') then
        return owner and owner:sub(1,-2)
      end
    end
  end
end


--[[ Owners ]]--

function Interface:GetPlayer(realm, owner)
  realm = BrotherBags[realm]
  owner = realm and realm[owner]

  return owner and {
    money = owner.money,
    class = owner.class,
    race = owner.race,
    guild = owner.guild,
    gender = owner.sex,
    faction = owner.faction and 'Alliance' or 'Horde' }
end

function Interface:DeletePlayer(realm, name)
    realm = BrotherBags[realm]
    if realm then
      realm[name] = nil
    end
end

function Interface:GetGuild(realm, name)
  return Interface:GetPlayer(realm, name .. '*')
end

function Interface:DeleteGuild(realm, name)
  return Interface:DeletePlayer(realm, name .. '*')
end


--[[ Bags ]]--

function Interface:GetBag(realm, player, bag)
  if tonumber(bag) then
    local slot = bag > 0 and ContainerIDToInventoryID(bag)
    if slot then
      return Interface:GetItem(realm, player, 'equip', slot)
    else
      realm = BrotherBags[realm]
      player = realm and realm[player]
      bag = player and player[bag]

      return bag and {
        owned = true,
        count = bag.size }
    end
  end
end

function Interface:GetGuildTab(realm, guild, tab)
  realm = BrotherBags[realm]
  guild = realm and realm[guild .. '*']
  tab = guild and guild[tab]

  return tab and {
    name = tab.name,
    icon = tab.icon,
    viewable = tab.view,
    deposit = tab.deposit,
    withdraw = tab.withdraw,
    remaining = tab.remaining }
end


--[[ Items ]]--

function Interface:GetItem(realm, owner, bag, slot)
  realm = BrotherBags[realm]
  owner = realm and realm[owner]
  bag = owner and owner[bag]

  local item = bag and bag[slot]
  if item then
    local link, count = strsplit(';', item)
    return {link = link, count = tonumber(count)}
  end
end

function Interface:GetGuildItem(realm, name, tab, slot)
  return Interface:GetItem(realm, name .. '*', tab, slot)
end
