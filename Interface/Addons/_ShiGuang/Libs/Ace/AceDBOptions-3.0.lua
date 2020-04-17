local ACEDBO_MAJOR, ACEDBO_MINOR = "AceDBOptions-3.0", 15
local AceDBOptions = LibStub:NewLibrary(ACEDBO_MAJOR, ACEDBO_MINOR)

if not AceDBOptions then return end -- No upgrade needed

-- Lua APIs
local pairs, next = pairs, next

-- WoW APIs
local UnitClass = UnitClass


AceDBOptions.optionTables = AceDBOptions.optionTables or {}
AceDBOptions.handlers = AceDBOptions.handlers or {}

local L = {
	choose = "Existing Profiles",
	choose_desc = "You can either create a new profile by entering a name in the editbox, or choose one of the already existing profiles.",
	choose_sub = "Select one of your currently available profiles.",
	copy = "Copy From",
	copy_desc = "Copy the settings from one existing profile into the currently active profile.",
	current = "Current Profile:",
	default = "Default",
	delete = "Delete a Profile",
	delete_confirm = "Are you sure you want to delete the selected profile?",
	delete_desc = "Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file.",
	delete_sub = "Deletes a profile from the database.",
	intro = "You can change the active database profile, so you can have different settings for every character.",
	new = "New",
	new_sub = "Create a new empty profile.",
	profiles = "Profiles",
	profiles_sub = "Manage Profiles",
	reset = "Reset Profile",
	reset_desc = "Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over.",
	reset_sub = "Reset the current profile to the default",
}

if GetLocale() == "zhTW" then
	L["choose"] = "現有的設定檔"
	L["choose_desc"] = "您可以在文字方塊內輸入名字以建立新的設定檔，或是選擇一個現有的設定檔使用。"
	L["choose_sub"] = "從當前可用的設定檔裡面選擇一個。"
	L["copy"] = "複製自"
	L["copy_desc"] = "從一個現有的設定檔，將設定複製到現在使用中的設定檔。"
	L["current"] = "目前設定檔："
	L["default"] = "預設"
	L["delete"] = "刪除一個設定檔"
	L["delete_confirm"] = "確定要刪除所選擇的設定檔嗎？"
	L["delete_desc"] = "從資料庫裡刪除不再使用的設定檔，以節省空間，並且清理 SavedVariables 檔案。"
	L["delete_sub"] = "從資料庫裡刪除一個設定檔。"
	L["intro"] = "您可以從資料庫中選擇一個設定檔來使用，如此就可以讓每個角色使用不同的設定。"
	L["new"] = "新建"
	L["new_sub"] = "新建一個空的設定檔。"
	L["profiles"] = "設定檔"
	L["profiles_sub"] = "管理設定檔"
	L["reset"] = "重置設定檔"
	L["reset_desc"] = "將現用的設定檔重置為預設值；用於設定檔損壞，或者單純想要重來的情況。"
	L["reset_sub"] = "將目前的設定檔重置為預設值"
elseif GetLocale() == "zhCN" then
	L["choose"] = "现有的配置文件"
	L["choose_desc"] = "你可以通过在文本框内输入一个名字创立一个新的配置文件，也可以选择一个已经存在的配置文件。"
	L["choose_sub"] = "从当前可用的配置文件里面选择一个。"
	L["copy"] = "复制自"
	L["copy_desc"] = "从当前某个已保存的配置文件复制到当前正使用的配置文件。"
	L["current"] = "当前配置文件："
	L["default"] = "默认"
	L["delete"] = "删除一个配置文件"
	L["delete_confirm"] = "你确定要删除所选择的配置文件么？"
	L["delete_desc"] = "从数据库里删除不再使用的配置文件，以节省空间，并且清理SavedVariables文件。"
	L["delete_sub"] = "从数据库里删除一个配置文件。"
	L["intro"] = "你可以选择一个活动的数据配置文件，这样你的每个角色就可以拥有不同的设置值，可以给你的插件配置带来极大的灵活性。"
	L["new"] = "新建"
	L["new_sub"] = "新建一个空的配置文件。"
	L["profiles"] = "配置文件"
	L["profiles_sub"] = "管理配置文件"
	L["reset"] = "重置配置文件"
	L["reset_desc"] = "将当前的配置文件恢复到它的默认值，用于你的配置文件损坏，或者你只是想重来的情况。"
	L["reset_sub"] = "将当前的配置文件恢复为默认值"
else
	L["choose"] = "Existing Profiles"
	L["choose_desc"] = "You can either create a new profile by entering a name in the editbox, or choose one of the already existing profiles."
	L["choose_sub"] = "Select one of your currently available profiles."
	L["copy"] = "Copy From"
	L["copy_desc"] = "Copy the settings from one existing profile into the currently active profile."
	L["current"] = "Current Profile:"
	L["default"] = "Default"
	L["delete"] = "Delete a Profile"
	L["delete_confirm"] = "Are you sure you want to delete the selected profile?"
	L["delete_desc"] = "Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file."
	L["delete_sub"] = "Deletes a profile from the database."
	L["intro"] = "You can change the active database profile, so you can have different settings for every character."
	L["new"] = "New"
	L["new_sub"] = "Create a new empty profile."
	L["profiles"] = "Profiles"
	L["profiles_sub"] = "Manage Profiles"
	L["reset"] = "Reset Profile"
	L["reset_desc"] = "Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."
	L["reset_sub"] = "Reset the current profile to the default"
end

local defaultProfiles
local tmpprofiles = {}

local function getProfileList(db, common, nocurrent)
	local profiles = {}
	
	-- copy existing profiles into the table
	local currentProfile = db:GetCurrentProfile()
	for i,v in pairs(db:GetProfiles(tmpprofiles)) do 
		if not (nocurrent and v == currentProfile) then 
			profiles[v] = v 
		end 
	end
	
	-- add our default profiles to choose from ( or rename existing profiles)
	for k,v in pairs(defaultProfiles) do
		if (common or profiles[k]) and not (nocurrent and k == currentProfile) then
			profiles[k] = v
		end
	end
	
	return profiles
end

local OptionsHandlerPrototype = {}

--[[ Reset the profile ]]
function OptionsHandlerPrototype:Reset()
	self.db:ResetProfile()
end

--[[ Set the profile to value ]]
function OptionsHandlerPrototype:SetProfile(info, value)
	self.db:SetProfile(value)
end

--[[ returns the currently active profile ]]
function OptionsHandlerPrototype:GetCurrentProfile()
	return self.db:GetCurrentProfile()
end

function OptionsHandlerPrototype:ListProfiles(info)
	local arg = info.arg
	local profiles
	if arg == "common" and not self.noDefaultProfiles then
		profiles = getProfileList(self.db, true, nil)
	elseif arg == "nocurrent" then
		profiles = getProfileList(self.db, nil, true)
	elseif arg == "both" then -- currently not used
		profiles = getProfileList(self.db, (not self.noDefaultProfiles) and true, true)
	else
		profiles = getProfileList(self.db)
	end
	
	return profiles
end

function OptionsHandlerPrototype:HasNoProfiles(info)
	local profiles = self:ListProfiles(info)
	return ((not next(profiles)) and true or false)
end

--[[ Copy a profile ]]
function OptionsHandlerPrototype:CopyProfile(info, value)
	self.db:CopyProfile(value)
end

--[[ Delete a profile from the db ]]
function OptionsHandlerPrototype:DeleteProfile(info, value)
	self.db:DeleteProfile(value)
end

--[[ fill defaultProfiles with some generic values ]]
local function generateDefaultProfiles(db)
	defaultProfiles = {
		["Default"] = L["default"],
		[db.keys.char] = db.keys.char,
		[db.keys.realm] = db.keys.realm,
		[db.keys.class] = UnitClass("player")
	}
end

--[[ create and return a handler object for the db, or upgrade it if it already existed ]]
local function getOptionsHandler(db, noDefaultProfiles)
	if not defaultProfiles then
		generateDefaultProfiles(db)
	end
	
	local handler = AceDBOptions.handlers[db] or { db = db, noDefaultProfiles = noDefaultProfiles }
	
	for k,v in pairs(OptionsHandlerPrototype) do
		handler[k] = v
	end
	
	AceDBOptions.handlers[db] = handler
	return handler
end

local optionsTable = {
	desc = {
		order = 1,
		type = "description",
		name = L["intro"] .. "\n",
	},
	descreset = {
		order = 9,
		type = "description",
		name = L["reset_desc"],
	},
	reset = {
		order = 10,
		type = "execute",
		name = L["reset"],
		desc = L["reset_sub"],
		func = "Reset",
	},
	current = {
		order = 11,
		type = "description",
		name = function(info) return L["current"] .. " " .. NORMAL_FONT_COLOR_CODE .. info.handler:GetCurrentProfile() .. FONT_COLOR_CODE_CLOSE end,
		width = "default",
	},
	choosedesc = {
		order = 20,
		type = "description",
		name = "\n" .. L["choose_desc"],
	},
	new = {
		name = L["new"],
		desc = L["new_sub"],
		type = "input",
		order = 30,
		get = false,
		set = "SetProfile",
	},
	choose = {
		name = L["choose"],
		desc = L["choose_sub"],
		type = "select",
		order = 40,
		get = "GetCurrentProfile",
		set = "SetProfile",
		values = "ListProfiles",
		arg = "common",
	},
	copydesc = {
		order = 50,
		type = "description",
		name = "\n" .. L["copy_desc"],
	},
	copyfrom = {
		order = 60,
		type = "select",
		name = L["copy"],
		desc = L["copy_desc"],
		get = false,
		set = "CopyProfile",
		values = "ListProfiles",
		disabled = "HasNoProfiles",
		arg = "nocurrent",
	},
	deldesc = {
		order = 70,
		type = "description",
		name = "\n" .. L["delete_desc"],
	},
	delete = {
		order = 80,
		type = "select",
		name = L["delete"],
		desc = L["delete_sub"],
		get = false,
		set = "DeleteProfile",
		values = "ListProfiles",
		disabled = "HasNoProfiles",
		arg = "nocurrent",
		confirm = true,
		confirmText = L["delete_confirm"],
	},
}

function AceDBOptions:GetOptionsTable(db, noDefaultProfiles)
	local tbl = AceDBOptions.optionTables[db] or {
			type = "group",
			name = L["profiles"],
			desc = L["profiles_sub"],
		}
	
	tbl.handler = getOptionsHandler(db, noDefaultProfiles)
	tbl.args = optionsTable

	AceDBOptions.optionTables[db] = tbl
	return tbl
end

-- upgrade existing tables
for db,tbl in pairs(AceDBOptions.optionTables) do
	tbl.handler = getOptionsHandler(db)
	tbl.args = optionsTable
end
