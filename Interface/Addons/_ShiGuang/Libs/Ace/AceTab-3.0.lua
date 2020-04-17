local ACETAB_MAJOR, ACETAB_MINOR = 'AceTab-3.0', 9
local AceTab, oldminor = LibStub:NewLibrary(ACETAB_MAJOR, ACETAB_MINOR)

if not AceTab then return end -- No upgrade needed

AceTab.registry = AceTab.registry or {}

-- local upvalues
local _G = _G
local pairs = pairs
local ipairs = ipairs
local type = type
local registry = AceTab.registry

local strfind = string.find
local strsub = string.sub
local strlower = string.lower
local strformat = string.format
local strmatch = string.match

local function printf(...)
	DEFAULT_CHAT_FRAME:AddMessage(strformat(...))
end

local function getTextBeforeCursor(this, start)
	return strsub(this:GetText(), start or 1, this:GetCursorPosition())
end

-- Hook OnTabPressed and OnTextChanged for the frame, give it an empty matches table, and set its curMatch to 0, if we haven't done so already.
local function hookFrame(f)
	if f.hookedByAceTab3 then return end
	f.hookedByAceTab3 = true
	if f == ChatEdit_GetActiveWindow() then
		local origCTP = ChatEdit_CustomTabPressed
		function ChatEdit_CustomTabPressed(...)
			if AceTab:OnTabPressed(f) then
				return origCTP(...)
			else
				return true
			end
		end
	else
		local origOTP = f:GetScript('OnTabPressed')
		if type(origOTP) ~= 'function' then
			origOTP = function() end
		end
		f:SetScript('OnTabPressed', function(...)
			if AceTab:OnTabPressed(f) then
				return origOTP(...)
			end
		end)
	end
	f.at3curMatch = 0
	f.at3matches = {}
end

local firstPMLength

local fallbacks, notfallbacks = {}, {}  -- classifies completions into those which have preconditions and those which do not.  Those without preconditions are only considered if no other completions have matches.
local pmolengths = {}  -- holds the number of characters to overwrite according to pmoverwrite and the current prematch

function AceTab:RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite)
	-- Arg checks
	if type(descriptor) ~= 'string' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'descriptor' - string expected.", 3) end
	if prematches and type(prematches) ~= 'string' and type(prematches) ~= 'table' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'prematches' - string, table, or nil expected.", 3) end
	if type(wordlist) ~= 'function' and type(wordlist) ~= 'table' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'wordlist' - function or table expected.", 3) end
	if usagefunc and type(usagefunc) ~= 'function' and type(usagefunc) ~= 'boolean' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'usagefunc' - function or boolean expected.", 3) end
	if listenframes and type(listenframes) ~= 'string' and type(listenframes) ~= 'table' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'listenframes' - string or table expected.", 3) end
	if postfunc and type(postfunc) ~= 'function' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'postfunc' - function expected.", 3) end
	if pmoverwrite and type(pmoverwrite) ~= 'boolean' and type(pmoverwrite) ~= 'number' then error("Usage: RegisterTabCompletion(descriptor, prematches, wordlist, usagefunc, listenframes, postfunc, pmoverwrite): 'pmoverwrite' - boolean or number expected.", 3) end

	local pmtable

	if type(prematches) == 'table' then
		pmtable = prematches
		notfallbacks[descriptor] = true
	else
		pmtable = {}
		-- Mark this group as a fallback group if no value was passed.
		if not prematches then
			pmtable[1] = ""
			fallbacks[descriptor] = true
		-- Make prematches into a one-element table if it was passed as a string.
		elseif type(prematches) == 'string' then
			pmtable[1] = prematches
			if prematches == "" then
				fallbacks[descriptor] = true
			else
				notfallbacks[descriptor] = true
			end
		end
	end

	-- Make listenframes into a one-element table if it was not passed a table of frames.
	if not listenframes then  -- default
		listenframes = {}
		for i = 1, NUM_CHAT_WINDOWS do
			listenframes[i] = _G["ChatFrame"..i.."EditBox"]
		end
	elseif type(listenframes) ~= 'table' or type(listenframes[0]) == 'userdata' and type(listenframes.IsObjectType) == 'function' then  -- single frame or framename
		listenframes = { listenframes }
	end
	
	-- Hook each registered listenframe and give it a matches table.
	for _, f in pairs(listenframes) do
		if type(f) == 'string' then
			f = _G[f]
		end
		if type(f) ~= 'table' or type(f[0]) ~= 'userdata' or type(f.IsObjectType) ~= 'function' then
			error(format(ACETAB_MAJOR..": Cannot register frame %q; it does not exist", f:GetName()))
		end
		if f then
			if f:GetObjectType() ~= 'EditBox' then
				error(format(ACETAB_MAJOR..": Cannot register frame %q; it is not an EditBox", f:GetName()))
			else
				hookFrame(f)
			end
		end
	end
	
	-- Everything checks out; register this completion.
	if not registry[descriptor] then
		registry[descriptor] = { prematches = pmtable, wordlist = wordlist, usagefunc = usagefunc, listenframes = listenframes, postfunc = postfunc, pmoverwrite = pmoverwrite }
	end
end

function AceTab:IsTabCompletionRegistered(descriptor)
	return registry and registry[descriptor]
end

function AceTab:UnregisterTabCompletion(descriptor)
	registry[descriptor] = nil
	pmolengths[descriptor] = nil
	fallbacks[descriptor] = nil
	notfallbacks[descriptor] = nil
end

local function gcbs(s1, s2)
	if not s1 and not s2 then return end
	if not s1 then s1 = s2 end
	if not s2 then s2 = s1 end
	if #s2 < #s1 then
		s1, s2 = s2, s1
	end
	if strfind(strlower(s2), "^"..strlower(s1)) then
		return s1
	else
		return gcbs(strsub(s1, 1, -2), s2)
	end
end

local cursor  -- Holds cursor position.  Set in :OnTabPressed().
local previousLength, cMatch, matched, postmatch
local function cycleTab(this)
	cMatch = 0  -- Counter across all sets.  The pseudo-index relevant to this value and corresponding to the current match is held in this.at3curMatch
	matched = false

	-- Check each completion group registered to this frame.
	for desc, compgrp in pairs(this.at3matches) do

		-- Loop through the valid completions for this set.
		for m, pm in pairs(compgrp) do
			cMatch = cMatch + 1
			if cMatch == this.at3curMatch then  -- we're back to where we left off last time through the combined list
				this.at3lastMatch = m
				this.at3lastWord = pm
				this.at3curMatch = cMatch + 1 -- save the new cMatch index
				matched = true
				break
			end
		end
		if matched then break end
	end

	-- If our index is beyond the end of the list, reset the original uncompleted substring and let the cycle start over next time tab is pressed.
	if not matched then
		this.at3lastMatch = this.at3origMatch
		this.at3lastWord = this.at3origWord
		this.at3curMatch = 1
	end

	-- Insert the completion.
	this:HighlightText(this.at3matchStart-1, cursor)
	this:Insert(this.at3lastWord or '')
	this.at3_last_precursor = getTextBeforeCursor(this) or ''
end

local IsSecureCmd = IsSecureCmd

local cands, candUsage = {}, {}
local numMatches = 0
local firstMatch, hasNonFallback, allGCBS, setGCBS, usage
local text_precursor, text_all, text_pmendToCursor
local matches, usagefunc  -- convenience locals

local pms, pme, pmt, prematchStart, prematchEnd, text_prematch, entry
local function fillMatches(this, desc, fallback)
	entry = registry[desc]
	-- See what frames are registered for this completion group.  If the frame in which we pressed tab is one of them, then we start building matches.
	for _, f in ipairs(entry.listenframes) do
		if f == this then

			-- Try each precondition string registered for this completion group.
			for _, prematch in ipairs(entry.prematches) do

				if fallback then prematch = "%s" end

				-- Find the last occurence of the prematch before the cursor.
				pms, pme, pmt = nil, 1, ''
				text_prematch, prematchEnd, prematchStart = nil, nil, nil
				while true do
					pms, pme, pmt = strfind(text_precursor, "("..prematch..")", pme)
					if pms then
						prematchStart, prematchEnd, text_prematch = pms, pme, pmt
						pme = pme + 1
					else
						break
					end
				end

				if not prematchStart and fallback then
					prematchStart, prematchEnd, text_prematch = 0, 0, ''
				end
				if prematchStart then
					-- text_pmendToCursor should be the sub-word/phrase to be completed.
					text_pmendToCursor = strsub(text_precursor, prematchEnd + 1)

					-- How many characters should we eliminate before the completion before writing it in.
					pmolengths[desc] = entry.pmoverwrite == true and #text_prematch or entry.pmoverwrite or 0

					-- This is where we will insert completions, taking the prematch overwrite into account.
					this.at3matchStart = prematchEnd + 1 - (pmolengths[desc] or 0)

					-- We're either a non-fallback set or all completions thus far have been fallback sets, and the precondition matches.
					-- Create cands from the registered wordlist, filling it with all potential (unfiltered) completion strings.
					local wordlist = entry.wordlist
					local cands = type(wordlist) == 'table' and wordlist or {}
					if type(wordlist) == 'function' then
						wordlist(cands, text_all, prematchEnd + 1, text_pmendToCursor)
					end
					if cands ~= false then
						matches = this.at3matches[desc] or {}
						for i in pairs(matches) do matches[i] = nil end

						for _, m in ipairs(cands) do
							if strfind(strlower(m), strlower(text_pmendToCursor), 1, 1) == 1 then  -- we have a matching completion!
								hasNonFallback = hasNonFallback or (not fallback)
								matches[m] = entry.postfunc and entry.postfunc(m, prematchEnd + 1, text_all) or m
								numMatches = numMatches + 1
								if numMatches == 1 then
									firstMatch = matches[m]
									firstPMLength = pmolengths[desc] or 0
								end
							end
						end
						this.at3matches[desc] = numMatches > 0 and matches or nil
					end
				end
			end
		end
	end
end

function AceTab:OnTabPressed(this)
	if this:GetText() == '' then return true end

	-- allow Blizzard to handle slash commands, themselves
	if this == ChatEdit_GetActiveWindow() then
		local command = this:GetText()
		if strfind(command, "^/[%a%d_]+$") then
			return true
		end
		local cmd = strmatch(command, "^/[%a%d_]+")
		if cmd and IsSecureCmd(cmd) then
			return true
		end
	end

	cursor = this:GetCursorPosition()

	text_all = this:GetText()
	text_precursor = getTextBeforeCursor(this) or ''

	this.at3lastMatch = this.at3curMatch > 0 and (this.at3lastMatch or this.at3origWord)
	-- Detects if we've made any edits since the last tab press.  If not, continue cycling completions.
	if text_precursor == this.at3_last_precursor then
		return cycleTab(this)
	else
		for i in pairs(this.at3matches) do this.at3matches[i] = nil end
		this.at3curMatch = 0
		this.at3origWord = nil
		this.at3origMatch = nil
		this.at3lastWord = nil
		this.at3lastMatch = nil
		this.at3_last_precursor = text_precursor
	end

	numMatches = 0
	firstMatch = nil
	firstPMLength = 0
	hasNonFallback = false
	for i in pairs(pmolengths) do pmolengths[i] = nil end
	
	for desc in pairs(notfallbacks) do
		fillMatches(this, desc)
	end
	if not hasNonFallback then
		for desc in pairs(fallbacks) do
			fillMatches(this, desc, true)
		end
	end

	if not firstMatch then
		this.at3_last_precursor = "\0"
		return true
	end

	if numMatches == 1 then
		-- HighlightText takes the value AFTER which the highlighting starts, so we have to subtract 1 to have it start before the first character.
		this:HighlightText(this.at3matchStart-1, cursor)

		this:Insert(firstMatch)
		this:Insert(" ")
	else

		allGCBS = nil
		for desc, matches in pairs(this.at3matches) do
			-- Don't print usage statements for fallback completion groups if we have 'real' completion groups with matches.
			if hasNonFallback and fallbacks[desc] then break end
			
			-- Use the group's description as a heading for its usage statements.
			DEFAULT_CHAT_FRAME:AddMessage(desc..":")

			usagefunc = registry[desc].usagefunc
			if not usagefunc then
				-- No special usage processing; just print a list of the (formatted) matches.
				for m, fm in pairs(matches) do
					DEFAULT_CHAT_FRAME:AddMessage(fm)
					allGCBS = gcbs(allGCBS, m)
				end
			else

				if type(usagefunc) == 'function' then
					for i in pairs(candUsage) do candUsage[i] = nil end

					setGCBS = nil
					for m in pairs(matches) do
						setGCBS = gcbs(setGCBS, m)
					end
					allGCBS = gcbs(allGCBS, setGCBS)
					usage = usagefunc(candUsage, matches, setGCBS, strsub(text_precursor, 1, prematchEnd))

					if type(usage) == 'string' then
						DEFAULT_CHAT_FRAME:AddMessage(usage)

					elseif next(candUsage) and numMatches > 0 then
						for m, fm in pairs(matches) do
							if candUsage[m] then DEFAULT_CHAT_FRAME:AddMessage(strformat("%s - %s", fm, candUsage[m])) end
						end
					end
				end
			end

			if next(matches) then
				-- Replace the original string with the greatest common substring of all valid completions.
				this.at3curMatch = 1
				this.at3origWord = strsub(text_precursor, this.at3matchStart, this.at3matchStart + pmolengths[desc] - 1) .. allGCBS or ""
				this.at3origMatch = allGCBS or ""
				this.at3lastWord = this.at3origWord
				this.at3lastMatch = this.at3origMatch

				this:HighlightText(this.at3matchStart-1, cursor)
				this:Insert(this.at3origWord)
				this.at3_last_precursor = getTextBeforeCursor(this) or ''
			end
		end
	end
end
