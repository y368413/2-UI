--## Version: 1.4.3  ## Author: syndenbock  ## SavedVariables: Handynotes_PandariaDB
local Pandaria = {}

Pandaria.HandyNotes = LibStub('AceAddon-3.0'):GetAddon('HandyNotes', true)
if Pandaria.HandyNotes == nil then return end

Pandaria.addon = {};
-- event handling
do
  local events = {};
  local addonFrame = CreateFrame('frame');

  Pandaria.addon.on = function (eventList, callback)
    if (type(eventList) ~= 'table') then
      eventList = {eventList};
    end

    for x = 1, #eventList, 1 do
      local event = eventList[x];
      local list = events[event];

      if (list == nil) then
        events[event] = {callback};
        addonFrame:RegisterEvent(event);
      else
        list[#list + 1] = callback;
      end
    end
  end

  local function eventHandler (self, event, ...)
    for i = 1, #events[event] do
      events[event][i](...);
    end
  end

  addonFrame:SetScript('OnEvent', eventHandler);
end

-- event funnel
Pandaria.addon.funnel = function (eventList, timeSpan, callback)
  local flag = false;

  local funnel = function (...)
    local args = {...};

    if (flag == false) then
      flag = true;

      C_Timer.After(timeSpan, function ()
        flag = false;
        callback(unpack(args));
      end);
    end
  end

  Pandaria.addon.on(eventList, funnel);

  -- returning funnel for manual call
  return funnel;
end

-- export and import handling
do
  local modules = {};

  Pandaria.addon.export = function (moduleName, module)
    modules[moduleName] = module;
  end

  Pandaria.addon.import = function (moduleName)
    return modules[moduleName];
  end
end

-- internal message handling
do
  local callbacks = {};

  Pandaria.addon.listen = function (message, callback)
    callbacks[message] = callbacks[message] or {};

    table.insert(callbacks[message], callback);
  end

  Pandaria.addon.yell = function (message, ...)
    local callbackList = callbacks[message];

    if (callbackList == nil) then return end

    for x = 1, #callbackList, 1 do
      callbackList[x](...);
    end
  end
end

local MAP_IDS = {
  jadeforest = 371,
  valleyoffourwinds = 376,
  kunlai = 379,
  townlong = 388,
  valeofblossoms = 390,
  krasarang = 418,
  dreadwastes = 422,
  veiledstar = 433,
  isleofthunder = 504,
  isleofgiants = 507,
  timelessisle = 554,
};

Pandaria.nodeData = {
  [MAP_IDS.isleofgiants] = {
    [50605440] = {
      ["rare"] = 69161,
    },
  },
--  [MAP_IDS.timelessisle] = {
--    [65605680] = {
--      ["rare"] = 73167,
--    },
--    [64602860] = {
--      ["rare"] = 73282,
--    },
--    [44203100] = {
--      ["rare"] = 73157,
--    },
--    [33808580] = {
--      ["rare"] = 72193,
--    },
--    [70805260] = {
--      ["rare"] = 73171,
--    },
--    [43806960] = {
--      ["rare"] = 73854,
--    },
--    [66004260] = {
--      ["rare"] = 73171,
--    },
--    [35003240] = {
--      ["rare"] = 72898,
--    },
--    [56005960] = {
--      ["rare"] = 72896,
--    },
--    [57602640] = {
--      ["rare"] = 72898,
--    },
--    [31004920] = {
--      ["rare"] = 73158,
--    },
--    [34802940] = {
--      ["rare"] = 72898,
--    },
--    [50602340] = {
--      ["rare"] = 72898,
--    },
--    [54002400] = {
--      ["rare"] = 72896,
--    },
--    [41603020] = {
--      ["rare"] = 72896,
--    },
--    [63807300] = {
--      ["rare"] = 72775,
--    },
--    [62804360] = {
--      ["rare"] = 73171,
--    },
--    [47608780] = {
--      ["rare"] = 72245,
--    },
--    [67604400] = {
--      ["rare"] = 73277,
--    },
--    [46603960] = {
--      ["rare"] = 73172,
--    },
--    [35603620] = {
--      ["rare"] = 72896,
--    },
--    [72808480] = {
--      ["rare"] = 73279,
--    },
--    [55803560] = {
--      ["rare"] = 72898,
--    },
--    [59605280] = {
--      ["rare"] = 73171,
--    },
--    [61606400] = {
--      ["rare"] = 72970,
--    },
--    [25802320] = {
--      ["rare"] = 73281,
--    },
--    [44803880] = {
--      ["rare"] = 72769,
--    },
--    [71408140] = {
--      ["rare"] = 73704,
--    },
--    [56003820] = {
--      ["rare"] = 72896,
--    },
--    [50202290] = {
--      ["rare"] = 73666,
--    },
--    [22803240] = {
--      ["rare"] = 73166,
--    },
--    [40607960] = {
--      ["rare"] = 72909,
--    },
--    [37807720] = {
--      ["rare"] = 71919,
--    },
--    [57607720] = {
--      ["rare"] = 73170,
--    },
--    [54005240] = {
--      ["rare"] = 73175,
--    },
--    [54204280] = {
--      ["rare"] = 72808,
--    },
--    [59004880] = {
--      ["rare"] = 71864,
--    },
--    [60608780] = {
--      ["rare"] = 72048,
--    },
--    [68005740] = {
--      ["rare"] = 73171,
--    },
--    [45002600] = {
--      ["rare"] = 72898,
--    },
--    [68803440] = {
--      ["rare"] = 72896,
--    },
--    [70604580] = {
--      ["rare"] = 73171,
--    },
--    [24605760] = {
--      ["rare"] = 73161,
--    },
--    [44202660] = {
--      ["rare"] = 73173,
--    },
--    [34207340] = {
--      ["rare"] = 73163,
--    },
--    [49603360] = {
--      ["rare"] = 72898,
--    },
--    [34803120] = {
--      ["rare"] = 73174,
--    },
--    [29804560] = {
--      ["rare"] = 73160,
--    },
--    [25203600] = {
--      ["rare"] = 72045,
--    },
--    [53608300] = {
--      ["rare"] = 73169,
--    },
--  },
  [MAP_IDS.isleofthunder] = {
    [60503730] = {
      ["rare"] = 69099,
    },
    [55208770] = {
      ["rare"] = 69341,
    },
    [48202560] = {
      ["rare"] = 70001,
    },
    [49902070] = {
      ["rare"] = 69347,
    },
    [61604980] = {
      ["rare"] = 69999,
    },
    [68903930] = {
      ["rare"] = 70080,
    },
    [35006200] = {
      ["rare"] = 69664,
    },
    [39608120] = {
      ["rare"] = 50358,
    },
    [51007120] = {
      ["rare"] = 69997,
    },
    [44506100] = {
      ["rare"] = 69339,
    },
    [55304790] = {
      ["rare"] = 69767,
    },
    [44602960] = {
      ["rare"] = 70000,
    },
    [63404900] = {
      ["rare"] = 70003,
    },
    [54403580] = {
      ["rare"] = 70002,
    },
    [35706380] = {
      ["rare"] = 69471,
    },
    [57907920] = {
      ["rare"] = 69396,
    },
    [37608300] = {
      ["rare"] = 69996,
    },
    [30705860] = {
      ["rare"] = 69633,
    },
    [48002600] = {
      ["rare"] = 69749,
    },
    [53705310] = {
      ["rare"] = 69998,
    },
  },
  [MAP_IDS.jadeforest] = {
    [39606260] = {
      ["rare"] = 50363,
    },
    [53604960] = {
      ["rare"] = 51078,
    },
    [48202060] = {
      ["rare"] = 50350,
    },
    [52204440] = {
      ["rare"] = 51078,
    },
    [54204240] = {
      ["rare"] = 51078,
    },
    [42603880] = {
      ["rare"] = 50823,
    },
    [53804560] = {
      ["rare"] = 51078,
    },
    [46601680] = {
      ["rare"] = 50350,
    },
    [57407140] = {
      ["rare"] = 50808,
    },
    [42601620] = {
      ["rare"] = 50350,
    },
    [56404880] = {
      ["rare"] = 51078,
    },
    [64607420] = {
      ["rare"] = 50782,
    },
    [44007500] = {
      ["rare"] = 50338,
    },
    [33605080] = {
      ["rare"] = 50750,
    },
    [42201760] = {
      ["rare"] = 50350,
    },
    [40801520] = {
      ["rare"] = 50350,
    },
    [48001860] = {
      ["rare"] = 50350,
    },
    [44401760] = {
      ["rare"] = 69768,
    },
    [53002300] = {
      ["rare"] = 69768,
    },
    [53003120] = {
      ["rare"] = 69768,
    },
    [52601900] = {
      ["rare"] = 69769,
    },
    [26203240] = {
      ["treasure"] = 31400,
    },
    [31902780] = {
      ["treasure"] = 31401,
    },
    [23503500] = {
      ["treasure"] = 31404,
    },
    [50709990] = {
      ["treasure"] = 31396,
    },
    [24605320] = {
      ["treasure"] = 31864,
    },
    [46308070] = {
      ["treasure"] = 31865,
    },
    [62402750] = {
      ["treasure"] = 31866,
    },
  },
  [MAP_IDS.krasarang] = {
    [10405710] = {
      ["rare"] = 68322,
    },
    [52208800] = {
      ["rare"] = 50830,
    },
    [87402920] = {
      ["rare"] = 68319,
    },
    [67202300] = {
      ["rare"] = 50352,
    },
    [31103460] = {
      ["rare"] = 50768,
    },
    [39602900] = {
      ["rare"] = 50331,
    },
    [85002760] = {
      ["rare"] = 68318,
    },
    [12406470] = {
      ["rare"] = 68320,
    },
    [13405480] = {
      ["rare"] = 68321,
    },
    [58604390] = {
      ["rare"] = 50787,
    },
    [53603880] = {
      ["rare"] = 50340,
    },
    [84603100] = {
      ["rare"] = 68317,
    },
    [40505290] = {
      ["rare"] = 50816,
    },
    [42805290] = {
      ["rare"] = 50816,
    },
    [15203560] = {
      ["rare"] = 50388,
    },
    [36205900] = {
      ["rare"] = 69768,
    },
    [39406340] = {
      ["rare"] = 69768,
    },
    [43805700] = {
      ["rare"] = 69768,
    },
    [39906620] = {
      ["rare"] = 69769,
    },
    [68600760] = {
      ["treasure"] = 31408,
    },
    [54207230] = {
      ["treasure"] = 31863,
    },
  },
  [MAP_IDS.valeofblossoms] = {
    [14005820] = {
      ["rare"] = 50749,
    },
    [16804040] = {
      ["rare"] = 64403,
    },
    [36805780] = {
      ["rare"] = 50806,
    },
    [69603080] = {
      ["rare"] = 50780,
    },
    [39802500] = {
      ["rare"] = 50359,
    },
    [15003560] = {
      ["rare"] = 50349,
    },
    [43805180] = {
      ["rare"] = 50806,
    },
    [51404300] = {
      ["rare"] = 64403,
    },
    [87804460] = {
      ["rare"] = 50336,
    },
    [31009160] = {
      ["rare"] = 50840,
    },
    [14005860] = {
      ["rare"] = 50749,
    },
    [39005340] = {
      ["rare"] = 50806,
    },
    [38806560] = {
      ["rare"] = 64403,
    },
    [42606900] = {
      ["rare"] = 50822,
    },
    [43405340] = {
      ["rare"] = 50806,
    },
    [35206180] = {
      ["rare"] = 50806,
    },
  },
  [MAP_IDS.valleyoffourwinds] = {
    [71606440] = {
      ["rare"] = 62346,
    },
    [52802860] = {
      ["rare"] = 50766,
    },
    [59003860] = {
      ["rare"] = 50766,
    },
    [71005240] = {
      ["rare"] = 50783,
    },
    [37806060] = {
      ["rare"] = 51059,
    },
    [54603660] = {
      ["rare"] = 50766,
    },
    [19003580] = {
      ["rare"] = 50828,
    },
    [18607760] = {
      ["rare"] = 50351,
    },
    [15603200] = {
      ["rare"] = 50828,
    },
    [32806280] = {
      ["rare"] = 51059,
    },
    [88601800] = {
      ["rare"] = 50811,
    },
    [75804640] = {
      ["rare"] = 50783,
    },
    [74605180] = {
      ["rare"] = 50783,
    },
    [8205960] = {
      ["rare"] = 50364,
    },
    [9204740] = {
      ["rare"] = 50364,
    },
    [57603380] = {
      ["rare"] = 50766,
    },
    [54003160] = {
      ["rare"] = 50766,
    },
    [37002560] = {
      ["rare"] = 50339,
    },
    [14003820] = {
      ["rare"] = 50828,
    },
    [16803520] = {
      ["rare"] = 50828,
    },
    [34605960] = {
      ["rare"] = 51059,
    },
    [12604880] = {
      ["rare"] = 50364,
    },
    [67605960] = {
      ["rare"] = 50783,
    },
    [39605760] = {
      ["rare"] = 51059,
    },
    [9206060] = {
      ["rare"] = 50364,
    },
    [16604100] = {
      ["rare"] = 50828,
    },
    [23802850] = {
      ["treasure"] = 31405,
    },
    [92003900] = {
      ["treasure"] = 31869,
    },
  },
  [MAP_IDS.dreadwastes] = {
    [64205860] = {
      ["rare"] = 50776,
    },
    [36606460] = {
      ["rare"] = 50805,
    },
    [35603080] = {
      ["rare"] = 50739,
    },
    [71803760] = {
      ["rare"] = 50347,
    },
    [55406340] = {
      ["rare"] = 50836,
    },
    [25202860] = {
      ["rare"] = 50334,
    },
    [73202040] = {
      ["rare"] = 50356,
    },
    [36806060] = {
      ["rare"] = 50805,
    },
    [73002220] = {
      ["rare"] = 50356,
    },
    [39606180] = {
      ["rare"] = 50805,
    },
    [73602360] = {
      ["rare"] = 50356,
    },
    [34802320] = {
      ["rare"] = 50821,
    },
    [39204180] = {
      ["rare"] = 50739,
    },
    [74002080] = {
      ["rare"] = 50356,
    },
    [39605840] = {
      ["rare"] = 50805,
    },
    [37802960] = {
      ["rare"] = 50739,
    },
    [39604920] = {
      ["rare"] = 69768,
    },
    [47806040] = {
      ["rare"] = 69768,
    },
    [59806640] = {
      ["rare"] = 69768,
    },
    [47206160] = {
      ["rare"] = 69769,
    },
  },
  [MAP_IDS.kunlai] = {
    [54206330] = {
      ["rare"] = 60491,
    },
    [36607960] = {
      ["rare"] = 50733,
    },
    [44806360] = {
      ["rare"] = 50831,
    },
    [59207380] = {
      ["rare"] = 50354,
    },
    [73207640] = {
      ["rare"] = 50769,
    },
    [40804240] = {
      ["rare"] = 50817,
    },
    [47408120] = {
      ["rare"] = 50332,
    },
    [57007580] = {
      ["rare"] = 50354,
    },
    [63801380] = {
      ["rare"] = 50789,
    },
    [51608100] = {
      ["rare"] = 50332,
    },
    [56004340] = {
      ["rare"] = 50341,
    },
    [74407920] = {
      ["rare"] = 50769,
    },
    [73807740] = {
      ["rare"] = 50769,
    },
    [46206180] = {
      ["rare"] = 50831,
    },
    [47206300] = {
      ["rare"] = 50831,
    },
    [44806520] = {
      ["rare"] = 50831,
    },
    [57607500] = {
      ["rare"] = 50354,
    },
    [65206460] = {
      ["rare"] = 69768,
    },
    [74606600] = {
      ["rare"] = 69768,
    },
    [67407960] = {
      ["rare"] = 69768,
    },
    [75006760] = {
      ["rare"] = 69769,
    },
    [64204520] = {
      ["treasure"] = 31420,
    },
    [49505940] = {
      ["treasure"] = 31414,
    },
    [36707980] = {
      ["treasure"] = 31418,
    },
    [52605150] = {
      ["treasure"] = 31419,
    },
    [72003390] = {
      ["treasure"] = 31416,
    },
    [59505290] = {
      ["treasure"] = 31415,
    },
    [57807630] = {
      ["treasure"] = 31422,
    },
    [47807350] = {
      ["treasure"] = 31868,
    },
  },
  [MAP_IDS.townlong] = {
    [66408680] = {
      ["rare"] = 50772,
    },
    [67808760] = {
      ["rare"] = 50772,
    },
    [64204980] = {
      ["rare"] = 50333,
    },
    [67607440] = {
      ["rare"] = 50832,
    },
    [68808920] = {
      ["rare"] = 50772,
    },
    [67805080] = {
      ["rare"] = 50333,
    },
    [32006180] = {
      ["rare"] = 50820,
    },
    [42007840] = {
      ["rare"] = 50734,
    },
    [63003560] = {
      ["rare"] = 50355,
    },
    [46407440] = {
      ["rare"] = 50734,
    },
    [37205760] = {
      ["rare"] = 66900,
    },
    [47608420] = {
      ["rare"] = 50734,
    },
    [59208560] = {
      ["rare"] = 50791,
    },
    [66804440] = {
      ["rare"] = 50333,
    },
    [54006340] = {
      ["rare"] = 50344,
    },
    [65408760] = {
      ["rare"] = 50772,
    },
    [47808860] = {
      ["rare"] = 50734,
    },
    [47408760] = {
      ["rare"] = 69768,
    },
    [39808900] = {
      ["rare"] = 69768,
    },
    [40407860] = {
      ["rare"] = 69768,
    },
    [48607420] = {
      ["rare"] = 69768,
    },
    [36608560] = {
      ["rare"] = 69769,
    },
    [62803410] = {
      ["treasure"] = 31427,
    },
    [65808610] = {
      ["treasure"] = 31426,
    },
    [34906310] = {
      ["treasure"] = 31423,
    },
    [53905840] = {
      ["treasure"] = 31424,
    },
    [57505850] = {
      ["treasure"] = 31424,
    },
  },
  [MAP_IDS.veiledstar] = {
    [75107640] = {
      ["treasure"] = 31428,
    },
    [54607260] = {
      ["treasure"] = 31867,
    },
  }
}

Pandaria.rareData = {
  [60491] = {
    name = 'Sha of Anger',
    quest = 32099,
  },
  [69099] = {
    name = 'Nalak',
    quest = 32518,
  },
  [62346] = {
    name = 'Galleon',
    quest = 32098,
  },
  [69161] = {
    name = 'Oondasta',
    quest = 32519,
  },
  [64403] = {
    name = 'Alani',
    description = 'Cloud Serpent flying arround the Vale. Needs 10 Sky Crystals to remove immunity.'
  },
  [69769] = {
    name = 'Zandalari Warbringer',
    description = 'The color of the NPCs mount determines the color of the mount that can drop.',
  },
  [69768] = {
    name = 'Zandalari Warscout',
  },
  [66900] = {
    name = 'Huggalon the Heart Watcher',
  },
  [68320] = {
    name = 'Ubunti the Shade',
    faction = 'Alliance',
  },
  [68321] = {
    name = 'Kar Warmaker',
    faction = 'Alliance',
  },
  [68322] = {
    name = 'Muerta',
    faction = 'Alliance',
  },
  [68317] = {
    name = 'Mavis Harms',
    faction = 'Horde',
  },
  [68318] = {
    name = 'Dalan Nightbreaker',
    faction = 'Horde',
  },
  [68319] = {
    name = 'Disha Fearwarden',
    faction = 'Horde',
  },
  -- special rares
  [50356] = {
    description = 'Can drop item that increases experience by 300% for 1 hour up to level 85.',
    special = true,
  },
  [50831] = {
    description = 'Can drop item that increases reputation with all Pandaria factions by 1000.',
    special = true,
  },
  -- rares with info
  [50806] = {
    description = 'Roams in the old river between the location points.',
  },
  [73157] = {
    description = 'Inside cave.',
  },
  [72769] = {
    description = 'Inside cave.',
  },
  [72193] = {
    description = 'Speak to Fin Longpaw on the pier to summon him.'
  },
  [71864] = {
    description = 'The rocks can be skipped with jump/chair items or blink.'
  },
  [73161] = {
    description = 'Great Turtles can respawn as this rare.'
  },
  [73281] = {
    description = 'Kill Evermaw for the lantern to summon the ship at the ritual stone.'
  },
  [73166] = {
    description = 'Spineclaws can respawn as this rare.'
  },
  [72045] = {
    description = 'Click on the suspicious shell.'
  },
  [73160] = {
    description = 'Keep killing all the Ironfur mobs until it spawns.'
  },
  [72049] = {
    description = 'Kite a Fishgorged Crane from the south onto the corpse.'
  },
  [72048] = {
    description = 'Talk to Captain Zvezdan in the underwater shipwreck.'
  },
};

Pandaria.treasureData = {
  [31428] = {
    ["name"] = "The Hammer Folly",
    ["description"] = "Grey item worth 100g.",
  },
  [31863] = {
    ["name"] = "Stack of Papers",
    ["description"] = "Grey item worth 15g.",
  },
  [31414] = {
    ["name"] = "Hozen Treasure Cache",
    ["description"] = "Item with 95g.",
  },
  [31864] = {
    ["name"] = "Chest of Supplies",
    ["description"] = "Chest with 10g",
  },
  [31415] = {
    ["name"] = "Stolen Sprite Treasure",
    ["description"] = "Item with ~100g.",
  },
  [31400] = {
    ["name"] = "Ancient Pandaren Tea Pot",
    ["description"] = "Grey item worth 100g.",
  },
  [31416] = {
    ["name"] = "Statue of Xuen",
    ["description"] = "Grey item worth 100g.",
  },
  [31401] = {
    ["name"] = "Lucky Pandaren Coin",
    ["description"] = "Grey item worth 95g.",
  },
  [31867] = {
    ["name"] = "Forgotten Lockbox",
    ["description"] = "Chest with ~9g.",
  },
  [31418] = {
    ["name"] = "Lost Adventurer's Belongings",
    ["description"] = "Item with ~97g.",
  },
  [31868] = {
    ["name"] = "Mo-Mo's Treasure Chest",
    ["description"] = "Item with 9g.",
  },
  [31419] = {
    ["name"] = "Rikktik's Tiny Chest",
    ["description"] = "Grey item worth 105g.",
  },
  [31404] = {
    ["name"] = "Pandaren Ritual Stone",
    ["description"] = "Grey item worth 105g",
  },
  [31420] = {
    ["name"] = "Ancient Mogu Tablet",
    ["description"] = "Grey item worth 95g.",
  },
  [31405] = {
    ["name"] = "Virmen Treasure Cache",
    ["description"] = "Item with ~99g.",
  },
  [31422] = {
    ["name"] = "Terracotta Head",
    ["description"] = "Grey item worth 100g.",
  },
  [31423] = {
    ["name"] = "Fragment of Dread",
    ["description"] = "Grey item worth 90g.",
  },
  [31408] = {
    ["name"] = "Saurok Stone Tablet",
    ["description"] = "Grey item worth 100g.",
  },
  [31424] = {
    ["name"] = "Hardened Sap of Kri'vess",
    ["description"] = "Grey item worth 110g. Search around the tree.",
  },
  [31869] = {
    ["name"] = "Boat-Building Instructions",
    ["description"] = "Grey item worth 10g.",
  },
  [31866] = {
    ["name"] = "Stash of Gems",
    ["description"] = "Chest with 96g and gems",
  },
  [31426] = {
    ["name"] = "Amber Encased Moth",
    ["description"] = "Grey item worth 105g.",
  },
  [31865] = {
    ["name"] = "Offering of Remembrance",
    ["description"] = "Item with 30g and buff",
  },
  [31427] = {
    ["name"] = "Abandoned Crate of Goods",
    ["description"] = "Item with ~103g.",
  },
  [31396] = {
    ["name"] = "Ship's Locker",
    ["description"] = "Chest with 96g",
  },
}

Pandaria.mountData = {
  [473] = 60491,
  [542] = 69099,
  [533] = 69161,
  [534] = 69769,
  [535] = 69769,
  [536] = 69769,
  [517] = 64403,
  [561] = 73167,
};

Pandaria.toyData = {
  [86588] = 50817,
  [86589] = 50821,
  [86593] = 50836,
  [86571] = 50349,
  [86581] = 50769,
  [86575] = 50359,
  [86568] = 50336,
  [86573] = 50354,
  [86586] = 50806,
  [104302] = 73171,
  [104309] = 72896,
  [104262] = 72970,
  [104294] = 73281,
  [104331] = 73169,
  [86582] = 50780,
  [86590] = 50822,
  [86578] = 50739,
  [86584] = 50789,
  [86594] = 50840,
  [86583] = 50783,
  [134023] = 50749,
  [90067] = 66900,
  [86565] = 51059,
  [104329] = 72898,
};

Pandaria.achievementData = {
  rares = {
    auto = {
      7439, -- Glorious!
      7932, -- I'm in Your Base, Killing Your Dudes
      -- 8101, -- It Was Worth Every Ritual Stone
      8103, -- Champions of Lei-Shen
      8712, -- Killing Time
      8714, -- Timeless Champion
      32640, -- Champions of the Thunder King
    },
    static = {
      -- warscouts and warbringers are not properly returned in the achievement
      -- "Zul'Again"
      [8078] = {
        {
          id = 69768,
          index = 1,
        }, {
          id = 69769,
          index = 2,
        }
      },
      -- there are two npcs named "Archiereus of Flame" and therefor the Achievement
      -- returns no proper id
      [8714] = {
        {
          id = 73174,
          index = 31,
        }, {
          id = 73666,
          index = 31,
        }
      },
      -- "It Was Worth Every Ritual Stone" for some reason returns weird assetIds
      [8101] = {
        {
          id = 69471,
          index = 1,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69633,
          index = 2,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69341,
          index = 3,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69339,
          index = 4,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69749,
          index = 5,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69767,
          index = 6,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 70080,
          index = 7,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69396,
          index = 8,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69347,
          index = 9,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
      }
    }
  },
  treasures = {
    static = {
      [7997] = { -- Riches of Pandaria
        31400,
        31396,
        31401,
        31404,
        31405,
        31408,
        31414,
        31415,
        31416,
        31418,
        31419,
        31420,
        31422,
        31423,
        31424,
        31426,
        31427,
        31428,
      }
    },
  },
}

-- "I'm in your base, killing your dudes" has faction specific NPCs
if (UnitFactionGroup('player') == 'Alliance') then
  Pandaria.achievementData.rares.static[7932] = {
    {
      id = 68321,
      index = 1,
    },
    {
      id = 68320,
      index = 2,
    },
    {
      id = 68322,
      index = 3,
    },
  };
else
  Pandaria.achievementData.rares.static[7932] = {
    {
      id = 68318,
      index = 1,
    },
    {
      id = 68317,
      index = 2,
    },
    {
      id = 68319,
      index = 3,
    },
  };
end

local module = {};
local hiddenNodes;

Pandaria.addon.on('PLAYER_LOGIN', function ()
  if (Handynotes_PandariaDB == nil) then
      Handynotes_PandariaDB = {
        hiddenNodes = {},
      };
  elseif (Handynotes_PandariaDB.hiddenNodes == nil) then
    Handynotes_PandariaDB.hiddenNodes = {};
  end

  hiddenNodes = Handynotes_PandariaDB.hiddenNodes;
end);

module.hide = function (zone, coords)
  hiddenNodes[zone] = hiddenNodes[zone] or {};
  hiddenNodes[zone][coords] = true;
end;

module.isHidden = function (zone, coords)
  return (hiddenNodes[zone] ~= nil and hiddenNodes[zone][coords] == true);
end

module.restoreZoneNodes = function (zone)
  hiddenNodes[zone] = nil;
end

module.restoreAllNodes = function (zone)
  table.wipe(hiddenNodes);
end

Pandaria.addon.export('nodeHider', module);

local function parseData ()
  local rareInfo = Pandaria.rareData;
  local treasureInfo = Pandaria.treasureData;

  local function parseMountData ()
    local mountData = Pandaria.mountData;

    if (mountData == nil) then return end

    for mountId, rareList in pairs(mountData) do
      if (type(rareList) ~= 'table') then
        rareList = {rareList};
      end

      for x = 1, #rareList, 1 do
        local rareId = rareList[x];
        local rareData = rareInfo[rareId];

        if (rareData == nil) then
          rareInfo[rareId] = {mounts = {mountId}};
        elseif (rareData.mounts == nil) then
          rareData.mounts = {mountId};
        else
          table.insert(rareData.mounts, mountId);
        end
      end
    end

    Pandaria.mountData = nil;
  end

  local function parseToyData ()
    local toyData = Pandaria.toyData;

    if (toyData == nil) then return end

    for toyId, rareList in pairs(toyData) do
      if (type(rareList) ~= 'table') then
        rareList = {rareList};
      end

      for x = 1, #rareList, 1 do
        local rareId = rareList[x];
        local rareData = rareInfo[rareId];

        if (rareData == nil) then
          rareInfo[rareId] = {toys = {toyId}};
        elseif (rareData.toys == nil) then
          rareData.toys = {toyId};
        else
          table.insert(rareData.toys, toyId);
        end
      end
    end

    Pandaria.toyData = nil;
  end


  local function parseAchievementdata ()
    local achievementData = Pandaria.achievementData;

    if (achievementData == nil) then return end

    local function addAchievementInfo (infoTable, id, achievementId, criteriaIndex)
      local data;

      infoTable[id] = infoTable[id] or {};
      data = infoTable[id];

      data.achievements = data.achievements or {};
      table.insert(data.achievements, {
        id = achievementId,
        index = criteriaIndex,
      });
    end

    local function parseRareData ()
      local rareAchievementData = achievementData.rares;

      if (rareAchievementData == nil) then return end

      local function addRareAchievementInfo (rareId, achievementId, criteriaIndex, description)
        local rareData;

        addAchievementInfo(rareInfo, rareId, achievementId, criteriaIndex);

        rareData = rareInfo[rareId];

        if (rareData.name == nil and criteriaIndex > 0) then
          local numCriteria = GetAchievementNumCriteria(achievementId);

          if (numCriteria >= criteriaIndex) then
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, criteriaIndex)};

            rareData.name = criteriaInfo[1];
          end
        end

        rareData.description = rareData.description or description;
      end

      local function parseDynamicData ()
        local achievementList = rareAchievementData.auto;

        if (achievementList == nil) then return end

        for x = 1, #achievementList, 1 do
          local achievementId = achievementList[x];
          local numCriteria  = GetAchievementNumCriteria(achievementId);

          for y = 1, numCriteria, 1 do
            local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, y)};
            local rareId = criteriaInfo[8];

            -- -- this is for detecting unhandled rares
            -- if (rareId == nil or rareId == 0) then
            --   print(y, criteriaInfo[1], '-', rareId);
            -- end

            addRareAchievementInfo(rareId, achievementId, y);
          end
        end
      end

      local function parseStaticData ()
        local staticData = rareAchievementData.static;

        if (staticData == nil) then return end

        for achievement, rareList in pairs(staticData) do
          for x = 1, #rareList, 1 do
            local rareData = rareList[x];

            if (type(rareData) ~= 'table') then
              rareData = {id = rareData};
            end

            addRareAchievementInfo(rareData.id, achievement,
                rareData.index or -1, rareData.description);
          end
        end
      end

      parseDynamicData();
      parseStaticData();
    end

    local function parseTreasureData ()
      local treasureAchievementData = achievementData.treasures;

      if (treasureAchievementData == nil) then return end

      local function addTreasureAchievementInfo (treasureId, achievementId, criteriaIndex)
        addAchievementInfo(treasureInfo, treasureId, achievementId, criteriaIndex);
      end

      local function parseStaticData ()
        local staticData = treasureAchievementData.static;

        if (staticData == nil) then return end

        for achievement, treasureList in pairs(staticData) do
          for x = 1, #treasureList, 1 do
            local treasureData = treasureList[x];

            if (type(treasureData) ~= 'table') then
              treasureData = {id = treasureData};
            end

            addTreasureAchievementInfo(treasureData.id, achievement,
                treasureData.index or -1, treasureData.description);
          end
        end
      end

      parseStaticData();
    end

    parseRareData();
    parseTreasureData();
  end

  parseMountData();
  parseToyData();
  parseAchievementdata();

  Pandaria.achievementData = nil;
  Pandaria.mountData = nil;
end

Pandaria.addon.on('PLAYER_LOGIN', parseData);


local IsQuestFlaggedCompleted = _G.C_QuestLog.IsQuestFlaggedCompleted;
local rareData = Pandaria.rareData;
local treasureInfo = Pandaria.treasureData;
local nodes = Pandaria.nodeData;
local playerFaction;
local dataCache;
local settings = {};

local nodeHider = Pandaria.addon.import('nodeHider');

local ICON_MAP = {
  question = 'Interface\\Icons\\inv_misc_questionmark',
  skullGray = 'Interface\\MINIMAP\\Minimap_skull_normal',  --Interface\\Worldmap\\Skull_64Grey
  skullGreen = 'Interface\\Worldmap\\Skull_64Green',
  skullBlue = 'Interface\\Worldmap\\Skull_64Blue',
  skullOrange = 'Interface\\Worldmap\\Skull_64Red',
  skullYellow = 'Interface\\MINIMAP\\Minimap_skull_elite',
  skullPurple = 'Interface\\Worldmap\\Skull_64Purple',
  chest = 'Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS',
};

local COLOR_MAP = {
  red = '|cFFFF0000',
  blue = '|cFF0000FF',
  green = '|cFF00FF00',
  yellow = '|cFFFFFF00',
};

Pandaria.addon.listen('SETTINGS_LOADED', function (_settings)
  settings = _settings;
end);

Pandaria.addon.on('PLAYER_LOGIN', function ()
  playerFaction = UnitFactionGroup('player');
end);

local function setTextColor (text, color)
  return color .. text .. '|r';
end

local function queryItem (itemId, info)
  local item = Item:CreateFromItemID(itemId);

  if (item:IsItemEmpty()) then return end

  item:ContinueOnItemLoad(function ()
    local data = {GetItemInfo(itemId)};

    info = info or {};
    info.name = data[1];
    info.icon = data[10];

    Pandaria.addon.yell('DATA_READY', info);
  end);
end

local function getAchievementInfo (rareData)
  local achievementList = rareData.achievements;

  if (achievementList == nil) then return nil end

  local list = {};
  local totalInfo = {
    list = list,
    completed = true,
  };

  for x = 1, #achievementList, 1 do
    local achievementData = achievementList[x];
    local achievementId = achievementData.id;
    local achievementInfo = {GetAchievementInfo(achievementId)};
    local text = achievementInfo[2];
    local completed = achievementInfo[4];
    local criteriaIndex = achievementData.index;
    local fulfilled = false;
    local info = {
      icon = achievementInfo[10],
    };

    if (completed) then
      text = setTextColor(text, COLOR_MAP.green);
    else
      text = setTextColor(text, COLOR_MAP.red);
    end

    -- some achievements and their indices are set statically, so we make
    -- sure the criteria exists
    if (criteriaIndex > 0 and
        criteriaIndex <= GetAchievementNumCriteria(achievementId)) then
      local criteriaInfo = {GetAchievementCriteriaInfo(achievementId, criteriaIndex)};
      local criteria = criteriaInfo[1];

      fulfilled = criteriaInfo[3];

      if (fulfilled or completed) then
        criteria = setTextColor(criteria, COLOR_MAP.green);
      else
        criteria = setTextColor(criteria, COLOR_MAP.red);
      end

      text = text .. ' - ' .. criteria;
    end

    info.completed = (completed or fulfilled);
    info.text = text;

    if (not info.completed) then
      totalInfo.completed = false;
    end

    totalInfo.icon = totalInfo.icon or info.icon;
    list[x] = info;
  end

  return totalInfo;
end

local function getToyInfo (rareData)
  local toyList = rareData.toys;

  if (toyList == nil) then return nil end

  local list = {};
  local totalData = {
    collected = true,
    list = list,
  };

  for x = 1, #toyList, 1 do
    local toy = toyList[x];
    local toyInfo = {GetItemInfo(toy)};
    local toyName = toyInfo[1];
    local info = {
      collected = PlayerHasToy(toy),
    };

    -- data is not cached yet
    if (toyName == nil) then
      toyName = 'waiting for data...';

      queryItem(toy);

      info.icon = GetItemIcon(toy) or ICON_MAP.skullGreen;
    else
      info.icon = toyInfo[10] or ICON_MAP.skullGreen;
    end

    info.name = toyName;

    if (info.collected) then
      toyName = setTextColor(toyName, COLOR_MAP.green);
    else
      toyName = setTextColor(toyName, COLOR_MAP.red);
      totalData.collected = false;
      totalData.icon = totalData.icon or info.icon;
    end

    info.text = toyName;
    list[x] = info;
  end

  return totalData;
end

local function getMountInfo (rareData)
  local mountList = rareData.mounts;

  if (mountList == nil) then return nil end

  local list = {};
  local totalData = {
    list = list,
    collected = true,
  };

  for x = 1, #mountList, 1 do
    local mountId = mountList[x];
    local mountInfo = {C_MountJournal.GetMountInfoByID(mountId)};
    local mountName = mountInfo[1];
    local info = {
      icon = mountInfo[3] or ICON_MAP.skullOrange,
      collected = mountInfo[11],
    };

    if (info.collected) then
      mountName = setTextColor(mountName, COLOR_MAP.green);
    else
      mountName = setTextColor(mountName, COLOR_MAP.red);
      totalData.collected = false;
      totalData.icon = totalData.icon or info.icon;
    end

    info.text = mountName;
    list[x] = info;
  end

  return totalData;
end

local function getRareInfo (nodeData)
  local rareId = nodeData.rare;

  if (rareId == nil) then return nil end

  local rareCache = dataCache.rares;

  if (rareCache[rareId] ~= nil) then
    return rareCache[rareId];
  end

  local rare = rareData[rareId];

  if (rare == nil) then
    return nil;
  end

  if (rare.faction and rare.faction ~= playerFaction) then
    return nil;
  end

  local info = {
    name = rare.name,
    description = rare.description,
    special = rare.special,
    achievementInfo = getAchievementInfo(rare),
    toyInfo = getToyInfo(rare),
    mountInfo = getMountInfo(rare),
  };

  if (rare.quest ~= nil) then
    info.questCompleted = IsQuestFlaggedCompleted(rare.quest);
  end

  rareCache[rareId] = info;
  return info;
end

local function getTreasureInfo (nodeData)
  local treasureId = nodeData.treasure;

  if (treasureId == nil) then return nil end

  local treasureData = treasureInfo[treasureId];

  if (treasureData == nil) then
    -- print('no information about treasure:', treasureId);
    return nil;
  end

  if (treasureData.faction and treasureData.faction ~= playerFaction) then
    return nil;
  end

  local info = {
    name = treasureData.name,
    description = treasureData.description,
    achievementInfo = getAchievementInfo(treasureData),
    collected = IsQuestFlaggedCompleted(treasureId),
    icon = ICON_MAP.chest,
  };

  return info;
end

local function interpreteNodeInfo (nodeInfo)
  local rareInfo = nodeInfo.rareInfo;

  if (settings.show_rares == true and rareInfo ~= nil) then
    if (rareInfo.questCompleted == true) then
      nodeInfo.display = false;
      return;
    end

    local mountInfo = rareInfo.mountInfo;

    if (settings.show_mounts == true and mountInfo ~= nil) then
      if (mountInfo.collected == false) then
        nodeInfo.icon = mountInfo.icon or ICON_MAP.skullPurple;
        nodeInfo.display = true;
        return;
      end
    end

    local toyInfo = rareInfo.toyInfo;

    if (settings.show_toys == true and toyInfo ~= nil) then
      if (toyInfo.collected == false) then
        nodeInfo.icon = toyInfo.icon or ICON_MAP.skullGreen;
        nodeInfo.display = true;
        return;
      end
    end

    local achievementInfo = rareInfo.achievementInfo;

    if (settings.show_achievements == true and achievementInfo ~= nil) then
      if (achievementInfo.completed == false) then
        -- nodeInfo.icon = achievementInfo.icon;
        nodeInfo.icon = ICON_MAP.skullYellow;
        nodeInfo.display = true;
        return;
      end
    end

    if (settings.show_special_rares == true and rareInfo.special == true) then
      nodeInfo.icon = ICON_MAP.skullBlue;
      nodeInfo.display = true;
      return;
    end

    if (settings.always_show_rares == true) then
      nodeInfo.display = true;
      nodeInfo.icon = ICON_MAP.skullGray;
      return;
    end
  end

  local treasureInfo = nodeInfo.treasureInfo;

  if (settings.show_treasures == true and treasureInfo ~= nil) then
    if (treasureInfo.collected == false) then
      nodeInfo.icon = treasureInfo.icon;
      nodeInfo.display = true;
      return;
    end

    nodeInfo.icon = nodeInfo.icon or ICON_MAP.chest;
  end

  nodeInfo.icon = nodeInfo.icon or ICON_MAP.question;
  nodeInfo.display = false;
end

local function getNodeInfo (zone, coords)
  if (nodeHider.isHidden(zone, coords)) then
    return {
      display = false,
    };
  end

  local nodeCache = dataCache.nodes;

  if (nodeCache[zone] ~= nil and nodeCache[zone][coords] ~= nil) then
    return nodeCache[zone][coords];
  end

  local nodeData = nodes[zone];

  if (nodeData == nil) then return nil end
  nodeData = nodeData[coords];
  if (nodeData == nil) then return nil end

  local info = {
    rareInfo = getRareInfo(nodeData),
    treasureInfo = getTreasureInfo(nodeData),
  };

  if (info.rareInfo == nil and info.treasureInfo == nil) then return nil end

  interpreteNodeInfo(info);

  nodeCache[zone] = nodeCache[zone] or {};
  nodeCache[zone][coords] = info or {};

  return info;
end

local function flush ()
  dataCache = {
    rares = {},
    treasures = {},
    nodes = {},
  };
end

flush();

local module = {
  getNodeInfo = getNodeInfo,
  flush = flush,
};

Pandaria.addon.export('infoProvider', module);

local HandyNotes = Pandaria.HandyNotes;
local nodes = Pandaria.nodeData;
local handler = {};
local settings;
local tooltip;
local dropdown;

local infoProvider = Pandaria.addon.import('infoProvider');
local nodeHider = Pandaria.addon.import('nodeHider');

local function makeIterator (zones, isMinimap)
  local zoneIndex, zone = next(zones, nil);
  local coords;

  local function iterator ()
    while (zone) do
      local zoneNodes = nodes[zone];

      if (zoneNodes) then
        coords = next(zoneNodes, coords);

        while (coords) do
          local info = infoProvider.getNodeInfo(zone, coords);

          if (info == nil) then
            local remCoords = coords;

            -- get the next node before deleting, so next() knows the coords
            coords = next(zoneNodes, coords);
            zoneNodes[remCoords] = nil;
          else
            if (info.display) then
              return coords, zone, info.icon, settings.icon_scale, settings.icon_alpha;
            end

            coords= next(zoneNodes, coords);
          end
        end
      end

      zoneIndex, zone = next(zones, zoneIndex);
    end
  end

  return iterator;
end

function handler:GetNodes2(uiMapId, isMinimap)
  if (isMinimap == true and settings.minimap_icons ~= true) then
    return function () return nil end
  end

  -- local zones = HandyNotes:GetContinentZoneList(uiMapId); -- Is this a continent?
  local zones;

  if not zones then
    zones = {uiMapId};
  end

  infoProvider.flush();

  return makeIterator(zones, isMinimap);
end

local function addTooltipText (tooltip, info, header)
  if (info == nil or info.completed == true or info.collected == true) then return end

  local list = info.list;

  for x = 1, #list, 1 do
    if (list[x].collected == false or list[x].completed == false) then
      tooltip:AddDoubleLine(header, list[x].text);
      header = ' ';
    end
  end
end

function displayTooltip (nodeInfo)
  nodeData = nodeInfo.rareInfo or nodeInfo.treasureInfo;

  tooltip:SetText(nodeData.name or nodeInfo.rare or nodeInfo.treasure);
  -- tooltip:SetText(nodeData.name .. ' ' .. (node.rare or node.treasure));

  if (nodeData.description ~= nil) then
    tooltip:AddLine(nodeData.description);
  end

  addTooltipText(tooltip, nodeData.mountInfo, 'Mounts:');
  addTooltipText(tooltip, nodeData.toyInfo, 'Toys:');
  addTooltipText(tooltip, nodeData.achievementInfo, 'Achievements:');

  tooltip:Show();
end

function handler:OnEnter(uiMapId, coords)
  local nodeInfo = infoProvider.getNodeInfo(uiMapId, coords);

  if (nodeInfo == nil) then return end

  currentInfo = nodeInfo;

  tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip;

  if (self:GetCenter() > UIParent:GetCenter()) then
    tooltip:SetOwner(self, "ANCHOR_LEFT");
  else
    tooltip:SetOwner(self, "ANCHOR_RIGHT");
  end

  displayTooltip(nodeInfo);
end

function handler:OnLeave(uiMapId, coords)
  currentInfo = nil;
  tooltip:Hide();
end

Pandaria.addon.listen('DATA_READY', function (info, id)
  if (currentInfo == info) then
    displayTooltip(nodeInfo);
  end
end);

local function updateNodes ()
  HandyNotes:SendMessage('HandyNotes_NotifyUpdate', "HandyNotes_Pandaria");
end

local function replaceTable (oldTable, newTable)
  -- this clears the table without destroying old references
  table.wipe(oldTable);

  for key, value in pairs(newTable) do
    oldTable[key] = value;
  end
end

-- node menu handling
do
  local function CloseDropDown (button, level)
    CloseDropDownMenus(level);
  end

  local function addTomTomWaypoint(button, mapId, coords)
    if TomTom then
      local x, y = HandyNotes:getXY(coords);
      local info = infoProvider.getNodeInfo(mapId, coords);

      info = info.rareInfo or info.treasureInfo;

      TomTom:AddWaypoint(mapId, x, y, {
        title = info.name;
        persistent = nil,
        minimap = settings.minimap_icons,
        world = true,
      });
    end
  end

  local dropdown = CreateFrame('Frame', 'HandyNotes_Pandaria_DropdownMenu');
  local clickedMapId;
  local clickedCoord;

  dropdown.displayMode = "MENU";
  dropdown.initialize = function (button, level)
    if (not level) then return end

    if (level == 1) then
      UIDropDownMenu_AddButton({
        text = 'HandyNotes Pandaria',
        isTitle = true,
        notCheckable = true,
        notClickable = true,
      }, level);

      if (IsAddOnLoaded('TomTom')) then
        UIDropDownMenu_AddButton({
          text = 'Add TomTom waypoint',
          notCheckable = true,
          func = addTomTomWaypoint,
          arg1 = clickedMapId,
          arg2 = clickedCoord,
        }, level);
      end

      UIDropDownMenu_AddButton({
        text = 'Hide this node',
        notCheckable = true,
        arg1 = clickedMapId,
        arg2 = clickedCoord,
        func = function (button, zone, coords)
          nodeHider.hide(zone, coords);
          updateNodes();
        end,
      }, level);

      UIDropDownMenu_AddButton({
        text = 'Restore hidden nodes in this zone',
        notCheckable = true,
        func = function (button, zone, coords)
          nodeHider.restoreZoneNodes(zone);
          updateNodes();
        end,
        arg1 = clickedMapId,
        arg2 = clickedCoord,
      }, level);

      UIDropDownMenu_AddButton({
        text = 'Close',
        func = CloseDropDown,
        notCheckable = true,
        arg1 = level,
      }, level);
    end
  end;

  function handler:OnClick (button, down, mapID, coord)
    if (button == 'RightButton' and not down) then
      clickedMapId = mapID;
      clickedCoord = coord;
      ToggleDropDownMenu(1, nil, dropdown, self, 0, 0);
    end
  end
end

local function validateSettings (config, defaults)
  local new = {};

  for param, defaultValue in pairs(defaults) do
    local configValue = config[param];

    if (type(configValue) ~= type(defaultValue)) then
      new[param] = defaultValue;
    else
      new[param] = configValue;
    end
  end

  -- we replace the old settings table to wipe removed settings
  replaceTable(config, new);
end

local function registerWithHandyNotes ()
  local defaults = {
    icon_scale = 1,
    icon_alpha = 1,
    minimap_icons = true,
    show_rares = true,
    show_treasures = true,
    always_show_rares = false,
    show_mounts = true,
    show_toys = true,
    show_achievements = true,
    show_special_rares = true,
  };

  if (Handynotes_PandariaDB == nil) then
    Handynotes_PandariaDB = {
      settings = {};
    };
  elseif (Handynotes_PandariaDB.settings == nil) then
    Handynotes_PandariaDB.settings = {};
  end

  settings = Handynotes_PandariaDB.settings;
  validateSettings(settings, defaults);

  Pandaria.addon.yell('SETTINGS_LOADED', settings);

  local options = {
    type = "group",
    name = 'Pandaria',
    desc = 'Rares and treasures in Pandaria',
    get = function (info) return settings[info.arg] end,
    set = function (info, v)
      settings[info.arg] = v;
      updateNodes();
    end,
    args = {
      icon_settings = {
        type = "group",
        name = "Icon settings",
        inline = true,
        args = {
          icon_scale = {
            order = 1,
            type = 'range',
            name = 'Icon Scale',
            desc = 'The scale of the icons',
            min = 0.5, max = 3, step = 0.1,
            arg = 'icon_scale',
            width = 'normal',
          },
          icon_alpha = {
            order = 2,
            type = 'range',
            name = 'Icon Alpha',
            desc = 'The alpha transparency of the icons',
            min = 0, max = 1, step = 0.01,
            arg = 'icon_alpha',
            width = 'normal',
          },
          minimap_icons = {
            order = 3,
            type = 'toggle',
            name = 'Show icons on the minimap',
            desc = 'Show icons on the minimap',
            arg = 'minimap_icons',
            width = 'full',
          },
          show_rares = {
            order = 4,
            type = 'toggle',
            name = 'Show rares',
            desc = 'Show nodes of rare mobs',
            arg = 'show_rares',
            width = 'full',
          },
          show_treasures = {
            order = 5,
            type = 'toggle',
            name = 'Show treasures',
            desc = 'Show nodes of treasures',
            arg = 'show_treasures',
            width = 'full',
          },
        }
      },
      visibility_settings = {
        type = "group",
        name = "Show rares when they:",
        inline = true,
        args = {
          always_show_rares = {
            order = 1,
            type = 'toggle',
            name = 'exist (always)',
            desc = 'exist (always)',
            arg = 'always_show_rares',
            width = 'full',
          },
          show_mounts = {
            order = 2,
            type = 'toggle',
            name = 'drop an uncollected mount',
            desc = 'drop an uncollected mount',
            arg = 'show_mounts',
            width = 'full',
          },
          show_toys = {
            order = 3,
            type = 'toggle',
            name = 'drop an uncollected toy',
            desc = 'drop an uncollected toy',
            arg = 'show_toys',
            width = 'full',
          },
          show_achievements = {
            order = 4,
            type = 'toggle',
            name = 'are required for an achievement',
            desc = 'are required for an achievement',
            arg = 'show_achievements',
            width = 'full',
          },
          show_special_rares = {
            order = 5,
            type = 'toggle',
            name = 'drop a useful item',
            desc = 'drop a useful item',
            arg = 'show_special_rares',
            width = 'full',
          },
          reset_nodes = {
            order = 6,
            type = 'execute',
            name = 'Restore hidden nodes',
            desc = 'Shows manually hidden nodes again',
            func = function()
              nodeHider.restoreAllNodes();
              updateNodes();
            end,
            width = 'normal',
          },
        }
      }
    },
  };

  HandyNotes:RegisterPluginDB("HandyNotes_Pandaria", handler, options);
end


Pandaria.addon.on('PLAYER_LOGIN', function ()
  registerWithHandyNotes();
  Pandaria.addon.funnel({'CRITERIA_UPDATE'}, 2, updateNodes);
  Pandaria.addon.on({'NEW_TOY_ADDED', 'NEW_MOUNT_ADDED'}, updateNodes);
end);
--[[Pandaria.addon.on('PLAYER_LOGIN', function ()
  convertedData = nil;
end);

local rareInfo = Pandaria.rareData;
local nodes = Pandaria.nodeData;

--if true then return end

local function nameCheck ()
  for zone, zoneNodes in pairs(nodes) do
    for coords, node in pairs(zoneNodes) do
      local info = Pandaria.addon.getNodeInfo(node);

      if (info == nil) then
        print(node.treasure, '-', node.rare);
      end

      if (info and info.name == nil) then
        if (node.treasure ~= nil) then
          print('no name for treasure:', node.treasure);
        end

        if (node.rare ~= nil) then
          print('no name for rare:', node.rare);
        end
      end
    end
  end
end

Pandaria.addon.on('PLAYER_STOPPED_MOVING', function ()
  nameCheck();
end);]]
