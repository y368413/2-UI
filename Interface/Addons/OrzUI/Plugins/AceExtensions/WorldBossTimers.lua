-- ## Author: Soulstorm ## Version: v1.12.29 ## SavedVariables: WorldBossTimersDB ## IconTexture: 656169
local WBT = {};
local Util = {};

if type(WBT) == "table" then
    WBT.Util = Util;
end

Util.COLOR_DEFAULT    = "|cffffffff";
Util.COLOR_RED        = "|cffff0000";
Util.COLOR_GREEN      = "|cff00ff00";
Util.COLOR_ORANGE     = "|cffffdd1e";
Util.COLOR_LIGHTGREEN = "|cff35e059";
Util.COLOR_DARKGREEN  = "|cff50c41f";
Util.COLOR_YELLOW     = "|cfff2e532";
Util.COLOR_BLUE       = "|cff0394fc";
Util.COLOR_PURPLE     = "|cffbf00ff";


-- Lua 5.2 "import" from table.pack:
function TablePack(...)
  return { n = select("#", ...), ... }
end

function Util.StringTrim(s)
return s:match("^%s*(.-)%s*$"); -- Note: '-' is lazy '*' matching.
end

function Util.MessageFromVarargs(...)
    local args = TablePack(...);
    local msg = "";
    for i=1, args.n do
        local arg = args[i];
        if arg == nil then
            msg = msg .. "nil" .. " ";
        else
            msg = msg .. args[i] .. " ";
        end
    end
    msg = Util.StringTrim(msg);
    return msg;
end

function Util.ReverseColor(color)
    local t_color_rev = { };
    t_color_rev[Util.COLOR_DEFAULT] = Util.COLOR_RED;
    t_color_rev[Util.COLOR_GREEN] = Util.COLOR_RED;
    t_color_rev[Util.COLOR_LIGHTGREEN] = Util.COLOR_RED;
    t_color_rev[Util.COLOR_DARKGREEN] = Util.COLOR_RED;
    t_color_rev[Util.COLOR_YELLOW] = Util.COLOR_LIGHTGREEN;
    t_color_rev[Util.COLOR_RED] = Util.COLOR_LIGHTGREEN;
    return t_color_rev[color] or Util.COLOR_DEFAULT;
end

function Util.ColoredString(color, ...)
    return color .. Util.MessageFromVarargs(...) .. Util.COLOR_DEFAULT;
end

function Util.TableIsEmpty(tbl)
    return next(tbl) == nil
end

function Util.TableLength(tbl)
    local cnt = 0;
    for _ in pairs(tbl) do
        cnt = cnt + 1;
    end
    return cnt;
end

function Util.IsTable(obj)
    return type(obj) == "table";
end

--------------------------------------------------------------------------------
-- SetUtil
--------------------------------------------------------------------------------
Util.SetUtil = {};
local SetUtil = Util.SetUtil;

function SetUtil.ContainsKey(set, key)
    return set[key] ~= nil;
end

function SetUtil.FindKey(set, value)
    -- The WBT sets are small, so linear search is good enough.
    for k, v in pairs(set) do
        if v == value then
            return k;
        end
    end
    return nil;
end

function SetUtil.ContainsValue(set, value)
    return SetUtil.FindKey(set, value) and true;
end

--------------------------------------------------------------------------------
-- String utils
--------------------------------------------------------------------------------

-- Source: http://lua-users.org/wiki/StringRecipes
function Util.StrEndsWith(str, ending)
    return ending == "" or str:sub(-#ending) == ending;
end

--------------------------------------------------------------------------------

function Util.FormatTimeSeconds(seconds)
    local min = math.floor(seconds / 60);
    local sec = math.floor(seconds % 60);

    local min_text;
    if min < 10 then
        min_text = "0" .. min;
    else
        min_text = min;
    end

    local sec_text
    if sec < 10 then
        sec_text = "0" .. sec;
    else
        sec_text = sec;
    end
    
    return min_text .. ":" .. sec_text;
end

function Util.PlaySoundAlert(soundfile)
    if soundfile == nil or not WBT.db.global.sound_enabled then
        return;
    end

    PlaySoundFile(soundfile, "Master");
end

-- Credits: The spairs function is copied from:
-- https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
-- by user "Michael Kottman"
--
-- Note: I really should use a better data structure instead,
-- such as ordered map, but this is a fast solution, and the computational
-- overhead will be small since the table is small.
function Util.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Function content is copied from first entry at 'http://lua-users.org/wiki/StringTrim'
function Util.strtrim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"));
end

--[[
    Table with the following structure: unnamed entries, where each entry is a table.
    This table's key-value relation must be unique in respect to all other entries
    in the MultiKeyTable. Ex:
    local t = {
        { k = 1, v = 2 },
        { k = 2, v = 3 },
        { k = 1, v = 4 }, -- Invalid, because 'k = 1' is already used,
    };
]]--
Util.MultiKeyTable = {};

function Util.MultiKeyTable:New(tbl)
    local obj = {};
    obj.tbl = tbl;

    setmetatable(obj, self);
    self.__index = self;

    return obj;
end

--[[
    Returns the subtable for which 'k = v' is true.
]]--
function Util.MultiKeyTable:GetSubtbl(k, v)
    for _, subtbl in ipairs(self.tbl) do
        for k_subtbl, v_subtbl in pairs(subtbl) do
            if k_subtbl == k and v_subtbl == v then
                return subtbl;
            end
        end
    end

    return nil;
end


--[[
    Returns the values for each subtable with a key 'k' as a named table.
    The table's key and value are the same. For example: ret_val[x] = x
]]--
function Util.MultiKeyTable:GetAllSubVals(k)
    local subvals = {};
    for _, subtbl in ipairs(self.tbl) do
        local val = subtbl[k];
        if val then
            subvals[val] = val;
        end
    end

    return subvals;
end

-- Always includes the original main realm.
function Util.GetConnectedRealms()
    local realms = GetAutoCompleteRealms();
    if next(realms) == nil then
        -- Empty table -> not a connected realm.
        realms = { GetNormalizedRealmName() };
    end

    return realms;
end
--return Util;


-- Sound related constant data.
local Sound = {};
WBT.Sound = Sound;

Sound.SOUND_CLASSIC = "classic";
Sound.SOUND_FANCY = "fancy";

Sound.SOUND_FILE_DEFAULT = 567275; -- Wardrums

Sound.SOUND_KEY_BATTLE_BEGINS = "battle-begins";

--[[
    How to find IDs given the filename: use 'https://wow.tools/files' to search, either with filename or fileID

    k:
        the string which is displayed in GUI
    v:
        the fileID, needed in PlaySoundFile
]]--

Sound.sound_tbl = {
    keys = {
        option = "option",
        file_id = "file_id",
    },
    tbl = WBT.Util.MultiKeyTable:New({
        { option = "无",                    file_id = nil,     },
        { option = "你们这是自寻死路！！！",        file_id = 552503,  },
        { option = "我来啦！！！",          file_id = 547915,  },
        { option = "钟声",               file_id = 566564,  },
        { option = "铃声",                 file_id = 567399,  },
        { option = Sound.SOUND_KEY_BATTLE_BEGINS, file_id = 2128648, },
        { option = "pvp警告声",                 file_id = 567505,  },
        { option = "鼓",                    file_id = 1487139, },
    }),
};


-- The constant boss data, e.g. boss location and respawn time.
local Util = WBT.Util;
local Sound = WBT.Sound;

local BossData = {};
WBT.BossData = BossData;

local function MinToSec(min)
    return min * 60;
end

local MAX_RESPAWN = MinToSec(15) - 1; -- Minus 1, since they tend to spawn after 14:59.
-- Conservative guesses. Actual values are not known.
local MIN_RESPAWN_SHA = MinToSec(10);
local MAX_RESPAWN_SHA = MinToSec(20);
local MIN_RESPAWN_NALAK = MIN_RESPAWN_SHA;
local MAX_RESPAWN_NALAK = MAX_RESPAWN_SHA;
local MIN_RESPAWN_ZANDALARI_WARBRINGER = MinToSec(30);
local MAX_RESPAWN_ZANDALARI_WARBRINGER = MinToSec(60);

local SOUND_DIR = "Interface/AddOns/OrzUI/Media/Sounds/WorldBossTimers";

local IS_RETAIL = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1);


local function IsSavedWorldBoss(id_wb)
    local n_saved = GetNumSavedWorldBosses();
    for i=1, n_saved do
        local _, id = GetSavedWorldBossInfo(i);
        if id == id_wb then
            return true;
        end
    end
    return false;
end

local function IsSavedDaily(questId)
    return C_QuestLog.IsQuestFlaggedCompleted(questId);
end

local function NeverSaved()
    return false;
end

local tracked_bosses = {
    ["Oondasta"] = {
        name = "Oondasta",
        color = "|cff21ffa3",
        ids = {69161},
        is_saved_fcn = function() return IsSavedWorldBoss(4); end,
        soundfile = SOUND_DIR .. "oondasta3.mp3",
        min_respawn = MAX_RESPAWN,
        max_respawn = MAX_RESPAWN,
        random_spawn_time = false,
        auto_announce = true,
        map_id = 507,
        perimiter = {
            origin = {
                x = 0.49706578,
                y = 0.56742978,
            },
            radius = 0.07,
        },
    },
    ["Rukhmar"] = {
        name = "Rukhmar",
        color = "|cfffa6e06",
        ids = {83746},
        is_saved_fcn = function() return IsSavedWorldBoss(9); end,
        soundfile = SOUND_DIR .. "rukhmar1.mp3",
        min_respawn = MAX_RESPAWN,
        max_respawn = MAX_RESPAWN,
        random_spawn_time = false,
        auto_announce = true,
        map_id = 542,
        perimiter = {
            origin = {
                x = 0.37155128,
                y = 0.38439554,
            },
            radius = 0.04,
        },
    },
    ["Galleon"] = {
        name = "Galleon",
        color = "|cffc1f973",
        ids = {62346},
        is_saved_fcn = function() return IsSavedWorldBoss(2); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = IS_RETAIL and MAX_RESPAWN or MinToSec(30),
        max_respawn = IS_RETAIL and MAX_RESPAWN or MinToSec(30),
        random_spawn_time = false,
        auto_announce = true,
        map_id = 376,
        perimiter = {
            origin = {
                x = 0.71155238,
                y = 0.63839519,
            },
            radius = 0.04,
        },
    },
    ["Nalak"] = {
        name = "Nalak",
        color = "|cff0081cc",
        ids = {69099},
        is_saved_fcn = function() return IsSavedWorldBoss(3); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MIN_RESPAWN_NALAK,
        max_respawn = MAX_RESPAWN_NALAK,
        random_spawn_time = true,
        auto_announce = true,
        map_id = 504,
        perimiter = {
            origin = {
                x = 0.60369474,
                y = 0.37266934,
            },
            radius = 0.04,
        },
    },
    ["Sha of Anger"] = {
        name = "Sha of Anger",
        color = "|cff8a1a9f",
        ids = {60491},
        is_saved_fcn = function() return IsSavedWorldBoss(1); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MIN_RESPAWN_SHA,
        max_respawn = MAX_RESPAWN_SHA,
        random_spawn_time = true,
        auto_announce = true,
        map_id = 379,
        perimiter = {
            origin = {
                x = 0.53787065,
                y = 0.64697766,
            },
            radius = 0.03,
        },
    },
    ["Huolon"] = {
        name = "Huolon",
        color = "|cfff7f713",
        ids = {73167},
        is_saved_fcn = NeverSaved,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(20) - 1,  -- Then boss is unattackable for 1 min... Could change to 21.
        max_respawn = MinToSec(20) - 1,
        random_spawn_time = true,
        auto_announce = true,
        map_id = 554,
        perimiter = {
            origin = {
                x = 0.66583741,
                y = 0.58253992,
            },
            radius = 0.06,
        },
    },
    ["Rustfeather"] = {
        name = "Rustfeather",
        color = "|cffffe17d",
        ids = {152182},
        is_saved_fcn = function() return IsSavedDaily(55811); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(15),
        max_respawn = MinToSec(30),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1462,
        perimiter = {
            origin = {
                x = 0.65564358234406,
                y = 0.78932404518127,
            },
            radius = 0.05,
        },
    },
    ["A. Harvester"] = {
        name = "A. Harvester", -- Shortened to keep GUI text to one line.
        color = "|cffe08748",
        ids = {151934},
        is_saved_fcn = function() return IsSavedDaily(55512); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(15),
        max_respawn = MinToSec(40),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1462,
        perimiter = {
            origin = {
                x = 0.52341330,
                y = 0.40851349,
            },
            radius = 0.05,
        },
    },
--  ["Soundless"] = {
--      Won't add. Very long timer and prone to zone resets. Timers will not be reliable.
-- },
    ["Rei Lun"] = {
        name = "Rei Lun",
        color = "|cff23dcfc",
        ids = {157162},
        is_saved_fcn = function() return IsSavedDaily(57346); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(60),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1530,  -- N'Zoth Assault. Old timeline zone has different.
        perimiter = {
            origin = {
                x = 0.21920382,
                y = 0.12227475,
            },
            radius = 0.03,
        },
    },
    ["Ha-Li"] = {
        name = "Ha-Li",
        color = "|cff0394fc",
        ids = {157153},
        is_saved_fcn = function() return IsSavedDaily(57344); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(60),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1530,
        perimiter = {
            origin = {
                x = 0.3437,
                y = 0.3828,
            },
            radius = 0.08,
        },
    },
    ["Anh-De"] = {
        name = "Anh-De",
        color = "|cfffaea75",
        ids = {157466},
        is_saved_fcn = function() return IsSavedDaily(57363); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(60),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1530,
        perimiter = {
            origin = {
                x = 0.3389,
                y = 0.6837,
            },
            radius = 0.02,
        },
    },
    ["Houndlord Ren"] = {
        name = "Houndlord Ren",
        color = "|cfffaab34",
        ids = {157160},
        is_saved_fcn = function() return IsSavedDaily(57345); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(60),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1530,
        perimiter = {
            origin = {
                x = 0.1310,
                y = 0.2600,
            },
            radius = 0.02,
        },
    },
    ["Corpse Eater"] = {
        name = "Corpse Eater",
        color = "|cffa884ff",
        ids = {162147},
        is_saved_fcn = function() return IsSavedDaily(58696); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(5),
        max_respawn = MinToSec(30),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1527,
        perimiter = {
            origin = {
                x = 0.3091,
                y = 0.4967,
            },
            radius = 0.02,
        },
    },
    ["Rotfeaster"] = {
        name = "Rotfeaster",
        color = "|cffffc489",
        ids = {157146},
        is_saved_fcn = function() return IsSavedDaily(57273); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(90),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1527,
        perimiter = {
            origin = {
                x = 0.6831,
                y = 0.3188,
            },
            radius = 0.01,
        },
    },
    ["Ishak"] = {
        name = "Ishak",  -- Ishak of the Four Winds
        color = "|cff0394fc",
        ids = {157134},
        is_saved_fcn = function() return IsSavedDaily(57259); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(120),  -- 2h
        max_respawn = MinToSec(255),  -- 4h 45m
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1527,
        perimiter = {
            origin = {
                x = 0.7390,
                y = 0.8355,
            },
            radius = 0.02,
        },
    },
    ["Mal'Korak"] = {
        name = "Mal'Korak",  -- Warbringer Mak'Korak
        color = "|cff99ba4e",
        ids = {162819},
        is_saved_fcn = function() return IsSavedDaily(58889); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(45),
        max_respawn = MinToSec(90),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1536,
        perimiter = {
            origin = {
                x = 0.3372,
                y = 0.8009,
            },
            radius = 0.01,
        },
    },
    ["Nerissa"] = {
        name = "Nerissa",  -- Nerissa Heartless
        color = "|cffbec0c2",
        ids = {162690},
        is_saved_fcn = function() return IsSavedDaily(58851); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(30),
        max_respawn = MinToSec(60),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1536,
        perimiter = {
            origin = {
                x = 0.6605,
                y = 0.3518,
            },
            radius = 0.01,
        },
    },
--  ["Violet Mistake"] = {
--      Won't add. Not limited by respawn time, but by the time and effort it takes to spawn it.
--  },
    ["Hopecrusher"] = {
        name = "Hopecrusher",
        color = "|cfffaab34",
        ids = {166679},
        is_saved_fcn = function() return IsSavedDaily(59900); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(60),
        max_respawn = MinToSec(60),
        random_spawn_time = false,
        auto_announce = true,
        map_id = 1525,
        perimiter = {
            origin = {
                x = 0.5197,
                y = 0.5181,
            },
            radius = 0.01,
        },
    },
    ["Famu"] = {
        name = "Famu",  -- Famu the Infinite
        color = "|cff0394fc",
        ids = {166521},
        is_saved_fcn = function() return IsSavedDaily(59869); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(25),
        max_respawn = MinToSec(35),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1525,
        perimiter = {
            origin = {
                x = 0.6257,
                y = 0.4723,
            },
            radius = 0.01,
        },
    },
--  ["Gorged Shadehound"] = {
--      Won't add (for now). Apparently the event is bugged.
--  },
--  ["Fallen Charger"] = {
--      Won't add. TLPD-like.
--  },
--  ["Konthrogz the Obliterator"] = {
--      Won't add. Apparently the spawn time is very buggy.
--  },
--  ["Malbog"] = {
--      Won't add. Apparently short respawn of about 5 min.
--  },
    ["Reliwik"] = {
        name = "Reliwik",  -- Reliwik the Defiant
        color = "|cffe147ff",
        ids = {180160},
        is_saved_fcn = function() return IsSavedDaily(64455); end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(15),
        max_respawn = MinToSec(60),  -- This spawn seems to be bugged. Timer probably inaccurate.
        random_spawn_time = true,
        auto_announce = true,
        map_id = 1961,
        perimiter = {
            origin = {
                x = 0.5620,
                y = 0.6630,
            },
            radius = 0.02,
        },
    },
--  ["Rhuv, Gorger of Ruin"] = {
--      Won't add. Not a fixed respawn time, and shares spawn with other mobs.
--  },
--  ["Hirukon"] = {
--      Won't add. Not limited by respawn time, but by the time and effort it takes to spawn it.
--  },
    ["Breezebiter"] = {
        name = "Breezebiter",
        color = "|cffe147ff",
        ids = {195353},
        is_saved_fcn = function() return false; end,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MinToSec(60),
        max_respawn = MinToSec(120),
        random_spawn_time = true,
        auto_announce = true,
        map_id = 2024,
        perimiter = {
            origin = {
                x = 0.2980,
                y = 0.4626,
            },
            radius = 0.02,
        },
    },
}

local ZWB_STATIC_DATA = {
    {zone = "JF", map_id = 371, color = "|cff2bce7a", perimiter = {origin = {x = 0.52551341, y = 0.18841952}, radius = 0.03}},
    {zone = "KW", map_id = 418, color = "|cff27b4d1", perimiter = {origin = {x = 0.17448401, y = 0.52911037}, radius = 0.04}},
    {zone = "DW", map_id = 422, color = "|cff8a1a9f", perimiter = {origin = {x = 0.47365963, y = 0.62041634}, radius = 0.03}},
    {zone = "KS", map_id = 379, color = "|cffeab01e", perimiter = {origin = {x = 0.75076747, y = 0.67355406}, radius = 0.03}},
    {zone = "TS", map_id = 388, color = "|cff0cd370", perimiter = {origin = {x = 0.36536807, y = 0.85731047}, radius = 0.03}},
};

local function ZWBName(zone)
    return "ZWB (" .. zone .. ")";
end

local function ZandalariWarbringerFromTemplate(zone, map_id, color, perimiter)
    return {
        name = ZWBName(zone),
        color = color,
        ids = {69769, 69842, 69841},
        is_saved_fcn = NeverSaved,
        soundfile = Sound.SOUND_FILE_DEFAULT,
        min_respawn = MIN_RESPAWN_ZANDALARI_WARBRINGER,
        max_respawn = MAX_RESPAWN_ZANDALARI_WARBRINGER,
        random_spawn_time = true,
        auto_announce = false,
        map_id = map_id,
        perimiter = perimiter,
    };
end

local function AddZandalariWarbringers()
    for _, data in pairs(ZWB_STATIC_DATA) do
        tracked_bosses[ZWBName(data.zone)] = ZandalariWarbringerFromTemplate(data.zone, data.map_id, data.color, data.perimiter);
    end
end

-- Wait with enabling warbringers in classic MoP until they actually exist, otherwise
-- the "Show GUI only in boss zones" will initially be incorrect.
if IS_RETAIL then
    AddZandalariWarbringers();
end

-- END OF STATIC DATA --


function BossData.Get(name)
    return tracked_bosses[name];
end

function BossData.GetFromUnitGuid(guid, map_id)
    local npc_id = select(6, strsplit("-", guid));
    for _, data in pairs(tracked_bosses) do
        for _, id in pairs(data.ids) do
            if npc_id == tostring(id) and map_id == data.map_id then
                return data;
            end
        end
    end

    return nil;
end

function BossData.BossNameFromUnitGuid(guid, map_id)
    local data = BossData.GetFromUnitGuid(guid, map_id);
    if data then
        return data.name;
    end

    return nil;
end

function BossData.GetAll()
    return tracked_bosses;
end

function BossData.BossExists(name)
    for name2, _ in pairs(tracked_bosses) do
        if name == name2 then
            return true;
        end
    end

    return false;
end

function BossData.IsSaved(name)
    return BossData.Get(name).is_saved_fcn();
end

-- FIXME: This looks strange.
for name, data in pairs(tracked_bosses) do
    data.name_colored = data.color .. data.name .. Util.COLOR_DEFAULT;
end


-- The code for the GUI, i.e. the window with the timers.

local Util = WBT.Util;
local Options = {}; -- Must be initialized later.

-- Provides the GUI API and performs checks if the GUI is shown etc.
local GUI = {};
WBT.GUI = GUI;

WBT.G_window = {};

local WIDTH_DEFAULT = 200;
local HEIGHT_BASE = 30;
local HEIGHT_DEFAULT = 106;
local MAX_ENTRIES_DEFAULT = 7;

-- The sum of the relatives is not 1, because I've had issues with "Flow"
-- elements sometimes overflowing to next line then.
local BTN_OPTS_REL_WIDTH  = 30/100;
local BTN_REQ_REL_WIDTH   = 30/100;
local BTN_SHARE_REL_WIDTH = 39/100; -- Needs the extra width or name might not show.


function GUI:Init()
    Options = WBT.Options;
end

function GUI:CreateLabels()
    self.labels = {};
end

function GUI:Restart()
    self:New();
end

local function ShowBossZoneOnlyAndOutsideZone()
    return Options.show_boss_zone_only.get() and not WBT.InBossZone();
end

function GUI:ShouldShow()
    if ShowBossZoneOnlyAndOutsideZone() then
        return false;
    end
    local should_show =
            not self.visible
            and not WBT.db.global.hide_gui;
    
    return should_show;
end

function GUI:ShouldHide()
    -- Should GUI only be shown in boss zone, but is not in one?
    -- Are no bosses considered dead (waiting for respawn)?

    local should_hide = (WBT.db.global.hide_gui or ShowBossZoneOnlyAndOutsideZone())
            and self.visible;

    return should_hide;
end

function GUI:Show()
    if self.released then
        self:Restart();
    end

    self.gui_container.frame:Show();
    self.visible = true;

    -- It's possible that options that affect the GUI position have changed
    -- while the GUI has been hidden, e.g. toggling between char/global position.
    -- In that case the position must be updated.
    self:InitPosition();
end

function GUI:Hide()
    if self.released then
        return;
    end

    self.gui_container.frame:Hide();
    self.visible = false;
end

function GUI:UpdateGUIVisibility()
    if self:ShouldShow() then
        self:Show();
    elseif self:ShouldHide() then
        self:Hide();
    end
end

function GUI:LockOrUnlock()
    if not self.window then
        -- The window is freed when hidden.
        return;
    end
    -- BUG:
    -- If the window is locked, and then a user tries to move it, an error will be thrown
    -- because "StartMoving" is not allowed to be called on non-movable frames.
    -- However, there doesn't seem to exist any API that allows an AceGUI frame to be
    -- locked.
    -- The error should be harmless tho, unless a user shows lua errors, in which case it will
    -- at worst be annoying.
    self.window.frame:SetMovable(not Options.lock.get());
end

-- Ensure that right clicking outside of the window
-- does not trigger the interactive label, or hide
-- other GUI components.
function GUI.LabelWidth(width)
    return width - 15;
end

function GUI:CreateNewLabel(guid, kill_info)
    local gui = self;
    local label = GUI.AceGUI:Create("InteractiveLabel");
    label:SetWidth(GUI.LabelWidth(self.width));
    label:SetCallback("OnClick", function(self)
            local text = self.label:GetText();
            if text and text ~= "" then
                WBT.ResetBoss(guid);
            end
            gui:Update();
        end);
    label.userdata.t_death = kill_info.t_death;
    label.userdata.time_next_spawn = kill_info:GetSecondsUntilLatestRespawn();
    return label;
end

function GUI:UpdateHeight(n_entries)
    local new_height = n_entries <= MAX_ENTRIES_DEFAULT and HEIGHT_DEFAULT + n_entries
            or (self.window.content:GetNumChildren() * 11 + HEIGHT_BASE);
    if self.height == new_height then
        return;
    end

    self.window:SetHeight(new_height);
    self.height = new_height;
end

function GUI:UpdateWidth()
    local new_width = WIDTH_DEFAULT +
            (Options.multi_realm.get() and 40 or 0) +
            (Options.show_realm.get() and 20 or 0);
    if self.width == new_width then
        return;
    end

    self.width = new_width;
    self.window:SetWidth(new_width);
    self.btn_container:SetWidth(new_width);
    for _, label in pairs(self.labels) do
        label:SetWidth(GUI.LabelWidth(new_width));
    end
end

-- Before this function can be used, labels must be created! I.e. there must be
-- a mapping mapping to which KillInfos will be displayed.
function GUI:FindMaxDisplayedShardId()
    -- Find longest shard ID for padding.
    local max_shard_id = 0;
    for guid, label in pairs(self.labels) do
        local shard_id = WBT.db.global.kill_infos[guid].shard_id;
        if shard_id > max_shard_id then
            max_shard_id = shard_id;
        end
    end
    return max_shard_id;
end

function GUI.CreatePaddedShardIdString(shard_id, max_shard_id)
    local shard_str;
    local pad_char;
    if WBT.IsUnknownShard(shard_id) then
        shard_str = "?";
        pad_char = "?";  -- Alignment won't work because font isn't monospace. But it's an improvement.
    else
        shard_str = shard_id;
        pad_char = "0";
    end
    local pad_len = string.len(max_shard_id) - string.len(shard_str);
    shard_str = string.rep(pad_char, pad_len) .. shard_str;
    return shard_str;
end

function GUI.CreateLabelText(kill_info, max_shard_id)
    local prefix = "";
    local color = WBT.GetHighlightColor(kill_info);
    local prefix = "";
    if Options.multi_realm.get() then
        local shard = GUI.CreatePaddedShardIdString(kill_info.shard_id, max_shard_id)
        shard = Util.ColoredString(color, shard);
        prefix = prefix .. shard .. ":";
    end
    if Options.show_realm.get() then
        local realm = Util.ColoredString(Util.COLOR_YELLOW, strsub(kill_info.realm_name_normalized, 0, 3));
        prefix = prefix .. realm .. ":";
    end
    return prefix .. WBT.GetColoredBossName(kill_info.boss_name) .. ": " .. WBT.GetSpawnTimeOutput(kill_info);
end

function GUI:AddNewLabel(guid, kill_info)
    local label = self:CreateNewLabel(guid, kill_info);
    self.labels[guid] = label;
    self.window:AddChild(label);
end

function GUI:Rebuild()
    if self.labels == nil then
        return; -- GUI hasn't been built, so nothing to rebuild.
    end

    -- Clear all labels.
    for guid, _ in pairs(self.labels) do
        -- NOTE: Don't try to remove specific children. That's too Ace internal.
        table.remove(self.window.children);
        self.labels[guid]:Release();
        self.labels[guid] = nil;
    end

    self:Update();
end

-- Returns true when a kill_info has a fresh kill that needs to be updated for the label.
function GUI.KillInfoHasFreshKill(kill_info, label)
    local t_death = kill_info:GetServerDeathTime();
    if label.userdata.t_death ~= t_death then
        label.userdata.t_death = t_death;
        return true;
    else
        return false;
    end
end

-- True when the timer for a cyclic label restarted (i.e. made a lap).
-- This includes the event that a kill info goes from non-expired to expired.
function GUI.CyclicKillInfoRestarted(kill_info, label)
    local t_next_spawn = kill_info:GetSecondsUntilLatestRespawn();
    if label.userdata.time_next_spawn < t_next_spawn then
        label.userdata.time_next_spawn = t_next_spawn;
        return true;
    else
        return false;
    end
end

function GUI.ShouldShowKillInfo(kill_info)
    if kill_info:IsCyclicExpired() then
        return false;
    end
    local shard_ok = Options.assume_realm_keeps_shard.get()
            and kill_info:IsOnSavedRealmShard()
            or kill_info:IsOnCurrentShard();
    return shard_ok or Options.multi_realm.get();
end

-- Builds and/or updates what labels as necessary.
function GUI:UpdateContent()
    local nlabels = 0;
    local needs_rebuild = false;

    -- Note that labels are added in a certain order, which corresponds to the order they will
    -- be displayed in the Window. If there is a need to re-order a label, then the solution
    -- is to call GUI.Rebuild().
    -- The reason for a rebuild instead of sorting is that the labels are bound to internal AceGUI objects
    -- and I don't want to try to sort them.
    for guid, kill_info in Util.spairs(WBT.db.global.kill_infos, WBT.KillInfo.CompareTo) do
        local label = self.labels[guid];
        local show_label = GUI.ShouldShowKillInfo(kill_info);
        if show_label then
            nlabels = nlabels + 1;
            if label == nil then
                self:AddNewLabel(guid, kill_info)
            else
                -- FIXME: Use self.update_event instead.
                if GUI.KillInfoHasFreshKill(kill_info, label) or GUI.CyclicKillInfoRestarted(kill_info, label) then
                    -- The order of the labels needs to be updated, so rebuild.
                    needs_rebuild = true;
                end
            end
        else
            -- Remove label:
            if label then
                -- XXX:
                -- Just removing the label seems to cause issues with other labels not showing
                -- if they are added after this label is removed. (Probably something wrong with
                -- the assumption on how the window children are stored.)
                -- Workaround: Just rebuild.
                needs_rebuild = true;
                if self.update_event == WBT.UpdateEvents.SHARD_DETECTED then
                    local boss_name = WBT.GetColoredBossName(WBT.db.global.kill_infos[guid].boss_name);
                    WBT.Logger.Info("Timer for " .. boss_name .. " was hidden because it's not for the current shard.")
                end
            end
        end
    end

    if needs_rebuild then
        self:Rebuild(); -- Warning: recursive call!
    else
        self:UpdateHeight(nlabels);
        self:UpdateWidth();

        -- Set the label texts.
        local max_shard_id = self:FindMaxDisplayedShardId();
        for guid, label in pairs(self.labels) do
            label:SetText(GUI.CreateLabelText(WBT.db.global.kill_infos[guid], max_shard_id));
        end

        self:UpdateWindowTitle();
    end
end

-- @param event: Optional event specifier.
function GUI:Update(event)
    self.update_event = event or WBT.UpdateEvents.UNSPECIFIED;

    self:UpdateGUIVisibility();

    if not self.visible then
        return;
    end

    self:LockOrUnlock();
    self:UpdateContent();

    self.update_event = WBT.UpdateEvents.UNSPECIFIED;
end

function GUI:SetPosition(pos)
    if self.released then
        -- It's possible to get here when toggling GUI options while the GUI is hidden (i.e. released).
        return;
    end
    local relativeTo = nil;
    self.window:ClearAllPoints();
    self.window:SetPoint(pos.point, relativeTo, pos.xOfs, pos.yOfs);
end

local function GetDefaultGUIPosition()
    return {
        point = "Center",
        relativeToName = "UIParrent",
        realtivePoint = nil,
        xOfs = 0,
        yOfs = 0,
    };
end

local function GetGUIPosition()
    local pos = Options.global_gui_position.get()
            and WBT.db.global.gui_position
            or WBT.db.char.gui_position;
    if pos == nil then
        return GetDefaultGUIPosition();
    elseif pos.point == nil or pos.xOfs == nil or pos.yOfs == nil then
        -- Corrupted point. Could happen due to issue #109. This will restore the
        -- default position without users needing to reset all WBT settings.
        WBT.Logger.Debug("Restoring corrupted GUI position.");
        return GetDefaultGUIPosition();
    else
        return pos;
    end
end

function GUI:InitPosition()
    local pos = GetGUIPosition();
    self:SetPosition(pos);
end

-- Function is on class since this can be called from hooksecurefunc. The GUI is singleton right now either way.
function GUI.SaveGUIPosition()
    if not GUI.visible then
        -- If the GUI is not visible the position will not contain e.g. coordinates.
        -- Trying to save it will corrupt the position.
        return;
    end

    local point, _, relativePoint, xOfs, yOfs = WBT.G_window:GetPoint();

    if xOfs == nil or yOfs == nil then
        -- Extra check for case mentioned above.
        WBT.Logger.Debug("WARNING: Tried to save GUI position without coordinates");
        return;
    end

    local pos = {
        point = point,
        relativeToName = "UIParrent",
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
    };
    if Options.global_gui_position.get() then
        WBT.db.global.gui_position = pos;
    else
        WBT.db.char.gui_position = pos;
    end
end

function GUI:SaveGUIPositionOnMove()
    hooksecurefunc(self.window.frame, "StopMovingOrSizing", self.SaveGUIPosition);
end

function GUI:ResetPosition()
    local pos = GetDefaultGUIPosition();
    self:SetPosition(pos);
end

function GUI.SetupAceGUI()
    GUI.AceGUI = LibStub("AceGUI-3.0"); -- Need to create AceGUI during/after 'OnInit' or 'OnEnabled'
end

function GUI:CleanUpWidgetsAndRelease()
    GUI.AceGUI:Release(self.gui_container);

    -- Remove references to fields. Hopefully the widget is
    self.labels = nil;
    self.visible = nil;
    self.gui_container = nil;
    self.window = nil;

    self.released = true;
end

function GUI:NewBasicWindow()
    local window = GUI.AceGUI:Create("Window");

    window.frame:SetFrameStrata("LOW");
    window:SetWidth(self.width);
    window:SetHeight(self.height);

    window:SetLayout("List");
    window:EnableResize(false);

    self.visible = false;

    return window;
end

function GUI:UpdateWindowTitle()
    if not self.window then
        -- The window is freed when hidden.
        return;
    end
    local prefix = "";
    if Options.multi_realm:get() then
        if WBT.IsUnknownShard(WBT.GetCurrentShardID()) then
            prefix = "??? - ";
        else
            local cur_shard_id = WBT.GetCurrentShardID();
            local max_shard_id = self:FindMaxDisplayedShardId();
            prefix = GUI.CreatePaddedShardIdString(cur_shard_id, max_shard_id) .. " - ";
        end
    end
    self.window:SetTitle(prefix .. WorldBossTimersLocal)
end

-- "Decorator" of default closeOnClick, see AceGUIContainer-Window.lua.
local function closeOnClick(this)
    PlaySound(799);
    this.obj:Hide();
    WBT.db.global.hide_gui = true;
end

-- FIXME: Essentially this class is a singleton, but it's being accessed via
-- something that looks like an instance (g_gui) at some places, and directly via
-- the class (GUI) at other places.
function GUI:New()
    if self.gui_container then
        self.gui_container:Release();
    end

    self.update_event = WBT.UpdateEvents.UNSPECIFIED;

    self.released = false;

    self.width = WIDTH_DEFAULT;
    self.height = HEIGHT_DEFAULT;
    self.window = GUI:NewBasicWindow();
    self.window.closebutton:SetScript("OnClick", closeOnClick);
    WBT.G_window = self.window;  -- FIXME: Remove this variable.
    self.window:SetTitle(WorldBossTimersLocal);

    self.btn_req = GUI.AceGUI:Create("Button");
    self.btn_req:SetRelativeWidth(BTN_REQ_REL_WIDTH);
    self.btn_req:SetText("索要");
    self.btn_req:SetCallback("OnClick", WBT.RequestKillData);

    self.btn_opts = GUI.AceGUI:Create("Button");
    self.btn_opts:SetText("设置");
    self.btn_opts:SetRelativeWidth(BTN_OPTS_REL_WIDTH);
    self.btn_opts:SetCallback("OnClick", function() WBT.AceConfigDialog:Open(WBT.addon_name); end);

    self.btn_share = GUI.AceGUI:Create("Button");
    self.btn_share:SetRelativeWidth(BTN_SHARE_REL_WIDTH);
    self.btn_share:SetText("分享");
    self.btn_share:SetCallback("OnClick", WBT.Functions.AnnounceTimerInChat);

    self.btn_container = GUI.AceGUI:Create("SimpleGroup");
    self.btn_container.frame:SetFrameStrata("LOW");
    self.btn_container:SetLayout("Flow");
    self.btn_container:SetWidth(self.width);
    self.btn_container:AddChild(self.btn_opts);
    self.btn_container:AddChild(self.btn_req);
    self.btn_container:AddChild(self.btn_share);

    self.gui_container = GUI.AceGUI:Create("SimpleGroup");
    self.gui_container.frame:SetFrameStrata("LOW");
    self.gui_container:SetLayout("List");
    self.gui_container:AddChild(self.window);
    self.gui_container:AddChild(self.btn_container);

    -- I didn't notice any "OnClose" for the gui_container
    -- ("SimpleGroup") so it's handled through the
    -- Window class instead.
    self.window:SetCallback("OnClose", function()
        self:CleanUpWidgetsAndRelease();
    end);

    self:CreateLabels();
    self:InitPosition();
    self:SaveGUIPositionOnMove();

    self:Show();                -- Initialize visibility (arbitrarily chosen as shown) ...
    self:UpdateGUIVisibility(); -- ... and then set correct visibility from options and so on.

    return self;
end


-- The code for setting and getting options, and for creating the options GUI (i.e. /wbt).
-- 
-- When an option is changed, the GUI is also immediately updated.
local Options = {};
WBT.Options = Options;

local GUI = WBT.GUI;
local Util = WBT.Util;
local BossData = WBT.BossData;
local Sound = WBT.Sound;

Options.NUM_CYCLES_TO_SHOW_MAX = 5;

----- Setters and Getters for options -----

local OptionsItem = {};

function OptionsItem.CreateDefaultGetter(var_name)
    local function getter()
        return WBT.db.global[var_name];
    end
    return getter;
end

function OptionsItem.CreateDefaultSetter(var_name)
    local function setter(state)
        WBT.db.global[var_name] = state;
        WBT.GUI:Rebuild();
    end
    return setter;
end

function OptionsItem:New(var_name, status_msg)
    local ci = {
        get = OptionsItem.CreateDefaultGetter(var_name);
        set = OptionsItem.CreateDefaultSetter(var_name);
        msg = status_msg,
    };

    setmetatable(ci, self);
    self.__index = self;

    return ci;
end

local ToggleItem = {};

function ToggleItem:New(var_name, status_msg)
    local ti = OptionsItem:New(var_name, status_msg);

    setmetatable(ti, self);
    self.__index = self;

    return ti;
end

function ToggleItem.GetColoredStatus(status_var)
    local color = Util.COLOR_RED;
    local status = "disabled";
    if status_var then
        color = Util.COLOR_GREEN;
        status = "enabled";
    end

    return color .. status .. Util.COLOR_DEFAULT;
end

function ToggleItem:PrintFormattedStatus(status_var)
    if self.msg then
        WBT:Print(self.msg .. " " .. self.GetColoredStatus(status_var) .. ".");
    end
end

function ToggleItem:Toggle()
    local new_state = not self.get();
    self.set(new_state);
    -- FIXME: Commented out for now. Was intended for when called from CLI.
--    self:PrintFormattedStatus(new_state);
    WBT.GUI:Update();
end

local SelectItem = {};

function SelectItem:OverrideGetter(default_key)
    local default_getter_fptr = self.get;
    self.get = function()
        local key = default_getter_fptr();
        if key == nil then
            return default_key;
        end
        return key;
    end
end

function SelectItem:New(var_name, status_msg, mkt, mkt_options_key, mkt_values_key, default_key)
    local si = OptionsItem:New(var_name, status_msg);
    si.mkt = mkt; -- MultiKeyTable
    si.mkt_options_key = mkt_options_key;
    si.mkt_values_key = mkt_values_key;
    si.options = si.mkt:GetAllSubVals(si.mkt_options_key);

    setmetatable(si, self);
    self.__index = self;

    si:OverrideGetter(default_key);

    return si;
end

function SelectItem:Key()
    return self:get();
end

function SelectItem:Value()
    local subtbl = self.mkt:GetSubtbl(self.mkt_options_key, self:Key());
    return subtbl[self.mkt_values_key];
end

local RangeItem = {};

function RangeItem:OverrideGetter(default_val)
    local default_getter = self.get;
    self.get = function()
        local val = default_getter();
        if val == nil then
            return default_val;
        end
        return val;
    end
end

function RangeItem:New(var_name, status_msg, default_val)
    local si = OptionsItem:New(var_name, status_msg);

    setmetatable(si, self);
    self.__index = self;

    si:OverrideGetter(default_val);

    return si;
end

local function ShowGUI(show)
    WBT.db.global.hide_gui = not show;

    if show and not GUI:ShouldShow() then
        WBT:Print("The GUI will show when next you enter a boss zone.");
    end

    GUI:Update();
end

function Options.InitializeItems()
    local logger_opts = WBT.Logger.options_tbl;
    local sound_opts =  Sound.sound_tbl;
    Options.show_gui                 = ToggleItem:New("show_gui",                 nil);
    Options.show_boss_zone_only      = ToggleItem:New("show_boss_zone_only",      "Only show GUI in boss zone mode is now");
    Options.lock                     = ToggleItem:New("lock",                     "GUI lock is now");
    Options.global_gui_position      = ToggleItem:New("global_gui_position",      nil);
    Options.sound                    = ToggleItem:New("sound_enabled",            "Sound is now");
    Options.assume_realm_keeps_shard = ToggleItem:New("assume_realm_keeps_shard", "Option to assume realms do not change shards is now");
    Options.multi_realm              = ToggleItem:New("multi_realm",              "Option to show timers for other shards is now");
    Options.highlight                = ToggleItem:New("highlight",                "Highlighting of current zone is now");
    Options.show_saved               = ToggleItem:New("show_saved",               "Showing if saved on boss (on timer) is now");
    Options.show_realm               = ToggleItem:New("show_realm",               "Showing realm on which timer was recorded is now");
    Options.dev_silent               = ToggleItem:New("dev_silent",               "Silent mode is now");
    Options.alert_when_saved         = ToggleItem:New("alert_when_saved",         "Option alert_when_saved is now");
    Options.log_level                = SelectItem:New("log_level",                "Log level is now",         logger_opts.tbl, logger_opts.keys.option, logger_opts.keys.log_level, WBT.defaults.global.log_level);
    Options.spawn_alert_sound        = SelectItem:New("spawn_alert_sound",        "Spawn alert sound is now", sound_opts.tbl,  sound_opts.keys.option,  sound_opts.keys.file_id,    WBT.defaults.global.spawn_alert_sound);
    Options.spawn_alert_sec_before   = RangeItem:New("spawn_alert_sec_before",    "Spawn alert sound sec before is now", WBT.defaults.global.spawn_alert_sec_before);
    Options.cyclic                   = ToggleItem:New("cyclic",                   "Cyclic mode is now");
    Options.num_cycles_to_show       = RangeItem:New("num_cycles_to_show",        "Number of cycles that expired timers are shown is now", WBT.defaults.global.max_num_cycles);

    -- Wrapping in 'play sound file when selected'.
    local spawn_alert_sound_set_temp = Options.spawn_alert_sound.set;
    Options.spawn_alert_sound.set = function(state)
        spawn_alert_sound_set_temp(state);
        Util.PlaySoundAlert(Options.spawn_alert_sound:Value());
    end

    -- Overriding setter for log_level to use same method as from CLI:
    Options.log_level.set = function(state)
        WBT.Logger.SetLogLevel(state);
    end

    -- Needs to update window position.
    local global_gui_position_set_temp = Options.global_gui_position.set;
    Options.global_gui_position.set = function(state)
        WBT.GUI.SaveGUIPosition();
        global_gui_position_set_temp(state);
        WBT.GUI:InitPosition();
    end

    -- Option show_gui is a bit complicated. Override everything:
    Options.show_gui.set = function(state)
        ShowGUI(state);  -- Makes the option more snappy, i.e don't wait for GUI to read updated options at next tic.
    end
    Options.show_gui.get = function()
        return not WBT.db.global.hide_gui;  -- I don't want to rename db variable, so just negate (hide -> show).
    end
end

----- Slash commands -----

local function PrintHelp()
    WBT.AceConfigDialog:Open(WBT.addon_name);
    local indent = "   ";
    WBT:Print("WorldBossTimers slash commands:");
    WBT:Print("/wbt reset"       .. " --> 清除所有计时");
    WBT:Print("/wbt gui-reset"   .. " --> 重置小窗口位置");
    WBT:Print("/wbt saved"       .. " --> 已杀死的boss");
    WBT:Print("/wbt alert-when-saved" .. " --> Play alerts even when saved");
    WBT:Print("/wbt show"        .. " --> 显示小窗口");
    WBT:Print("/wbt hide"        .. " --> 隐藏小窗口");
    WBT:Print("/wbt gui-toggle"       .. " --> Toggle visibility of the timers window");
    WBT:Print("/wbt log <level>"      .. " --> Set log level for debug purposes");
end

function Options.SlashHandler(input)
    local arg1, arg2 = strsplit(" ", input);
    if arg1 then
        arg1 = arg1:lower();
    end

    if arg1 == "hide" then
        ShowGUI(false);
    elseif arg1 == "show" then
        ShowGUI(true);
    elseif arg1 == "gui-toggle" then
        Options.show_gui:Toggle();
    elseif arg1 == "share" then
        WBT.Functions.AnnounceTimerInChat();
    elseif arg1 == "r"
            or arg1 == "reset"
            or arg1 == "restart" then
        WBT.ResetKillInfo();
    elseif arg1 == "s"
            or arg1 == "saved"
            or arg1 == "save" then
        WBT.PrintKilledBosses();
    elseif arg1 == "request" then
        WBT.RequestKillData();
    elseif arg1 == "sound" then
        local sound_type_args = {Sound.SOUND_CLASSIC, Sound.SOUND_FANCY};
        if Util.SetUtil.ContainsValue(sound_type_args, arg2) then
            WBT.db.global.sound_type = arg2;
            WBT:Print("SoundType: " .. arg2);
        else
            Options.sound:Toggle();
        end
    elseif arg1 == "cyclic" then
        Options.cyclic:Toggle();
    elseif arg1 == "multi" then
        Options.multi_realm:Toggle();
    elseif arg1 == "zone" then
        Options.show_boss_zone_only:Toggle();
    elseif arg1 == "lock" then
        Options.lock:Toggle();
    elseif arg1 == "gui-reset" then
        WBT.GUI:ResetPosition();
    elseif arg1 == "log" then
        WBT.Logger.SetLogLevel(arg2);
    elseif arg1 == "alert-when-saved" then
        local opt = Options.alert_when_saved;
        opt:Toggle();
        opt:PrintFormattedStatus(opt:get());
    else
        PrintHelp();
    end
end

-- Counter so I don't have to increment order all the time.
-- Option items are ordered as they are inserted.
local t_cnt = { 0 };
function t_cnt:plusplus()
    self[1] = self[1] + 1;
    return self[1];
end

----- Options table -----
function Options.InitializeOptionsTable()
    local desc_toggle = "开启/关闭";

    Options.optionsTable = {
      type = "group",
      childGroups = "select",
      args = {
        hints = {
            name =  -- Hint_1
                    Util.ColoredString(Util.COLOR_ORANGE, "提示:") ..
                    " - ctrl+点击显示为 " .. Util.ColoredString(Util.COLOR_RED, "红色") .. " 的计时,可以清除该计时.\n" ..
                    -- Hint_2
                    Util.ColoredString(Util.COLOR_ORANGE, "提示:") ..
                    " - ctrl+shift+点击可以清除该计时.\n",
            order = t_cnt:plusplus(),
            type = "description",
            fontSize = "medium",
            width = "full",
        },
        _add_distance_to_next_option = {
            name = "",
            order = t_cnt:plusplus(),
            type = "description",
            width = "full",
        },
        show = {
            name = "显示小窗口",
            order = t_cnt:plusplus(),
            desc = desc_toggle,
            type = "toggle",
            width = "full",
            set = function(info, val) Options.show_gui:Toggle(); end,
            get = function(info) return Options.show_gui.get(); end,
        },
        show_boss_zone_only = {
            name = "仅在BOSS区域显示窗口界面",
            order = t_cnt:plusplus(),
            desc = desc_toggle,
            type = "toggle",
            width = "full",
            set = function(info, val) Options.show_boss_zone_only:Toggle(); end,
            get = function(info) return Options.show_boss_zone_only.get(); end,
        },
        lock = {
            name = "窗口界面锁定",
            order = t_cnt:plusplus(),
            desc = "锁定/移动 计时窗口界面",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.lock:Toggle(); end,
            get = function(info) return Options.lock.get() end,
        },
        global_gui_position = {
            name = "小窗口默认位置",
            order = t_cnt:plusplus(),
            desc = "",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.global_gui_position:Toggle(); end,
            get = function(info) return Options.global_gui_position.get(); end,
        },
        sound = {
            name = "开启警报声",
            order = t_cnt:plusplus(),
            desc = desc_toggle,
            type = "toggle",
            width = "full",
            set = function(info, val) Options.sound:Toggle(); end,
            get = function(info) return Options.sound.get(); end,
        },
        assume_realm_keeps_shard = {
            name = "无论是否在boss所在地图",
            order = t_cnt:plusplus(),
            desc = "当在其他地图时，计时清除. " ..
                   "（建议开启，不过不在boss地图时无法确定位面是否切换，所以可能不准）",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.assume_realm_keeps_shard:Toggle(); end,
            get = function(info) return Options.assume_realm_keeps_shard.get(); end,
        },
        multi_realm = {  -- NOTE: Should be named multi_shard, but to keep user set option values, it was not renamed.
            name = "显示位面id且保留其他位面的计时",
            order = t_cnt:plusplus(),
            desc = "（请注意计时器位面是否已经变更）",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.multi_realm:Toggle(); end,
            get = function(info) return Options.multi_realm.get(); end,
        },
        highlight = {
            name = "突出显示当前地区中的BOSS",
            order = t_cnt:plusplus(),
            desc = "当前区域中的BOSS将使用不同的颜色:\n" ..
                    Util.ColoredString(Util.COLOR_LIGHTGREEN, "绿色") .. " 计时未过期\n" ..
                    Util.ColoredString(Util.COLOR_YELLOW, "黄色") .." 计时已过期(需开启循环计时)",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.highlight:Toggle(); end,
            get = function(info) return Options.highlight.get(); end,
        },
        show_saved = {
            name = "记录击杀",
            order = t_cnt:plusplus(),
            desc = "计时后的'X'的颜色' (" .. Util.ColoredString(Util.COLOR_RED, "X") .. "（击杀）/" .. Util.ColoredString(Util.COLOR_GREEN, "（未击杀)") .. ")" ..
                    " 记录你是否已经击杀过此BOSS.\n" ..
                    "N注意:  'X' 的颜色没有特殊含义。",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.show_saved:Toggle(); end,
            get = function(info) return Options.show_saved.get(); end,
        },
        show_realm = {
            name = "显示服务器",
            order = t_cnt:plusplus(),
            desc = "该计时所在服务器的首个字",
            type = "toggle",
            width = "full",
            set = function(info, val) Options.show_realm:Toggle(); end,
            get = function(info) return Options.show_realm.get(); end,
        },
        cyclic = {
            name = "循环模式 (显示已过期计时",
            order = t_cnt:plusplus(),
            desc = "如果你错过了,计时将循环并变为红色",
            type = "toggle",
            width = "normal",
            set = function(info, val) Options.cyclic:Toggle(); end,
            get = function(info) return Options.cyclic.get(); end,
        },
        num_cycles_to_show = {
            name = "循环次数",
            order = t_cnt:plusplus(),
            desc = "如果设置为最大值“5”，循环将一直持续",
            type = "range",
            min = 0,
            max = Options.NUM_CYCLES_TO_SHOW_MAX,
            softMin = 0,
            softMax = Options.NUM_CYCLES_TO_SHOW_MAX,
            bigStep = 1,
            isPercent = false,
            width = "normal",
            set = function(info, val) Options.num_cycles_to_show.set(val); end,
            get = function(info) return Options.num_cycles_to_show.get(); end,
        },
        _fill_rest_of_line = {
            name = "",
            order = t_cnt:plusplus(),
            type = "description",
            width = "full",
        },
        log_level = {
            name = "日志详细程度",
            order = t_cnt:plusplus(),
            desc = "Log level",
            type = "select",
            style = "dropdown",
            width = "normal",
            values = Options.log_level.options,
            set = function(info, val) Options.log_level.set(val); end,
            get = function(info) return Options.log_level.get(); end,
        },
        spawn_alert_sound = {
            name = "警报声",
            order = t_cnt:plusplus(),
            desc = "当BOSS刷新时发出声音警报",
            type = "select",
            style = "dropdown",
            width = "normal",
            values = Options.spawn_alert_sound.options,
            set = function(info, val) Options.spawn_alert_sound.set(val); end,
            get = function(info) return Options.spawn_alert_sound.get(); end,
        },
        spawn_alert_sec_before = {
            name = "刷新提醒",
            order = t_cnt:plusplus(),
            desc = "提前多长时间提醒boss即将刷新（秒）",
            type = "range",
            min = 0,
            max = 60*5,
            softMin = 0,
            softMax = 30,
            bigStep = 1,
            isPercent = false,
            width = "normal",
            set = function(info, val) Options.spawn_alert_sec_before.set(val); end,
            get = function(info) return Options.spawn_alert_sec_before.get(); end,
        },
      }
    }
end

function Options.Initialize()
    Options.InitializeItems();
    Options.InitializeOptionsTable();
end


--  KillInfo: The class with the data for showing a boss respawn timer.
-- Note that the timers themselves are GUI text labels.
local Util = WBT.Util;
local Options = WBT.Options;

local KillInfo = {};
WBT.KillInfo = KillInfo;

KillInfo.CURRENT_VERSION = "v1.12";
KillInfo.UNKNOWN_SHARD = -1;

local RANDOM_DELIM = "-";

local ID_DELIM        = ";";
local ID_PART_UNKNOWN = "_";


function KillInfo.CompareTo(t, a, b)
    -- "if I'm comparing 'a' and 'b', return true when 'a' should come first"
    local k1 = t[a];
    local k2 = t[b];

    if k1:IsExpired() and not k2:IsExpired() then
        return false;
    elseif not k1:IsExpired() and k2:IsExpired() then
        return true;
    end

    return k1:GetSecondsUntilLatestRespawn() < k2:GetSecondsUntilLatestRespawn();
end

function KillInfo.IsValidID(id)
    return KillInfo.ParseID(id) and true;
end

-- Returns nil if the parsing fails.
function KillInfo.ParseID(id)
    local boss_name, shard_id, map_id = strsplit(ID_DELIM, id);

    if not boss_name then
        return nil;
    end

    return {
        boss_name = boss_name,
        shard_id = shard_id,
        map_id = map_id,
    };
end

function KillInfo.CreateID(boss_name, shard_id, map_id)
    -- Unique ID used as key in the global table of tracked KillInfos and GUI labels.
    --
    -- Note on map_id: It's necessary to make Zandalari Warbringers unique.

    if shard_id == nil or shard_id == KillInfo.UNKNOWN_SHARD then
        shard_id = ID_PART_UNKNOWN;
    end

    local map_id = map_id or WBT.GetCurrentMapId();

    return table.concat({boss_name, shard_id, map_id}, ID_DELIM);
end

function KillInfo:ID()
    return self.CreateID(self.boss_name, self.shard_id, self.map_id);
end

function KillInfo:HasShardID()
    return self.shard_id ~= nil;
end

-- Needed in order to verify that all fields are present.
function KillInfo:IsValidVersion()
    return self.version and self.version == KillInfo.CURRENT_VERSION;
end

function KillInfo:SetInitialValues()
    self.version               = KillInfo.CURRENT_VERSION;
    self.realm_name            = GetRealmName(); -- Only use for printing!
    self.realm_name_normalized = GetNormalizedRealmName();
    self.map_id                = WBT.GetCurrentMapId();
    self.has_triggered_respawn = false;
end

-- NOTE:
-- This function is a reminder that the design is to update KillInfo.CURRENT_VERSION (and thereby clear
-- all user KillInfos), rather than try to upgrade existing ones. The reason is that it makes the code simpler,
-- and should not impact users too much if it only happens once in a while.
function KillInfo:Upgrade()
    -- Don't implement this function.
end

function KillInfo:Print(indent)
    print(indent .. "boss_name: "             .. self.boss_name);
    print(indent .. "version: "               .. self.version);
    print(indent .. "realm_name: "            .. self.realm_name);
    print(indent .. "realm_name_normalized: " .. self.realm_name_normalized);
    print(indent .. "shard_id: "              .. self.shard_id);
    print(indent .. "map_id: "                .. self.map_id);
    print(indent .. "has_triggered_respawn: " .. tostring(self.has_triggered_respawn));
end

function KillInfo:SetNewDeath(t_death)
    -- FIXME: It doesn't make sense to call this function from here. I think it's
    -- a remnant from the time when the addon tried to upgrade KillInfos.
    self:SetInitialValues();

    self.t_death = t_death;
end

function KillInfo:New(boss_name, t_death, shard_id)
    local ki = {};

    setmetatable(ki, self);
    self.__index = self;

    ki.boss_name = boss_name;
    ki.db = WBT.BossData.Get(boss_name);  -- FIXME: Convert to fcn, and fix calls to WBT.BossData.Get(self.boss_name)
    ki.shard_id = shard_id or KillInfo.UNKNOWN_SHARD;

    ki:SetNewDeath(t_death);

    return ki;
end

function KillInfo:Deserialize(serialized)
    local ki = serialized;
    setmetatable(ki, self);
    self.__index = self;

    -- Workaround: Update old timers with new db object in case BossData has been updated in new addon version.
    -- FIXME: Don't save db object. See KillInfo.New.
    ki.db = WBT.BossData.Get(ki.boss_name);

    return ki;
end

function KillInfo:HasRandomSpawnTime()
    return self.db.min_respawn ~= self.db.max_respawn;
end

function KillInfo:IsSafeToShare(error_msgs)

    if not self:IsValidVersion() then
        table.insert(error_msgs, "Timer was created with an old version of WBT and is now outdated.");
    end
    if self:IsExpired() then
        table.insert(error_msgs, "Timer has expired.");
    end
    if self:HasUnknownShard() then
        -- It's impossible to tell where it comes from. Player may have received it when server-jumping or
        -- what not. To avoid complexity, just don't allow sharing it.
        table.insert(error_msgs, "Timer doesn't have a shard ID. (This means that it was shared to you by a "
                              .. "player with an old version of WBT.)");  -- WBT v.1.9 or less.
    else
        local shard_id = WBT.GetCurrentShardID();
        if WBT.IsUnknownShard(shard_id) then
            table.insert(error_msgs, "Current shard ID is unknown. It will automatically be detected when "
                                  .. "mousing over an NPC.");
        elseif self.shard_id ~= shard_id then
            table.insert(error_msgs, "Kill was made on shard ID " .. self.shard_id
                                  .. ", but you are on " .. shard_id .. ".");
        end
    end

    if Util.TableIsEmpty(error_msgs) then
        return true;
    end
    return false;
end

function KillInfo:GetServerDeathTime()
    return self.t_death;
end

function KillInfo:GetSecondsSinceDeath()
    return GetServerTime() - self.t_death;
end

function KillInfo:GetEarliestRespawnTimePoint()
    return self.t_death + self.db.min_respawn;
end

function KillInfo:GetLatestRespawnTimePoint()
    return self.t_death + self.db.max_respawn;
end


function KillInfo:GetNumCycles()
    local t = self:GetLatestRespawnTimePoint() - GetServerTime();
    local n = 0;
    while t < 0 do
        t = t + self.db.max_respawn;
        n = n + 1;
    end
    return n;
end

function KillInfo:GetSecondsUntilEarliestRespawn(opt_cyclic)
    return self:GetSecondsUntilLatestRespawn(opt_cyclic) - (self.db.max_respawn - self.db.min_respawn);
end

function KillInfo:GetSecondsUntilLatestRespawn(opt_cyclic)
    local t = self:GetLatestRespawnTimePoint() - GetServerTime();
    if opt_cyclic and t < 0 then
        t = t + (self:GetNumCycles() * self.db.max_respawn);
    end
    return t;
end

function KillInfo:GetSpawnTimeAsText()
    if not self:IsValidVersion() then
        return "--outdated--";
    end

    if self:HasRandomSpawnTime() then
        local t_lower = self:GetSecondsUntilEarliestRespawn(true);
        local t_upper = self:GetSecondsUntilLatestRespawn(true);
        if t_lower == nil or t_upper == nil then
            return "--invalid--";
        elseif t_lower < 0 then
            -- Just display 0 instead of 00:00 to make it easier to read
            return "0" .. RANDOM_DELIM .. Util.FormatTimeSeconds(t_upper)
        else
            return Util.FormatTimeSeconds(t_lower) .. RANDOM_DELIM .. Util.FormatTimeSeconds(t_upper)
        end
    else
        return Util.FormatTimeSeconds(self:GetSecondsUntilEarliestRespawn(true));
    end
end

function KillInfo:InTimeWindow(from, to)
    local t_now = GetServerTime();
    return from <= t_now and t_now <= to;
end

function KillInfo:ShouldRespawnAlertPlayNow(offset)
    local t_before_respawn = self:GetLatestRespawnTimePoint() - offset;

    local trigger = self:InTimeWindow(t_before_respawn, t_before_respawn + 2)
            and WBT.InZoneAndShardForTimer(self)
            and WBT.PlayerIsInBossPerimiter(self.boss_name)
            and self:IsValidVersion()
            and not self:IsExpired()
            and not self.has_triggered_respawn;
    if trigger then
        self.has_triggered_respawn = true;
    end

    return trigger;
end

function KillInfo:IsExpired()
    return self:GetSecondsUntilLatestRespawn() < 0;
end

function KillInfo:IsCyclicExpired()
    if not Options.cyclic.get() then
        return self:IsExpired();
    elseif Options.num_cycles_to_show.get() == Options.NUM_CYCLES_TO_SHOW_MAX then
        -- Special case. Allows timers to always be shown.
        return false;
    end
    return Options.num_cycles_to_show.get() < self:GetNumCycles();
end

function KillInfo:HasUnknownShard()
    return self.shard_id == KillInfo.UNKNOWN_SHARD;
end

function KillInfo:IsOnCurrentShard()
    if self:HasUnknownShard() then
        return false;
    elseif Options.assume_realm_keeps_shard.get() and (self.shard_id == WBT.GetSavedShardID(WBT.GetCurrentMapId())) then
        return true;
    else
        return self.shard_id == WBT.GetCurrentShardID();
    end
end

-- Returns true if the KillInfo comes from the last known shard for the
-- zone its boss belongs to.
function KillInfo:IsOnSavedRealmShard()
    if self:HasUnknownShard() then
        return false;
    end

    local zone_id = WBT.BossData.Get(self.boss_name).map_id;
    return WBT.GetSavedShardID(zone_id) == self.shard_id;
end


-- The core code.
--
-- Entry point: WBT.AceAddon:OnEnable
if GetLocale() == "zhCN" then
  WorldBossTimersLocal = "|cff33ff99[稀有]|r刷新时间";
elseif GetLocale() == "zhTW" then
  WorldBossTimersLocal = "|cff33ff99[稀有]|r刷新时间";
else
  WorldBossTimersLocal = "WorldBossTimers";
end
WBT.addon_name = WorldBossTimersLocal;

local KillInfo = WBT.KillInfo;
local BossData = WBT.BossData;
local Options  = WBT.Options;
local Sound    = WBT.Sound;
local Util     = WBT.Util;
local GUI      = WBT.GUI;

-- Functions that will be created during startup.
WBT.Functions = {
    AnnounceTimerInChat = nil;
};

WBT.AceAddon = LibStub("AceAddon-3.0"):NewAddon("WBT", "AceConsole-3.0");

-- Workaround to keep the nice WBT:Print function.
WBT.Print = function(self, text) WBT.AceAddon:Print(text) end


-- Enum that describes why the GUI was requested to update.
WBT.UpdateEvents = {
    UNSPECIFIED    = 0,
    SHARD_DETECTED = 1,
}

--------------------------------------------------------------------------------
-- Logger
--------------------------------------------------------------------------------

-- Global logger. OK since WoW is single-threaded.
WBT.Logger = {
    options_tbl = nil; -- Used to show options in GUI.
};
local Logger = WBT.Logger;
Logger.LogLevels =  {
    Nothing = {
        value = 0;
        name  = "Nothing";
        color = Util.COLOR_DEFAULT;
    },
    Info = {
        value = 1;
        name  = "Info";
        color = Util.COLOR_BLUE;
    },
    Debug = {
        value = 10;
        name  = "Debug";
        color = Util.COLOR_PURPLE;
    }
};

function Logger.InitializeOptionsTable()
    local tmp = {};
    for _, v in pairs(Logger.LogLevels) do
        table.insert(tmp, {option = v.name, log_level = v.name});
    end
    Logger.options_tbl = {
        keys = {
            option = "option",
            log_level = "log_level",
        },
        tbl = WBT.Util.MultiKeyTable:New(tmp),
    };
end

function Logger.Initialize()
    Logger.InitializeOptionsTable();
end

function Logger.PrintLogLevelHelp()
    WBT:Print("Valid <level> values:");
    for k in pairs(Logger.LogLevels) do
        WBT:Print("  " .. k:lower());
    end
end

-- @param level_name    Log level given as string.
function Logger.SetLogLevel(level_name)
    if not level_name then
        Logger.PrintLogLevelHelp();
        return;
    end

    -- Make sure input starts with uppercase and rest is lowercase to match
    -- table keys.
    level_name = level_name:sub(1,1):upper() .. level_name:sub(2,level_name:len()):lower();

    local log_level = Logger.LogLevels[level_name];
    if log_level then
        WBT:Print("Setting log level to: " .. Util.ColoredString(log_level.color, log_level.name));
        WBT.db.global.log_level = level_name;
    else
        WBT:Print("Requested log level '" .. level_name .. "' doesn't exist.");
    end
end

-- @param varargs   A single table containing a list of strings, or varargs of
--                  strings.
function Logger.Log(log_level, ...)
    if Logger.LogLevels[WBT.db.global.log_level].value < log_level.value then
        return;
    end

    local prefix = "[" .. Util.ColoredString(log_level.color, log_level.name) .. "]: ";
    local arg1 = select(1, ...);
    if not arg1 then
        return;
    elseif Util.IsTable(arg1) then
        for _, msg in pairs(arg1) do
            WBT:Print(prefix .. msg)
        end
    else
        WBT:Print(prefix .. Util.MessageFromVarargs(...))
    end
end

function Logger.Debug(...)
    Logger.Log(Logger.LogLevels.Debug, ...);
end

function Logger.Info(...)
    Logger.Log(Logger.LogLevels.Info, ...);
end

--------------------------------------------------------------------------------

-- The frames that handle events. Used as an access point for testing.
WBT.EventHandlerFrames = {
    main_loop                       = nil,
    combat_frame                    = nil,
    timer_parser                    = nil,
    shard_detection_frame           = nil,
    shard_detection_restarter_frame = nil,
    gui_visibility_frame            = nil,
}


local g_gui = {};
local g_kill_infos = {};

-- The shard id that the player currently is at. Intended only for highlighting
-- of timers in GUI.
local g_current_shard_id;

local CHANNEL_ANNOUNCE = "SAY";
local SERVER_DEATH_TIME_PREFIX = "WorldBossTimers:";
local CHAT_MESSAGE_TIMER_REQUEST = "哪位大佬可以分享下WBT计时数据?";

WBT.defaults = {
    global = {
        kill_infos = {},
        sound_type = Sound.SOUND_CLASSIC,
        connected_realms_data = {},
        -- Options:
        lock = false,
        global_gui_position = false,
        sound_enabled = true,
        assume_realm_keeps_shard = true,
        multi_realm = true,
        show_boss_zone_only = true,
        highlight = true,
        show_saved = true,
        show_realm = true,
        dev_silent = true,
        alert_when_saved = false,
        cyclic = true,
        max_num_cycles = 1,
        log_level = "Info",
        spawn_alert_sound = Sound.SOUND_KEY_BATTLE_BEGINS,
        spawn_alert_sec_before = 8,
        -- Options without matching OptionsItem:
        hide_gui = false,
    },
    char = {
        boss = {},
    },
};

--------------------------------------------------------------------------------
-- ConnectedRealmsData
--------------------------------------------------------------------------------
local ConnectedRealmsData = {};

-- Data about the connected realms that needs to be saved to DB.
function ConnectedRealmsData:New()
    local crd = {};
    crd.shard_id_per_zone = {};
    return crd;
end

function WBT.GetRealmKey()
    return table.concat(Util.GetConnectedRealms(), "_");
end
--------------------------------------------------------------------------------

function WBT.IsUnknownShard(shard_id)
    return shard_id == nil or shard_id == KillInfo.UNKNOWN_SHARD;
end

-- Getter for access via other modules.
function WBT.GetCurrentShardID()
    return g_current_shard_id or KillInfo.UNKNOWN_SHARD;
end

-- Returns the last known shard id for the current realm and the given zone.
function WBT.GetSavedShardID(zone_id)
    local crd = WBT.db.global.connected_realms_data[WBT.GetRealmKey()];
    if crd == nil then
        return KillInfo.UNKNOWN_SHARD;
    end
    local shard_id = crd.shard_id_per_zone[zone_id];
    return shard_id or KillInfo.UNKNOWN_SHARD;
end

function WBT.PutSavedShardIDForZone(zone_id, shard_id)
    if zone_id == nil then
        -- Wow's zone ID API is bugged and returns nil for some zones, e.g. Valdrakken time-portal room.
        return;
    end
    local crd = WBT.db.global.connected_realms_data[WBT.GetRealmKey()];
    if crd == nil then 
        crd = ConnectedRealmsData:New();
        WBT.db.global.connected_realms_data[WBT.GetRealmKey()] = crd;
    end
    crd.shard_id_per_zone[zone_id] = shard_id;
end

function WBT.PutSavedShardID(shard_id)
    WBT.PutSavedShardIDForZone(WBT.GetCurrentMapId(), shard_id)
end

function WBT.ParseShardID(unit_guid)
    local unit_type = strsplit("-", unit_guid);
    if unit_type == "Creature" or unit_type == "Vehicle" then
        local shard_id_str = select(5, strsplit("-", unit_guid));
        return tonumber(shard_id_str);
    else
        return nil;
    end
end

function WBT.HasKillInfoExpired(ki_id)
    local ki = g_kill_infos[ki_id];
    if ki == nil then
        return true;
    end
    if ki:IsValidVersion() then
        return ki:IsExpired();
    end

    return false;
end

function WBT.IsBoss(name)
    return Util.SetUtil.ContainsKey(BossData.GetAll(), name);
end

-- Warning: This can different result, at least during addon loading / player enter world events.
-- For example it returns the map ID for Kalimdor instead of Tanaris.
function WBT.GetCurrentMapId()
    return C_Map.GetBestMapForUnit("player");
end

function WBT.IsInZoneOfBoss(name)
    return WBT.GetCurrentMapId() == BossData.Get(name).map_id;
end

function WBT.BossesInCurrentZone()
    local t = {};
    for name, boss in pairs(BossData.GetAll()) do
        if WBT.IsInZoneOfBoss(name) then
            table.insert(t, boss);
        end
    end
    return t;
end

function WBT.InBossZone()
    local current_map_id = WBT.GetCurrentMapId();

    for _, boss in pairs(BossData.GetAll()) do
        if boss.map_id == current_map_id then
            return true;
        end
    end

    return false;
end

-- Returns all the KillInfos on the current zone and current shard.
--
-- An empty table is returned if no matching KillInfo is found.
--
-- KillInfos without a known shard (i.e. acquired via another player sharing them from an
-- old version of WBT without shard data) are always included.
function WBT.KillInfosInCurrentZoneAndShard()
    local res = {};
    for _, boss in pairs(WBT.BossesInCurrentZone()) do
        -- Add KillInfo without shard, i.e. old-version-WBT:
        local ki_no_shard = g_kill_infos[KillInfo.CreateID(boss.name)];
        if ki_no_shard then
            table.insert(res, ki_no_shard);
        end

        -- Add KillInfo for current shard (or assumed current shard):
        local curr_shard_id = Options.assume_realm_keeps_shard.get()
                and WBT.GetSavedShardID(WBT.GetCurrentMapId())
                or g_current_shard_id;
        if not WBT.IsUnknownShard(curr_shard_id) then
            local ki_shard = g_kill_infos[KillInfo.CreateID(boss.name, curr_shard_id)];
            if ki_shard then
                table.insert(res, ki_shard);
            end
        end
    end
    return res;
end

function WBT.GetPlayerCoords()
    return C_Map.GetPlayerMapPosition(WBT.GetCurrentMapId(), "PLAYER"):GetXY();
end

function WBT.PlayerDistanceToBoss(boss_name)
    local x, y = WBT.GetPlayerCoords();
    local boss = BossData.Get(boss_name);
    return math.sqrt((x - boss.perimiter.origin.x)^2 + (y - boss.perimiter.origin.y)^2);
end

-- Returns true if player is within boss perimiter, which is defined as a circle
-- around spawn location.
function WBT.PlayerIsInBossPerimiter(boss_name)
    return WBT.PlayerDistanceToBoss(boss_name) < BossData.Get(boss_name).perimiter.radius;
end

-- Returns the KillInfo for the dead boss which the player is waiting for at the current
-- position and shard, if any. Else nil.
function WBT.GetPrimaryKillInfo()
    local found = {};
    for _, ki in pairs(WBT.KillInfosInCurrentZoneAndShard()) do
        if WBT.PlayerIsInBossPerimiter(ki.boss_name) then
            table.insert(found, ki);
        end
    end
    if Util.TableLength(found) > 1 then
        Logger.Debug("发现多个同名boss，只记录其一");
    end
    for _, ki in pairs(found) do
        if not ki:HasUnknownShard() then
            return ki;
        end
    end
    return found[1];  -- Unknown shard.
end

function WBT.InZoneAndShardForTimer(kill_info)
    return WBT.IsInZoneOfBoss(kill_info.boss_name) and kill_info:IsOnCurrentShard();
end

function WBT.GetHighlightColor(kill_info)
    local highlight = Options.highlight.get() and WBT.InZoneAndShardForTimer(kill_info);
    local color;
    if kill_info:IsExpired() then
        if highlight then
            color = Util.COLOR_YELLOW;
        else
            color = Util.COLOR_RED;
        end
    else
        if highlight then
            color = Util.COLOR_LIGHTGREEN;
        else
            color = Util.COLOR_DEFAULT;
        end
    end
    return color;
end

function WBT.GetSpawnTimeOutput(kill_info)
    local color = WBT.GetHighlightColor(kill_info);

    local text = kill_info:GetSpawnTimeAsText();
    text = Util.ColoredString(color, text);

    if Options.show_saved.get() and BossData.IsSaved(kill_info.boss_name) then
        text = text .. " " .. Util.ColoredString(Util.ReverseColor(color), "X");
    end

    return text;
end

local last_request_time = 0;
function WBT.RequestKillData()
    if GetServerTime() - last_request_time > 5 then
        SendChatMessage(CHAT_MESSAGE_TIMER_REQUEST, "SAY");
        last_request_time = GetServerTime();
    end
end
local RequestKillData = WBT.RequestKillData;

function WBT.GetColoredBossName(name)
    return BossData.Get(name).name_colored;
end
local GetColoredBossName = WBT.GetColoredBossName;

-- Intended to be called from clicking an interactive label.
function WBT.ResetBoss(ki_id)
    local kill_info = g_kill_infos[ki_id];

    if IsControlKeyDown() and (IsShiftKeyDown() or kill_info:IsExpired()) then
        g_kill_infos[ki_id] = nil;
        g_gui:Rebuild();
        local name = KillInfo.ParseID(ki_id).boss_name;
        Logger.Info(GetColoredBossName(name) .. " 已被清除。");
    else
        local cyclic = Util.ColoredString(Util.COLOR_RED, "cyclic");
        WBT:Print("Ctrl+左键 " .. cyclic .. " 清除已经失效的计时."
              .. " Ctrl-shift-左键，清除计时 " .. cyclic .. " 开启循环模式可输入: /wbt cyclic");
    end
end

-- TODO: Rename. Also creates some structural texts and not just the payload.
-- (The name is also parsed, but it's not conevient to be part of payload.)
local function CreatePayload(kill_info, send_data_for_parsing)
    local payload = "";
    if send_data_for_parsing then
        local shard_id_part = "";
        if kill_info:HasShardID() then
            shard_id_part = "-" .. kill_info.shard_id;
        end
        payload = " (" .. SERVER_DEATH_TIME_PREFIX .. kill_info:GetServerDeathTime() .. shard_id_part .. ")";
    end

    return payload;
end

local function CreateAnnounceMessage(kill_info, send_data_for_parsing)
    local spawn_time = kill_info:GetSpawnTimeAsText();
    local payload = CreatePayload(kill_info, send_data_for_parsing);
    local msg = kill_info.boss_name .. ": " .. spawn_time .. payload;
    return msg;
end

function WBT.AnnounceSpawnTime(kill_info, send_data_for_parsing)
    local msg = CreateAnnounceMessage(kill_info, send_data_for_parsing);
    if Options.dev_silent.get() then
        WBT:Print(msg);
    else
        SendChatMessage(msg, CHANNEL_ANNOUNCE, DEFAULT_CHAT_FRAME.editBox.languageID, nil);
    end
end

-- Callback for GUI share button
local function GetSafeSpawnAnnouncerWithCooldown()

    -- Create closure that uses t_last_announce as a persistent/static variable
    local t_last_announce = 0;
    function AnnounceSpawnTimeIfSafe()
        local ki = WBT.GetPrimaryKillInfo();
        local announced = false;
        local t_now = GetServerTime();

        if WBT.IsUnknownShard(WBT.GetCurrentShardID()) then
            Logger.Info("位面id未知，请点击附近怪物或者npc获取位面id（牦牛·雷龙·猛犸象上的商人亦可）");
            return announced;
        end
        if not ki then
            Logger.Info("没有该位面该地区指定boss的计时");
            return announced;
        end
        if not ((t_last_announce + 1) <= t_now) then
            Logger.Info("每秒只能分享一次");
            return announced;
        end

        local errors = {};
        if ki:IsSafeToShare(errors) then
            WBT.AnnounceSpawnTime(ki, true);
            t_last_announce = t_now;
            announced = true;
        else
            Logger.Info("不能分享  "  .. GetColoredBossName(ki.boss_name) .. "的计时:");
            Logger.Info(errors);
            return announced;
        end

        return announced;
    end

    return AnnounceSpawnTimeIfSafe;
end

function WBT.PutOrUpdateKillInfo(name, shard_id, t_death)
    t_death = tonumber(t_death);
    local ki_id = KillInfo.CreateID(name, shard_id);
    local ki = g_kill_infos[ki_id];
    if ki then
        ki:SetNewDeath(t_death);
    else
        ki = KillInfo:New(name, t_death, shard_id);
    end

    g_kill_infos[ki_id] = ki;

    g_gui:Update();
end

local function PlaySoundAlertSpawn()
    Util.PlaySoundAlert(Options.spawn_alert_sound:Value());
end

local function PlaySoundAlertBossCombat(name)
    local sound_type = WBT.db.global.sound_type;

    local soundfile = BossData.Get(name).soundfile;
    if sound_type:lower() == Sound.SOUND_CLASSIC:lower() then
        soundfile = Sound.SOUND_FILE_DEFAULT;
    end

    Util.PlaySoundAlert(soundfile);
end

-- NOTE: The handler for combat_frame is not set here, but in the main OnUpdate loop.
local function StartCombatHandler()
    local combat_frame = CreateFrame("Frame", "WBT_COMBAT_FRAME");
    WBT.EventHandlerFrames.combat_frame = combat_frame;

    combat_frame.t_next_alert_boss_combat = 0;

    -- This function is called on every combat event, so needs to be performant.
    local function CombatHandler(...)
        local _, subevent, _, src_unit_guid, _, _, _, dest_unit_guid, _ = CombatLogGetCurrentEventInfo();

        if not (Util.StrEndsWith(subevent, "_DAMAGE") or
                Util.StrEndsWith(subevent, "_MISSED") or  -- E.g. Rustfeather missing on AFK player
                subevent == "UNIT_DIED")
        then
            return;
        end

        -- Find the English name from GUID, to make it work for localization,
        -- instead of using the name in the event args.
        local map_id = WBT.GetCurrentMapId();
        local name = BossData.BossNameFromUnitGuid(dest_unit_guid, map_id) or
                     BossData.BossNameFromUnitGuid(src_unit_guid,  map_id);
        if name == nil then
            return;
        end

        -- Check for boss combat
        local t = GetServerTime();
        if t > combat_frame.t_next_alert_boss_combat then
            -- Don't alert if saved, since that would be annoying for Sha/Galleon in MoP due to their zone-wide size
            if not BossData.IsSaved(name) or Options.alert_when_saved.get() then
                WBT:Print(GetColoredBossName(name) .. " is now engaged in combat!");
                PlaySoundAlertBossCombat(name);
                FlashClientIcon();
            end
        end

        -- Avoid repetition of alert as long as boss is in combat. Should be < 30 sec to
        -- re-alert on Vanish resets.
        combat_frame.t_next_alert_boss_combat = t + 25;

        -- Check for boss death
        if subevent == "UNIT_DIED" then
            local shard_id = WBT.ParseShardID(dest_unit_guid);
            WBT.PutOrUpdateKillInfo(name, shard_id, GetServerTime());
            RequestRaidInfo(); -- Updates which bosses are saved
            g_gui:Update();
        end
    end

    -- Enables or disables the handler which scans for boss combat.
    --
    -- Should run in the main loop (every 1 sec).
    --
    -- Note that there used to be a separate handler which toggled this behavior based on e.g.
    -- ZONE_CHANGED_NEW_AREA, but it was very buggy, most likely due to the map ID not updating
    -- correctly. (Adding delays didn't fix it.)
    function combat_frame.UpdateCombatHandler()
        local handler = nil;
        if WBT.InBossZone() then
            handler = CombatHandler;
        end
        combat_frame:SetScript("OnEvent", handler);
    end

    combat_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

    return combat_frame;
end

function WBT.AceAddon:OnInitialize()
end

function WBT.PrintKilledBosses()
    WBT:Print("Tracked world bosses killed:");

    local none_killed = true;
    for _, boss in pairs(BossData.GetAll()) do
        if BossData.IsSaved(boss.name) then
            none_killed = false;
            WBT:Print(GetColoredBossName(boss.name));
        end
    end
    if none_killed then
        -- There might be other bosses that WBT doesn't track that
        -- have been killed.
        local none_killed_text = "None";
        WBT:Print(none_killed_text);
    end
end

function WBT.ResetKillInfo()
    WBT:Print("Resetting all timers.");
    for k, _ in pairs(g_kill_infos) do
        g_kill_infos[k] = nil;
    end
    g_gui:Rebuild();
end

local function StartShardDetectionHandler()
    WBT.EventHandlerFrames.shard_detection_frame = CreateFrame("Frame", "WBT_SHARD_DETECTION_FRAME");
    local f_detect_shard = WBT.EventHandlerFrames.shard_detection_frame;
    function f_detect_shard:RegisterEvents()
        -- NOTE: This could be improved to also look in combat log, but
        -- doesn't really feel worth adding right now.
        self:RegisterEvent("PLAYER_TARGET_CHANGED");
        self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
    end
    function f_detect_shard:UnregisterEvents()
        self:UnregisterEvent("PLAYER_TARGET_CHANGED");
        self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
    end

    -- Handler for detecting the current shard id.
    function f_detect_shard:Handler(event, ...)
        local unit = "target";
        if event == "UPDATE_MOUSEOVER_UNIT" then
            unit = "mouseover";
        end
        if not UnitExists(unit) then
            return;
        end
        local guid = UnitGUID(unit);
        local unit_type = strsplit("-", guid);
        if unit_type == "Creature" or unit_type == "Vehicle" then
            g_current_shard_id = WBT.ParseShardID(guid);
            WBT.PutSavedShardID(g_current_shard_id);
            Logger.Debug("[ShardDetection]: New shard ID detected:", g_current_shard_id);
            g_gui:Update(WBT.UpdateEvents.SHARD_DETECTED);
            self:UnregisterEvents();
        end
    end
    f_detect_shard:RegisterEvents();
    f_detect_shard:SetScript("OnEvent", f_detect_shard.Handler);

    -- Handler for refreshing the shard id.
    local f_restart = CreateFrame("Frame", "WBT_SHARD_DETECTION_RESTARTER_FRAME");
    WBT.EventHandlerFrames.shard_detection_restarter_frame = f_restart;
    f_restart.delay = 3;  -- Having it as a var allows changing it while testing.
    function f_restart:Handler(...)
        g_current_shard_id = nil;
        g_gui:Update();
        Logger.Debug("[ShardDetection]: Possibly shard change. Shard ID invalidated.");

        -- Wait a while before starting to detect the new shard. When phasing to a new shard it will still
        -- take a while for mobs to despawn in the old shard. These will still give the (incorrect) old shard
        -- id.
        C_Timer.After(self.delay, function(...)  -- Phasing time seems to be like ~1 sec, so 3 sec should often be OK.
            f_detect_shard:RegisterEvents();
        end);
    end
    f_restart:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    f_restart:RegisterEvent("SCENARIO_UPDATE");  -- Seems to fire when you swap shard due to joining a group.
    f_restart:SetScript("OnEvent", f_restart.Handler);
end

local function StartVisibilityHandler()
    local f = CreateFrame("Frame", "WBT_GUI_VISIBILITY_FRAME");
    WBT.EventHandlerFrames.gui_visibility_frame = f;
    f:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    f:SetScript("OnEvent",
        function(...)
            g_gui:Update();
        end
    );
end

local function StartChatParser()

    local function PlayerSentMessage(sender)
        -- Since \b and alike doesnt exist: use "frontier pattern": %f[%A]
        return string.match(sender, GetUnitName("player") .. "%f[%A]") ~= nil;
    end

    local function InitSharedTimersParser()
        local timer_parser = CreateFrame("Frame", "WBT_TIMER_PARSER_FRAME");
        WBT.EventHandlerFrames.timer_parser = timer_parser;

        timer_parser:RegisterEvent("CHAT_MSG_SAY");
        timer_parser:SetScript("OnEvent",
            function(self, event, msg, sender)
                if event == "CHAT_MSG_SAY" then
                    if PlayerSentMessage(sender) then
                        return;
                    elseif string.match(msg, SERVER_DEATH_TIME_PREFIX) ~= nil then
                        -- NOTE: The name may contain dots and spaces, e.g. 'A. Harvester'.
                        local name, data = string.match(msg,
                                "[^A-Z]*" ..                   -- Discard any {rt8} from old versions
                                "([A-Z][A-Za-z%s\\.]+)" ..     -- The boss name
                                "[^\\(]*" ..                   -- Discard visuals, e.g. old {rt8} and timer as text
                                "%(" .. SERVER_DEATH_TIME_PREFIX .. "([%w-\\-]+)" .. "%)");  -- The payload
                        if not data then
                            Logger.Debug("[Parser]: Failed to parse timer. Unknown format.");
                            return;
                        end

                        -- Missing shard_id (as a result of sharing from old versions of WBT) is OK. This will
                        -- result in 'nil', which KillInfo must handle.
                        local t_death, shard_id = strsplit("-", data);
                        t_death  = tonumber(t_death)
                        shard_id = tonumber(shard_id)
                        local ki_id = KillInfo.CreateID(name, shard_id);

                        if not WBT.IsBoss(name) then
                            Logger.Debug("[Parser]: Failed to parse timer. Unknown boss name:", name);
                            return;
                        elseif not WBT.HasKillInfoExpired(ki_id) then
                            Logger.Debug("[Parser]: Ignoring shared timer. Player already has fresh timer.");
                            return;
                        else
                            WBT.PutOrUpdateKillInfo(name, shard_id, t_death);
                            WBT:Print("Received " .. GetColoredBossName(name) .. " timer from: " .. sender);
                        end
                    end
                end
            end
        );
    end

    InitSharedTimersParser();
end

local function DeserializeKillInfos()
    for name, serialized in pairs(WBT.db.global.kill_infos) do
        g_kill_infos[name] = KillInfo:Deserialize(serialized);
    end
end

-- Step1 is performed before deserialization and looks just at the ID and boss name.
local function FilterValidKillInfosStep1()
    -- Perform filtering in two steps to avoid what I guess would
    -- be some kind of "ConcurrentModificationException".

    -- Find invalid:
    local invalid = {};
    for id, ki in pairs(WBT.db.global.kill_infos) do
        if not KillInfo.IsValidID(id) then
            invalid[id] = ki;
        elseif not BossData.BossExists(ki.boss_name) then
            -- Can happen if BossData.lua was manually patched to add more bosses,
            -- and later the user updated the addon, but didn't add back the patched
            -- entries. Not officially supported, but shouldn't cause a crash.
            invalid[id] = ki;
        end
    end

    -- Remove invalid:
    for id, _ in pairs(invalid) do
        Logger.Debug("[PreDeserialize]: Removing invalid KI with ID: " .. id);
        WBT.db.global.kill_infos[id] = nil;
    end
end

-- Step2 is performed after deserialization and checks the internal data.
local function FilterValidKillInfosStep2()
    
    -- Find invalid.
    local invalid = {};
    for id, ki in pairs(g_kill_infos) do
        if not ki:IsValidVersion() then
            invalid[id] = "Invalid version.";
        elseif ki:GetSecondsSinceDeath() > (60*60*24) then
            -- Discard timers older than a day. They are not useful, and the GUI doesn't
            -- scale well. With about 500 timers (on a 2024 system) you'll get an FPS drop
            -- every second during the main loop if the GUI is shown, even if no timers are
            -- shown in it. This avoids that.
            invalid[id] = "Timer is very old.";
        end
    end

    -- Remove invalid.
    for id, msg in pairs(invalid) do
        Logger.Debug("[PostDeserialize]: Removing KI with ID: " .. id .. ". Reason: " .. msg);
        WBT.db.global.kill_infos[id] = nil;
    end
end

local function StartMainLoopHandler(combat_handler)
    local main_loop = CreateFrame("Frame", "WBT_MAIN_LOOP_FRAME");
    WBT.EventHandlerFrames.main_loop = main_loop;

    main_loop.since_update = 0;
    local t_update = 1;
    main_loop:SetScript("OnUpdate", function(self, elapsed)
            self.since_update = self.since_update + elapsed;
            if (self.since_update > t_update) then

                for _, kill_info in pairs(g_kill_infos) do
                    if kill_info:ShouldRespawnAlertPlayNow(Options.spawn_alert_sec_before.get()) then
                        FlashClientIcon();
                        PlaySoundAlertSpawn();
                    end
                end

                combat_handler.UpdateCombatHandler();

                g_gui:Update();

                self.since_update = 0;
            end
        end);
end

-- Addon entry point.
function WBT.AceAddon:OnEnable()
    GUI.Init();

	WBT.db = LibStub("AceDB-3.0"):New("WorldBossTimersDB", WBT.defaults);

    WBT.Functions.AnnounceTimerInChat = GetSafeSpawnAnnouncerWithCooldown();

    GUI.SetupAceGUI();

    local AceConfig = LibStub("AceConfig-3.0");

    Logger.Initialize();
    Options.Initialize();
    AceConfig:RegisterOptionsTable(WBT.addon_name, Options.optionsTable, {});
    WBT.AceConfigDialog = LibStub("AceConfigDialog-3.0");
    WBT.AceConfigDialog:AddToBlizOptions(WBT.addon_name, WBT.addon_name, nil);

    g_gui = GUI:New();

    -- Call unit testing hook:
    if WBT_UnitTest then
        WBT_UnitTest.PreDeserializeHook(WBT);
    end

    -- Initialize g_kill_infos:
    g_kill_infos = WBT.db.global.kill_infos;  -- Alias to make code more readable.
    FilterValidKillInfosStep1();
    DeserializeKillInfos();
    FilterValidKillInfosStep2();

    -- Start event handlers
    StartShardDetectionHandler();
    local combat_frame = StartCombatHandler();
    StartMainLoopHandler(combat_frame);
    StartVisibilityHandler();
    StartChatParser();

    -- Initialize slash handlers
    self:RegisterChatCommand("wbt", Options.SlashHandler);
    self:RegisterChatCommand("worldbosstimers", Options.SlashHandler);
end

function WBT.AceAddon:OnDisable()
end
return WBT;