--## Author: Req, gegenschall  ## SavedVariablesPerCharacter: LTSM
LTSM_DATA_VERSION = 3

LTSM_DATA = {}

---
-- "Do not change" option. Negative to not clash with actual spec IDs, which are all positive.
LTSM_DATA.SPEC_DONT_CARE = -1
---
-- "Current spec" option. Same as GetLootSpecialization returns for "current spec".
LTSM_DATA.SPEC_CURRENT_SPEC = 0

---
-- A list of instances/boss data.
-- {
--     [1] = {
--         name = instancename,
--         encounters = {
--             [1] = {
--                 name = bossname,
--                 id = encounterid
--             },
--             ...
--         }
--     },
--     ...
-- }
LTSM_DATA.INSTANCE_BOSSES = (function(...)
  --using a function to preserve order without explicitly specifying instance indices
  --this way, instances can be added or removed without altering the order of other instances
  local ret = {}
  for _, v in pairs({...}) do
    tinsert(ret, {
      name = v[1],
      encounters = v[2]
    })
  end
  return ret
end)(
  {"初诞者圣墓", {
    [1] = {name = "警戒卫士", id = 2512},
    [2] = {name = "司垢莱克斯,无穷噬灭者", id = 2542},
    [3] = {name = "道茜歌妮,堕落先知", id = 2540},
    [4] = {name = "圣物匠赛,墨克斯", id = 2553},
    [5] = {name = "死亡万神殿原型体", id = 2544},
    [6] = {name = "首席造物师利许威姆", id = 2539},
    [7] = {name = "回收者黑伦度斯", id = 2529},
    [8] = {name = "安度因,乌瑞恩", id = 2546},
    [9] = {name = "恐惧双王", id = 2543},
    [10] = {name = "莱葛隆", id = 2549},
    [11] = {name = "典狱长", id = 2537},
  }},
  {"统御圣所", {
    [1] = {name = "塔拉格鲁", id = 2423},
    [2] = {name = "典狱长之眼", id = 2433},
    [3] = {name = "九武神", id = 2429},
    [4] = {name = "耐奥祖的残迹", id = 2432},
	[5] = {name = "裂魂者多尔玛赞", id = 2434},
    [6] = {name = "痛楚工匠莱兹纳尔", id = 2430},
    [7] = {name = "初诞者的卫士", id = 2436},
    [8] = {name = "命运撰写师罗-卡洛", id = 2431},
    [9] = {name = "克尔苏加德", id = 2422},
    [10] = {name = "希尔瓦娜斯·风行者", id = 2435},
  }},
  {"纳斯利亚堡", {
    [1] = {name = "啸翼", id = 2398},
    [2] = {name = "猎手阿尔迪莫", id = 2418},
    [3] = {name = "太阳之王的救赎", id = 2402},
    [4] = {name = "圣物匠赛·墨克斯", id = 2405},
	[5] = {name = "饥饿的毁灭者", id = 2383},
    [6] = {name = "伊涅瓦·暗脉女勋爵", id = 2406},
    [7] = {name = "猩红议会", id = 2412},
    [8] = {name = "泥拳", id = 2399},
    [9] = {name = "顽石军团干将", id = 2417},
    [10] = {name = "德纳修斯大帝", id = 2407},
  }},
  {"塔扎维什，帷纱集市", {
    [1] = {name = "哨卫佐·菲克斯", id = 2425},
    [2] = {name = "卖品会", id = 2425},
    [3] = {name = "收发室乱战", id = 2424},
    [4] = {name = "麦扎的绿洲", id = 2440},
    [5] = {name = "索·阿兹密", id = 2437},
    [6] = {name = "希尔布兰德", id = 2426},
    [7] = {name = "时空船长钩尾", id = 2419},
    [8] = {name = "索·莉亚", id = 2442},
  }},
  {"通灵战潮", {
    [1] = {name = "凋骨", id = 2387},
    [2] = {name = "收割者阿玛厄斯", id = 2388},
    [3] = {name = "外科医生缝肉", id = 2389},
    [4] = {name = "缚霜者纳尔佐", id = 2390},
  }},
  {"凋魂之殇", {
    [1] = {name = "酤团", id = 2382},
    [2] = {name = "伊库斯博士", id = 2384},
    [3] = {name = "多米娜·毒刃", id = 2385},
    [4] = {name = "斯特拉达玛侯爵", id = 2386},
  }},
  {"塞兹仙林的迷雾", {
    [1] = {name = "英格拉·马洛克", id = 2397},
    [2] = {name = "唤雾者", id = 2392},
    [3] = {name = "特雷德奥瓦", id = 2393},
  }},
  {"赎罪大厅", {
    [1] = {name = "哈尔吉亚斯", id = 2401},
    [2] = {name = "艾谢朗", id = 2380},
    [3] = {name = "高阶裁决官阿丽兹", id = 2403},
    [4] = {name = "宫务大臣", id = 2381},
  }},
  {"伤逝剧场", {
    [1] = {name = "狭路相逢", id = 2391},
    [2] = {name = "斩血", id = 2365},
    [3] = {name = "无堕者哈夫", id = 2366},
    [4] = {name = "库尔萨洛克", id = 2364},
    [5] = {name = "无尽女皇莫德蕾莎", id = 2404},
  }},
  {"彼界", {
    [1] = {name = "夺灵者哈卡", id = 2395},
    [2] = {name = "法力风暴夫妇", id = 2394},
    [3] = {name = "商人赛·艾柯莎", id = 2400},
    [4] = {name = "穆厄扎拉", id = 2396},
  }},
  {"晋升高塔", {
    [1] = {name = "金-塔拉", id = 2357},
    [2] = {name = "雯图纳柯丝", id = 2356},
    [3] = {name = "奥莱芙莉安", id = 2358},
    [4] = {name = "疑虑圣杰德沃丝", id = 2359},
  }},
  {"赤红深渊", {
    [1] = {name = "贪食的克里克西斯", id = 2360},
    [2] = {name = "执行者塔沃德", id = 2361},
    [3] = {name = "大学监贝律莉娅", id = 2362},
    [4] = {name = "卡尔将军", id = 2363},
  }},
  {"尼奥罗萨,觉醒之城", {
    [1] = {name = "黑龙帝王拉希奥", id = 2329},
    [2] = {name = "玛乌特", id = 2327},
    [3] = {name = "先知基特拉", id = 2334},
    [4] = {name = "黑暗审判官夏奈什", id = 2328},
    [5] = {name = "主脑", id = 2333},
    [6] = {name = "无厌者夏德哈", id = 2335},
    [7] = {name = "德雷阿佳斯", id = 2343},
    [8] = {name = "伊格诺斯,重生之蚀", id = 2345},
    [9] = {name = "维克修娜", id = 2336},
    [10] = {name = "虚无者莱登", id = 2331},
    [11] = {name = "恩佐斯的外壳", id = 2337},
    [12] = {name = "腐蚀者恩佐斯", id = 2344}
  }},
  {"永恒王宫", {
    [1] = {name = "深渊指挥官西瓦拉", id = 2298},
    [2] = {name = "黑水巨鳗", id = 2289},
    [3] = {name = "艾萨拉之辉", id = 2305},
    [4] = {name = "艾什凡女勋爵", id = 2304},
    [5] = {name = "奥戈佐亚", id = 2303},
    [6] = {name = "女王法庭", id = 2311},
    [7] = {name = "扎库尔,尼奥罗萨先驱", id = 2293},
    [8] = {name = "艾萨拉女王", id = 2299}
  }},
  {"风暴熔炉", {
    [1] = {name = "无眠密党", id = 2269},
    [2] = {name = "乌纳特,虚空先驱", id = 2273}
  }},
  {"达萨罗之战", (function()
    local encounters = {
      [4] = {name = "丰灵", id = 2271},
      [5] = {name = "神选者教团", id = 2268},
      [6] = {name = "拉斯塔哈大王", id = 2272},
      [7] = {name = "大工匠梅卡托克", id = 2276},
      [8] = {name = "风暴之墙阻击战", id = 2280},
      [9] = {name = "吉安娜.普罗德摩尔", id = 2281}
    }
    if UnitFactionGroup("player") == "Alliance" then
      encounters[1] = {name = "圣光勇士", id = 2265}
      encounters[2] = {name = "玉火大师", id = 2266}
      encounters[3] = {name = "丛林之王格洛恩", id = 2263}
    else
      encounters[1] = {name = "圣光勇士", id = 2265}
      encounters[2] = {name = "丛林之王格洛恩", id = 2263}
      encounters[3] = {name = "玉火大师", id = 2266}
    end
    return encounters
  end)()},
  {"奥迪尔", {
    [1] = {name = "塔罗克", id = 2144},
    [2] = {name = "纯净圣母", id = 2141},
    [3] = {name = "腐臭吞噬者", id = 2128},
    [4] = {name = "泽克沃兹,恩佐斯的传令官", id = 2136},
    [5] = {name = "维克提斯", id = 2134},
    [6] = {name = "重生者祖尔", id = 2145},
    [7] = {name = "拆解者米斯拉克斯", id = 2135},
    [8] = {name = "戈霍恩", id = 2122}
  }},
  {"麦卡贡行动", {
    [1] = {name = "戈巴马克国王", id = 2290},
    [2] = {name = "冈克", id = 2292},
    [3] = {name = "崔克茜&耐诺", id = 2312},
    [4] = {name = "HK-8型空中压制单位", id = 2291},
    [5] = {name = "坦克大战", id = 2257},
    [6] = {name = "K.U.-J.0.", id = 2258},
    [7] = {name = "机械师的花园", id = 2259},
    [8] = {name = "麦卡贡国王", id = 2260}
  }},
  {"阿塔达萨", {
    [1] = {name = "女祭司阿伦扎", id = 2084},
    [2] = {name = "沃卡尔", id = 2085},
    [3] = {name = "莱赞", id = 2086},
    [4] = {name = "亚兹玛", id = 2087}
  }},
  {"自由镇", {
    [1] = {name = "天空上尉库拉格", id = 2093},
    [2] = {name = "海盗议会", id = 2094},
    [3] = {name = "藏宝竞技场", id = 2095},
    [4] = {name = "哈兰.斯威提", id = 2096}
  }},
  {"诸王之眠", {
    [1] = {name = "黄金风蛇", id = 2139},
    [2] = {name = "殓尸者姆沁巴", id = 2142},
    [3] = {name = "部族议会", id = 2140},
    [4] = {name = "始皇达萨", id = 2143}
  }},
  {"风暴神殿", {
    [1] = {name = "阿库希尔", id = 2130},
    [2] = {name = "海贤议会", id = 2131},
    [3] = {name = "斯托颂勋爵", id = 2132},
    [4] = {name = "低语者沃尔兹斯", id = 2133}
  }},
  {"围攻伯拉勒斯", (function()
    local encounters = {
      [2] = {name = "恐怖船长洛克伍德", id = 2109},
      [3] = {name = "哈达尔.黑渊", id = 2099},
      [4] = {name = "维克戈斯", id = 2100}
    }
    if UnitFactionGroup("player") == "Alliance" then
      encounters[1] = {name = "屠夫.血钩", id = 2098}
    else
      encounters[1] = {name = "拜恩比吉中士", id = 2097}
    end
    return encounters
  end)()},
  {"塞塔里斯神庙", {
    [1] = {name = "阿德里斯和阿斯匹克斯", id = 2124},
    [2] = {name = "米利克萨", id = 2125},
    [3] = {name = "加瓦兹特", id = 2126},
    [4] = {name = "塞塔里斯的化身", id = 2127}
  }},
  {"暴富矿区!!", {
    [1] = {name = "投币式群体打击者", id = 2105},
    [2] = {name = "艾泽洛克", id = 2106},
    [3] = {name = "瑞科沙.流火", id = 2107},
    [4] = {name = "商业大亨拉兹敦克", id = 2108},
  }},
  {"地渊孢林", {
    [1] = {name = "长者莉娅克萨", id = 2111},
    [2] = {name = "被感染的岩喉", id = 2118},
    [3] = {name = "孢子召唤师赞查", id = 2112},
    [4] = {name = "不羁畸变怪", id = 2123}
  }},
  {"托尔达戈", {
    [1] = {name = "泥沙女王", id = 2101},
    [2] = {name = "杰斯.豪里斯", id = 2102},
    [3] = {name = "骑士队长瓦莱莉", id = 2103},
    [4] = {name = "科古斯狱长", id = 2104}
  }},
  {"维克雷斯庄园", {
    [1] = {name = "毒心三姝", id = 2113},
    [2] = {name = "魂缚巨像", id = 2114},
    [3] = {name = "贪食的拉尔", id = 2115},
    [4] = {name = "维克雷斯勋爵和夫人", id = 2116},
    [5] = {name = "高莱克.图尔", id = 2117}
  }}
)

LTSM_DATA.DUNGEON_MAPS = (function(...)
  local ret = {}
  for _, v in pairs({...}) do
    ret[v[1]] = v[2]
    ret[v[2]] = v[1]
  end
  return ret
end)(
  -- Shadowlands
  {"塔扎维什，帷纱集市", 2441},
  {"通灵战潮", 2286},
  {"凋魂之殇", 2289},
  {"塞兹仙林的迷雾", 2290},
  {"赎罪大厅", 2287},
  {"伤逝剧场", 2293},
  {"彼界", 2291},
  {"晋升高塔", 2285},
  {"赤红深渊", 2284},
  -- Battle for Azeroth
  {"麦卡贡", 2097},
  {"阿塔达萨", 1763},
  {"自由镇", 1754},
  {"诸王之眠", 1762},
  {"围攻伯拉勒斯", 1822},
  {"风暴神殿", 1864},
  {"塞塔里斯神庙", 1877},
  {"暴富矿区!!", 1594},
  {"地渊孢林", 1841},
  {"托尔达戈", 1771},
  {"维克雷斯庄园", 1862}
)

--[[
  encounters = encounter id -> spec id
  dungeons = primary map id -> spec id
  maps = map id -> primary map id
  default -> spec id
]]

function LTSM_DATA:check_version()
  local ltsm = LTSM

  --initial version had no version number
  if not ltsm.version then
    ltsm.encounters = ltsm.encounters or {}
    ltsm.settings = ltsm.settings or {}
    ltsm.mythicplus = ltsm.mythicplus or {}

    --first iteration had 2097 for both bosses
    ltsm.encounters[2098] = ltsm.encounters[2098] or ltsm.encounters[2097]

    ltsm.version = 1
  end
  if ltsm.version == 1 then
    local encounters = ltsm.encounters
    ltsm.encounters = {
      mythic = {},
      heroic = {},
      normal = {},
      lfr = {}
    }
    for k, v in pairs(encounters) do
      ltsm.encounters.mythic[k] = v
      ltsm.encounters.heroic[k] = v
      ltsm.encounters.normal[k] = v
      ltsm.encounters.lfr[k] = v
    end
    ltsm.current = "mythic"

    ltsm.version = 2
  end
  if ltsm.version == 2 then
    ltsm.default = LTSM_DATA.SPEC_DONT_CARE

    ltsm.version = LTSM_DATA_VERSION
  end
end



local tinsert = table.insert

LTSM_GUI = {}

--{{id, icon}, ...}
local function get_spec_icons()
  local _, _, classid = UnitClass("player")
  local specs = {}
  for k = 1, GetNumSpecializationsForClassID(classid) do
    local id, _, _, icon = GetSpecializationInfoForClassID(classid, k)
    if not id then
      break
    end
    tinsert(specs, {
      id = id,
      icon = icon
    })
  end
  return specs
end

local function clamp(n, min, max)
  if n < min then
    return min
  end
  if n > max then
    return max
  end
  return n
end

local function set_class_icon(frame, classname)
  frame:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
  frame:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classname]))
end

local ROW_VERTICAL_SPACING = 30

local function create_header(parent, title, y)
  local frame = CreateFrame("Frame", nil, parent)
  frame:SetSize(parent:GetWidth(), ROW_VERTICAL_SPACING)
  frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, y)
  frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  frame.text:SetText(title)
  frame.text:SetTextColor(0.9, 0.1, 0.1, 1)
  frame.text:SetAllPoints()
  frame.text:SetJustifyH("LEFT")
  frame.text:SetJustifyV("CENTER")
end

local function create_subheader(parent, title, y)
  local frame = CreateFrame("Frame", nil, parent)
  frame:SetSize(parent:GetWidth() - 30, ROW_VERTICAL_SPACING)
  frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 35, y)
  frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  frame.text:SetText(title)
  frame.text:SetAllPoints()
  frame.text:SetJustifyH("LEFT")
  frame.text:SetJustifyV("CENTER")
  return frame
end

local function create_spec_row(parent, classname, specs, y)
  local function make_spec_display(icon, x)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetSize(ROW_VERTICAL_SPACING, ROW_VERTICAL_SPACING)
    frame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
    frame.texture = frame:CreateTexture(nil, "ARTWORK", nil)
    frame.texture:SetTexture(icon)
    frame.texture:SetAllPoints(frame)
    return frame
  end

  make_spec_display("Interface\\ICONS\\INV_Misc_QuestionMark", -2)
  set_class_icon(make_spec_display(nil, -2 - ROW_VERTICAL_SPACING).texture, classname)
  for x, spec in ipairs(specs) do
    make_spec_display(spec.icon, -2 - (#specs - x + 2) * ROW_VERTICAL_SPACING)
  end
end

local current_radio_group = nil
local function start_radio_group()
  current_radio_group = {}
end

local function radio_group_disable_all(self)
  for _, v in pairs(self.group) do
    if v ~= self then
      v:SetChecked(false)
    end
  end
end

local function create_encounter_checkbox(parent, x, y, encounter, spec)
  local checkbox = CreateFrame("CheckButton", ("ltsm-cb-%d-%d"):format(encounter, spec), parent, "UICheckButtonTemplate")
  checkbox.group = current_radio_group
  checkbox:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
  checkbox:RegisterForClicks("AnyUp")
  checkbox:SetScript("OnClick", function(self)
    radio_group_disable_all(self)
    LTSM_API:set_spec_setting(encounter, spec)
  end)
  tinsert(current_radio_group, checkbox)
  return checkbox
end

local function create_mythicplus_checkbox(parent, x, y, map, spec)
  local checkbox = CreateFrame("CheckButton", ("ltsm-mpcb-%d-%d"):format(map, spec), parent, "UICheckButtonTemplate")
  checkbox.group = current_radio_group
  checkbox:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
  checkbox:RegisterForClicks("AnyUp")
  checkbox:SetScript("OnClick", function(self)
    radio_group_disable_all(self)
    LTSM_API:set_mythicplus_spec(map, spec)
  end)
  tinsert(current_radio_group, checkbox)
  return checkbox
end

local function create_default_checkbox(parent, x, y, spec)
  local checkbox = CreateFrame("CheckButton", ("ltsm-dcb-%d"):format(spec), parent, "UICheckButtonTemplate")
  checkbox.group = current_radio_group
  checkbox:SetPoint("TOPRIGHT", parent, "TOPRIGHT", x, y)
  checkbox:RegisterForClicks("AnyUp")
  checkbox:SetScript("OnClick", function(self)
    radio_group_disable_all(self)
    LTSM_API:set_default_spec(spec)
  end)
  tinsert(current_radio_group, checkbox)
  return checkbox
end

local SPEC_ICONS = nil

function LTSM_GUI:init()
  local ltsm = LTSM

  self.frame = CreateFrame("Frame", "LTSM_Frame", UIParent, "ButtonFrameTemplate")
  local f = self.frame
  if ltsm.settings.x and ltsm.settings.y then
    f:SetPoint("BOTTOMLEFT", ltsm.settings.x, ltsm.settings.y)
  else
    f:SetPoint("CENTER")
  end
  f:SetSize(450, 600)
  f:SetToplevel(true)
  f:SetClampedToScreen(true)
  f:EnableMouse(true)
  f:SetMovable(true)
  f:SetScript("OnMouseDown", f.StartMoving)
  local function stop_moving(self)
    self:StopMovingOrSizing()
    ltsm.settings.x = self:GetLeft()
    ltsm.settings.y = self:GetBottom()
  end
  f:SetScript("OnMouseUp", stop_moving)
  f:SetScript("OnHide", stop_moving)
  f.TitleText:SetText("LootSpecManager")
  tinsert(UISpecialFrames, "LTSM_Frame")
  f:SetDontSavePosition(false)

  local _, CLASS_NAME, _ = UnitClass("player")
  set_class_icon(f.portrait, CLASS_NAME)

  local ROWS = (function()
    local rows = 0
    for _, instance in ipairs(LTSM_DATA.INSTANCE_BOSSES) do
      --instance header row
      rows = rows + 1
      for _, boss in ipairs(instance.encounters) do
        --individual boss row
        rows = rows + 1
      end
      if LTSM_DATA.DUNGEON_MAPS[instance.name] then
        --this is a dungeon, so add a row for m+
        rows = rows + 1
      end
    end
    --1 extra for default
    return rows + 1
  end)()
  local TOTAL_SIZE = ROWS * ROW_VERTICAL_SPACING

  local scrollframe = CreateFrame("ScrollFrame", nil, f)
  scrollframe:SetPoint("TOPLEFT", f, "TOPLEFT", 7, -63)
  scrollframe:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -9, 28)
  scrollframe:SetScript("OnMouseWheel", function(self, delta)
    local scroll = clamp(self:GetVerticalScroll() - delta * ROW_VERTICAL_SPACING * 2, self.scrollbar:GetMinMaxValues())
    self:SetVerticalScroll(scroll)
    self.scrollbar:SetValue(scroll)
  end)

  local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
  scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", -16, -16)
  scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", -16, 16)
  scrollbar:SetMinMaxValues(1, TOTAL_SIZE)
  scrollbar.scrollStep = ROW_VERTICAL_SPACING * 2
  scrollbar:SetValueStep(scrollbar.scrollStep)
  scrollbar:SetValue(0)
  scrollbar:SetWidth(16)
  scrollbar:SetScript("OnValueChanged", function(self, value)
    self:GetParent():SetVerticalScroll(value)
  end)
  scrollframe.scrollbar = scrollbar

  local content = CreateFrame("Frame", nil, scrollframe)
  content:SetSize(scrollframe:GetWidth() - scrollbar:GetWidth(), TOTAL_SIZE)
  scrollframe:SetScrollChild(content)

  local y = -5
  SPEC_ICONS = get_spec_icons()

  create_header(content, "默认", y)
  create_spec_row(content, CLASS_NAME, SPEC_ICONS, y)
  y = y - ROW_VERTICAL_SPACING

  start_radio_group()
  create_default_checkbox(content, -2, y, LTSM_DATA.SPEC_DONT_CARE)
  create_default_checkbox(content, -2 - ROW_VERTICAL_SPACING, y, LTSM_DATA.SPEC_CURRENT_SPEC)
  for x, spec in pairs(SPEC_ICONS) do
    create_default_checkbox(content, -2 - (#SPEC_ICONS - x + 2) * ROW_VERTICAL_SPACING, y, spec.id)
  end
  y = y - ROW_VERTICAL_SPACING

  for _, instance in ipairs(LTSM_DATA.INSTANCE_BOSSES) do
    create_header(content, instance.name, y)
    create_spec_row(content, CLASS_NAME, SPEC_ICONS, y)
    y = y - ROW_VERTICAL_SPACING

    for _, boss in ipairs(instance.encounters) do
      create_subheader(content, boss.name, y)

      start_radio_group()
      create_encounter_checkbox(content, -2, y, boss.id, LTSM_DATA.SPEC_DONT_CARE)
      create_encounter_checkbox(content, -2 - ROW_VERTICAL_SPACING, y, boss.id, LTSM_DATA.SPEC_CURRENT_SPEC)
      for x, spec in pairs(SPEC_ICONS) do
        create_encounter_checkbox(content, -2 - (#SPEC_ICONS - x + 2) * ROW_VERTICAL_SPACING, y, boss.id, spec.id)
      end

      y = y - ROW_VERTICAL_SPACING
    end

    local dungeon_map = LTSM_DATA.DUNGEON_MAPS[instance.name]
    if dungeon_map then
      local subheader = create_subheader(content, "大秘境", y)
      subheader.text:SetTextColor(0.9, 0.9, 0.9, 1)

      start_radio_group()
      create_mythicplus_checkbox(content, -2, y, dungeon_map, LTSM_DATA.SPEC_DONT_CARE)
      create_mythicplus_checkbox(content, -2 - ROW_VERTICAL_SPACING, y, dungeon_map, LTSM_DATA.SPEC_CURRENT_SPEC)
      for x, spec in pairs(SPEC_ICONS) do
        create_mythicplus_checkbox(content, -2 - (#SPEC_ICONS - x + 2) * ROW_VERTICAL_SPACING, y, dungeon_map, spec.id)
      end

      y = y - ROW_VERTICAL_SPACING
    end

    y = y - 10
  end

  local current_dropdown = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
  current_dropdown:SetSize(100, 50)
  current_dropdown:SetPoint("TOPLEFT", f, "TOPLEFT", 48, -32)
  UIDropDownMenu_Initialize(current_dropdown, function()
    local function callback(self)
      LTSM_API:set_active_settings_difficulty(self.value)
      UIDropDownMenu_SetSelectedValue(current_dropdown, self.value)
    end

    local function make_button(info, value, text)
      info.text = text
      info.value = value
      info.func = callback
      info.checked = false
      info.isNotRadio = false
      UIDropDownMenu_AddButton(info)
    end

    local info = UIDropDownMenu_CreateInfo()
    make_button(info, "mythic", "史诗")
    make_button(info, "heroic", "英雄")
    make_button(info, "normal", "普通")
    make_button(info, "lfr", "随机")
  end)
  UIDropDownMenu_SetSelectedValue(current_dropdown, ltsm.current)

  local copy_dropdown = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
  copy_dropdown:SetSize(100, 50)
  copy_dropdown:SetPoint("TOPRIGHT", f, "TOPRIGHT", -80, -32)
  UIDropDownMenu_Initialize(copy_dropdown, function()
    local function callback(self)
      if self.value ~= "copyfrom" then
        LTSM_API:copy_settings(self.value, ltsm.current)
        LTSM_GUI:refresh()
      end
    end

    local function make_button(info, value, text)
      info.text = text
      info.value = value
      info.func = callback
      info.checked = false
      info.isNotRadio = false
      UIDropDownMenu_AddButton(info)
    end

    local info = UIDropDownMenu_CreateInfo()
    make_button(info, "copyfrom", "复制自")
    make_button(info, "mythic", "史诗")
    make_button(info, "heroic", "英雄")
    make_button(info, "normal", "普通")
    make_button(info, "lfr", "随机")
  end)
  UIDropDownMenu_SetSelectedValue(copy_dropdown, "copyfrom")

  self:refresh()
  f:Hide()
end

function LTSM_GUI:refresh()
  for encounter, spec in pairs(LTSM.encounters[LTSM.current]) do
    local checkbox = _G[("ltsm-cb-%d-%d"):format(encounter, spec)]
    if checkbox then
      radio_group_disable_all(checkbox)
      checkbox:SetChecked(true)
    end
  end

  for _, instance in ipairs(LTSM_DATA.INSTANCE_BOSSES) do
    for _, encounter in ipairs(instance.encounters) do
      local checkbox = _G[("ltsm-cb-%d-%d"):format(encounter.id, LTSM_API:get_spec_for_encounter(encounter.id, LTSM_API.reverse_difficulties[LTSM.current]))]
      if checkbox then
        radio_group_disable_all(checkbox)
        checkbox:SetChecked(true)
      end
    end
  end

  for _, instance in ipairs(LTSM_DATA.INSTANCE_BOSSES) do
    local dungeon_map = LTSM_DATA.DUNGEON_MAPS[instance.name]
    if dungeon_map then
      local checkbox = _G[("ltsm-mpcb-%d-%d"):format(dungeon_map, LTSM_API:get_mythicplus_spec(dungeon_map))]
      if checkbox then
        radio_group_disable_all(checkbox)
        checkbox:SetChecked(true)
      end
    end
  end

  local checkbox = _G[("ltsm-dcb-%d"):format(LTSM_API:get_default_spec())]
  if checkbox then
    radio_group_disable_all(checkbox)
    checkbox:SetChecked(true)
  end
end
--buttom
local journalRestoreButton = CreateFrame("Button", "EncounterJournalEncounterFrameInfoCreatureButton1LSSRestoreButton",UIParent,"UIPanelButtonTemplate")
local f = CreateFrame("frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
local loadframe = CreateFrame("frame")

loadframe:RegisterEvent("ADDON_LOADED")
loadframe:SetScript("OnEvent",function(self,event,addon)
  if(addon == "Blizzard_EncounterJournal") then
    journalRestoreButton:SetWidth(80)
    journalRestoreButton:SetHeight(20)
    journalRestoreButton:SetText("LTSM>>")
    journalRestoreButton:SetParent(EncounterJournal)
    journalRestoreButton:ClearAllPoints()
    journalRestoreButton:SetPoint("TOPRIGHT",EncounterJournal,"TOPRIGHT",-20,0)
    end
end)

journalRestoreButton:SetScript("OnClick",function(self)
  LTSM_GUI.frame:Show()
end)


local ltsm

LTSM_API = {}

---
-- Mapping from the ENCOUNTER_START difficulty parameter to difficulty table names.
LTSM_API.difficulties = {
  [17] = "lfr",
  [1] = "normal", --dungeons
  [14] = "normal", --raids
  [2] = "heroic", --dungeons
  [15] = "heroic", --raids
  [23] = "mythic", --dungeons
  [16] = "mythic", --raids
}

---
-- Mapping from difficulty table names to the ENCOUNTER_START difficulty parameter.
LTSM_API.reverse_difficulties = {
  lfr = 17,
  normal = 1,
  heroic = 2,
  mythic = 23
}

---
-- Retrieves the loot spec setting for a specific encounter and difficulty.
-- @param encounter Encounter ID from ENCOUNTER_START.
-- @param difficulty (optional) Difficulty parameter from ENCOUNTER_START.
-- @return Spec ID for the encounter and difficulty. Returns SPEC_DONT_CARE if the setting doesn't exist.
function LTSM_API:get_spec_for_encounter(encounter, difficulty)
  difficulty = self.difficulties[difficulty]
  local table = ltsm.encounters[difficulty]
  if table == nil then
    return LTSM_DATA.SPEC_DONT_CARE
  end
  local spec = table[encounter]
  if spec == nil then
    spec = LTSM_DATA.SPEC_DONT_CARE
  end
  return spec
end

---
-- Sets the active table used for settings management.
-- All settings changes will occur in this table.
-- @param difficulty A difficulty table name.
function LTSM_API:set_active_settings_difficulty(difficulty)
  if ltsm.encounters[difficulty] == nil then
    error("Difficulty table doesn't exist: " .. difficulty)
  end
  ltsm.current = difficulty
  LTSM_GUI:refresh()
end

---
-- Sets the spec setting for an encounter in the current difficulty table.
-- @param encounter Encounter ID from ENCOUNTER_START.
-- @param spec Spec ID to set the encounter setting to.
function LTSM_API:set_spec_setting(encounter, spec)
  ltsm.encounters[ltsm.current][encounter] = spec
end

---
-- Retrieves the default loot spec setting.
-- @return Default loot spec ID.
function LTSM_API:get_default_spec()
  return ltsm.default
end

---
-- Sets the default loot spec setting.
-- @param spec Spec ID to set the default to.
function LTSM_API:set_default_spec(spec)
  ltsm.default = spec
end

---
-- Retrieves the spec setting for a M+ dungeon.
-- @param map Primary map ID from LTSM_DATA.
-- @return Spec ID for the end-of-key box.
function LTSM_API:get_mythicplus_spec(map)
  return ltsm.mythicplus[map] or LTSM_DATA.SPEC_DONT_CARE
end

---
-- Sets the spec setting for a M+ dungeon.
-- @param map Primary map ID from LTSM_DATA.
-- @param spec Spec ID for the end-of-key box.
function LTSM_API:set_mythicplus_spec(map, spec)
  ltsm.mythicplus[map] = spec
end

---
-- Copies settings from one difficulty table to another.
-- @param from Difficulty table name to copy from.
-- @param to Difficulty table name to copy to.
function LTSM_API:copy_settings(from_name, to_name)
  local from = ltsm.encounters[from_name]
  if from == nil then
    error("Difficulty table doesn't exist: " .. from_name)
  end

  if from_name == to_name then
    print(("[LTSM] Not bothering to copy settings from %s to %s"):format(from_name, to_name))
    return
  end

  print(("[LTSM] Copying settings from %s to %s"):format(from_name, to_name))
  ltsm.encounters[to_name] = {}
  local to = ltsm.encounters[to_name]
  for k, v in pairs(from) do
    to[k] = v
  end
end

-- END API --

local function set_spec(spec)
  if spec == LTSM_DATA.SPEC_DONT_CARE then
    return false
  end
  SetLootSpecialization(spec)
  return true
end

local events = {}

function events:PLAYER_LOGIN()
  LTSM = LTSM or {}
  ltsm = LTSM
  LTSM_DATA:check_version()
  LTSM_GUI:init()
end

function events:ENCOUNTER_START(id, _, difficulty)
  if C_ChallengeMode.GetActiveKeystoneInfo() ~= 0 then
    return
  end
  if set_spec(LTSM_API:get_spec_for_encounter(id, difficulty)) then
    print(("[LTSM] Boss pulled. Spec changed."):format(id))
  end
end

function events:CHALLENGE_MODE_START(mapId)
  if set_spec(LTSM_API:get_mythicplus_spec(mapId)) then
    print("[LTSM] M+ started, loot spec changed.")
  end
end

function events:CHALLENGE_MODE_COMPLETED()
  print("[LTSM] M+ finished, loot spec changing back.")
  set_spec(LTSM_API:get_default_spec())
end

local frame = CreateFrame("Frame");
frame:SetScript("OnEvent", function(self, event, ...)
  return events[event](self, ...)
end)
for k, _ in pairs(events) do
  frame:RegisterEvent(k)
end

SLASH_LOOTSPECMANAGER1 = "/ltsm"
SlashCmdList["LOOTSPECMANAGER"] = function()
  LTSM_GUI.frame:Show()
end
