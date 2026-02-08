
local MAJOR, MINOR = "LibColors-1.0", tonumber((gsub("r143","r",""))) or 9999;
local lib = LibStub:NewLibrary(MAJOR, MINOR)
local _G,string,tonumber,rawset,type = _G,string,tonumber,rawset,type
local hex = "%02x";

if not lib then return end

---@class LibColors-1.0
local lib = lib or {};

---@param num number
---@return string hex_value
lib.num2hex = function(num)
	return hex:format( (tonumber(num) or 0)*255 );
end

---@param colorTable table table with entries for the colors red, green and blue.
---@return string
lib.colorTable2HexCode = function(colorTable)
	local n2h = lib.num2hex;
	return n2h(colorTable[4] or colorTable["a"] or 1)
		.. n2h(colorTable[1] or colorTable["r"] or 1)
		.. n2h(colorTable[2] or colorTable["g"] or 1)
		.. n2h(colorTable[3] or colorTable["b"] or 1);
end

local function hex2num(str,start,stop)
	return tonumber(string.sub(str,start,stop),16) or 255;
end

local function wrapText(self,text)
	return ("|c%s%s|r"):format(self.hex, text)
end

---@param colorStr string A hexadecimal color code with a character length of 6 or 8 signs. RRGGBB or AARRGGBB.
---@return table
lib.hexCode2ColorTable = function(colorStr)
	local r,g,b,a = hex2num(colorStr,3,4), hex2num(colorStr,5,6), hex2num(colorStr,7,8), hex2num(colorStr,1,2);
	if strlen(colorStr)==6 then
		colorStr = "ff"..colorStr
	end
	return {
		r,g,b,a,
		r=r,g=g,b=b,a=a,
		hex=colorStr,
		wrapText=wrapText
	};
end

---@param gradientFraction number Percentage between all colors
---@param rgbColor1 table|string list of colors as hex code (string) or color tables; the first color defines the return type.
---@param rgbColor2 table|string list of colors as hex code (string) or color tables; the first color defines the return type.
---@param rgbColor3 [table|string] (optional) list of colors as hex code (string) or color tables; the first color defines the return type.
lib.colorGradient = function(gradientFraction, rgbColor1, rgbColor2, rgbColor3)
	local colorA = rgbColor1;
	local colorB = rgbColor2;
	local fraction = gradientFraction;
	local gradient = {0,0,0,255};

	-- Do we have 3 colors for the gradient? Need to adjust the params.
	if rgbColor3 then
		fraction = fraction * 2;

		-- Find which interval to use and adjust the fraction
		if fraction >= 1 then
			fraction = fraction-1;
			colorA = rgbColor2;
			colorB = rgbColor3;
		end
	end

	-- get color code from colorset list and/or convert hex to numeric color table
	local cType=type(colorA);
	if cType=="string" then
		colorA = rawget(lib.colorset,string.lower(colorA)) or colorA;
		colorA = lib.hexCode2ColorTable(colorA)
	end

	if type(colorB)=="string" then
		colorB = rawget(lib.colorset,string.lower(colorB)) or colorB;
		colorB = lib.hexCode2ColorTable(colorB)
	end

	-- calculate color
	for i=1, 4 do
		gradient[i] = floor(colorA[i] + ((colorB[i] - colorA[i]) * fraction ));
		if gradient[i]<0 then
			gradient[i]=0;
		end
		gradient[i] = gradient[i]/255;
	end

	if cType=="string" then
		-- return color table as hex code
		return lib.colorTable2HexCode(gradient)
	end
	-- return color table
	return gradient;
end

lib.colorset = setmetatable({},{
	__index=function(t,k)
		return "ffffffff"; -- fallback color
	end,
	__call=function(t,a,b)
		assert(type(a)=="string" or type(a)=="table","Usage: lib.colorset(<string|table>[, <string>])");

		if type(a)=="table" then
			for i,v in pairs(a) do
				if type(i)=="string" and (type(v)=="string" or type(v)=="table") then
					lib.colorset(i,v);
				end
			end
			return;
		end

		if type(b)=="table" then
			b = lib.colorTable2HexCode(b);
		end

		if type(b)=="string" then
			rawset(t,a,strrep("f",8-strlen(b))..b);
			return;
		end
		return;
	end
})

---@param reqColor string|table color word or hex value
---@param str [string|nil] (optional) string that wrapped in color code, the word "table" to get a color table or nil to get the color code like ffd000
---@return string|table
lib.color = function(reqColor, str)
	local Str,color = tostring(str):trim();
	assert(type(reqColor)=="string" or type(reqColor)=="table","Usage: lib.color(<string|table>[, <string>])")

	-- empty string don't need color
	if Str=="" then
		return "";
	end

	-- convert table to string
	if type(reqColor)=="table" then
		color = lib.colorTable2HexCode(reqColor)

	-- reqColor is a color hex code
	elseif reqColor:find("^%x+$") then
		color = reqColor;

	-- replace special color keywords
	elseif reqColor=="playerclass" then
		reqColor = UnitClass("player")
	elseif reqColor:find("^unitclass:.*$") then
		reqColor = UnitClass((reqColor:match("unitclass:(.*)")))
	end

	-- get color code from lib.colorset
	if not color then
		color = rawget(lib.colorset,string.lower(tostring(reqColor)))
	end

	-- last fallback
	if not (color and color:find("^%x+$")) then
		color = lib.colorset.white;
	end

	 -- return color as color table
	if str=="colortable" then
		return lib.hexCode2ColorTable(color)
	end

	-- return string with color or color code
	return (str==nil and color) or ("|c%s%s|r"):format(color, Str)
end

---@param pattern string
lib.getNames = function(pattern)
	local names,_ = {},nil;
	for name,_ in pairs(lib.colorset) do
		if pattern==nil or (pattern~=nil and name:match(pattern)) then
			tinsert(names,name)
		end
	end
	return names
end

do --[[ basic set of colors ]]
	local tmp = {
		-- basic colors
		yellow = "ffff00",
		orange = "ff8000",
		red    = "ff0000",
		violet = "ff00ff",
		blue   = "0000ff",
		cyan   = "00ffff",
		green  = "00ff00",
		black  = "000000",
		gray   = "808080",
		white  = "ffffff",
		-- wow money colors
		money_gold   = "ffd700",
		money_silver = "eeeeef",
		money_copper = "f0a55f",
	};

	local classColors = {}
	for n, c in pairs(_G["CUSTOM_CLASS_COLORS"] or _G["RAID_CLASS_COLORS"]) do
		classColors[n] = c;
	end

	if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
		local nonClassicClasses = { DEATHKNIGHT = "ffc41e3a", MONK = "ff00ff98", DEMONHUNTER = "ffa330c9", EVOKER = "ff33937f" }
		for n,c in pairs(nonClassicClasses) do
			if not classColors[n] then
				classColors[n] = {colorStr=c}
			end
		end
	end

	-- add class names with english and localized names
	for n, c in pairs(classColors) do
		tmp[n:lower()] = c.colorStr;
		if LOCALIZED_CLASS_NAMES_MALE[n] then
			tmp[LOCALIZED_CLASS_NAMES_MALE[n]:lower()] = c.colorStr;
		end
		if LOCALIZED_CLASS_NAMES_FEMALE[n] then
			tmp[LOCALIZED_CLASS_NAMES_FEMALE[n]:lower()] = c.colorStr;
		end
	end

	-- add item quality colors [currently from -1 to 7]
	for i,v in pairs(_G["ITEM_QUALITY_COLORS"]) do
		tmp["quality"..i] = v;
		if (_G["ITEM_QUALITY"..i.."_DESC"]) then
			tmp[_G["ITEM_QUALITY"..i.."_DESC"]:lower()] = v;
		end
	end

	-- more colors defined in game client
	for _,name in ipairs({"battlenet"})do
		local font_color = _G[name:upper().."_FONT_COLOR"];
		if font_color then
			tmp[name] = font_color:GenerateHexColor();
		end
	end

	lib.colorset(tmp)
end

--[[ space for more colors later... ]]
