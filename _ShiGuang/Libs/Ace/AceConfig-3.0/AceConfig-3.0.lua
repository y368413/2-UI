--- AceConfig-3.0 wrapper library.
-- Provides an API to register an options table with the config registry,
-- as well as associate it with a slash command.
-- @class file
-- @name AceConfig-3.0
-- @release $Id: AceConfig-3.0.lua 1335 2024-05-05 19:35:16Z nevcairiel $

--[[
AceConfig-3.0

Very light wrapper library that combines all the AceConfig subcomponents into one more easily used whole.

]]

local cfgreg = LibStub("AceConfigRegistry-3.0")
local cfgcmd = LibStub("AceConfigCmd-3.0")

local MAJOR, MINOR = "AceConfig-3.0", 3
local AceConfig = LibStub:NewLibrary(MAJOR, MINOR)

if not AceConfig then return end
local pcall, error, type, pairs = pcall, error, type, pairs

function AceConfig:RegisterOptionsTable(appName, options, slashcmd)
	local ok,msg = pcall(cfgreg.RegisterOptionsTable, self, appName, options)
	if not ok then error(msg, 2) end
	
	if slashcmd then
		if type(slashcmd) == "table" then
			for _,cmd in pairs(slashcmd) do
				cfgcmd:CreateChatCommand(cmd, appName)
			end
		else
			cfgcmd:CreateChatCommand(slashcmd, appName)
		end
	end
end
