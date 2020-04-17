local macros = {{"坐骑","",[[#showtooltips
/castsequence  [btn:2]旅行者的苔原猛犸象;[mod:shift]雄壮远足牦牛;[mod:alt]猩红水黾;[mod:ctrl]黑曜夜之翼;
#showtooltips 无敌
/run C_MountJournal.SummonByID(0)
/cast 幽魂之狼
/cast 旅行形态
/cast 滑翔
]]
,[[功能和随机偏好坐骑一致。增加了:
左键随机坐骑，右键水黾。按住ctrl-机油坐骑，shift-大象，alt-牦牛。]]}
,{"炉石","6948",[[#showtooltip [nomod]"炉石";[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
/cast [btn:2]飞行管理员的哨子;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘
/castrandom [nomod,btn:1]54452,64488,93672,142542,162973,163045,165669,165670,165802,166746,166747,168907,
]]
,[[随机使用炉石。
Shift+At+Ctrl 又有不同效果]]}
,{"A怪","136249",[[#showtooltip 
/use [nocombat,noharm]考古;[talent:6/1]夺命黑鸦;[talent:6/2]弹幕射击;[talent:6/3]乱射]]
,[[点了弹幕就是弹幕，点了黑鸦就黑鸦，点了乱射，就是乱射的开关。
脱战的时候，是考古，可以换成你的专业技能]]}
,{"5","136243",[[#showtooltip
/use [nocombat,noharm]工程学
/castsequence [@focus,harm] [@target,harm] reset=24 反制射击,胁迫]]
,[[有焦点打断焦点，没焦点打断目标。
默认是反制，用掉反制以后是胁迫，反制冷却好又变成反制。
脱战的时候，是工程，可以换成你的专业技能]]}
,{"Fish","1053367",[[#showtooltip
/equip [equipped:远程武器,nocombat,nomod][equipped:远程武器,combat,mod]幽光鱼竿
/castsequence [combat][mod]震荡射击;reset=0 钓鱼,暗流]]
,[[钓鱼之前如果发现没装备鱼竿，自动装上再钓。
连按两下是鱼竿技能暗流，而且是保证装上鱼竿并使用暗流。
非战斗状态，按下ctrl/alt也可以打出震荡，在抓某些低级宝宝但不想造成伤害的情况下可以用，最后加上/stopattack 停止自动攻击，用得更安心
战斗状态下，按下ctrl/alt也可以切到鱼竿，万一你想打不过跳水逃走也完全没问题。]]}
,{"血","340336",[[#showtooltip [mod]银色小步兵;[combat]意气风发;奥拉留斯的低语水晶
/use [combat,nomod]意气风发;[nomod]奥拉留斯的低语水晶
/sp [mod]银色小步兵]]
,[[战斗时是意气风发。战斗前水晶可以换成其他buf。
小步兵按住ctrl或者alt出现]]}
,{"Eat","1387645",[[#showtooltip
/use [combat]假死;[mod]精华交换器;风干鲭鱼丝]]
,[[战斗中按一下是假死，战斗外是吃食，会显示食物数量。
按住ctrl或者alt，是精华交换器]]}
,{"11","132161",[[#showtooltip
/use [combat][mod]装死;飞行管理员的哨子]]
,[[战斗中是装死，再点一下就是唤醒，或者脱战完按住ctrl或alt唤醒。
脱战状态是回鸟点的哨子。]]}
,{"12","512903",[[#showtooltip
/use [nocombat,noharm,mod]移动邮箱;[nocombat,noharm]暗月大炮
/stopmacro [nocombat,noharm]
/use 多重射击
/use [@focus,help][@target,help][@targettarget,help][@pet,exists] 误导
/a [@target,help] ]]
,[[有目标或战斗中是带误导的多重，误导顺序：焦点，目标友军，目标的目标友军，宠物。
然后脱战是暗月大炮。
按住ctrl或者alt移动邮箱]]}
,{"f1","132179",[[#showtooltip
/castsequence [@pet,dead] 复活宠物; [btn:2,pet] 解散宠物; [btn:2]召唤宠物 4;[nopet,btn:3]召唤宠物 5; [nopet,mod:alt]召唤宠物 3; [nopet,mod:ctrl]召唤宠物 2;[nopet]reset=2 召唤宠物 1,复活宠物;reset=2 治疗宠物, 解散宠物
/use 凤凰之心]]
,[[当你没有宠物的时候，按一下，召唤宠物1
当你宠物活着的时候，按一下，治疗宠物
当你宠物活着的时候，右键或者着按两下，解散宠物
当你宠物死亡的时候，按一下，复活宠物，有凤凰之心时秒活，没有时读条活
当你宠物死亡的时候，而且尸体被你拖没了的时候，按两下，复活宠物
按右键，召唤宠物4；按中键，召唤宠物5；按住alt，召唤宠物3；按住ctrl，召唤宠物2；]]}
,{"f2","132127",[[#showtooltip
/use [spec:1]狂野怒火;[spec:2]急速射击
/use 野性守护
/use 群兽奔腾
/use 13
/use 14]]
,[[一键触发红人，野性守护，群兽奔腾，饰品]]}
,{"f3","132294",[[#showtooltip
/use [mod][btn:2]15;逃脱]]
,[[左键逃脱，右键或者按住ctrl/alt都触发滑翔机]]}
,{"f4","1127581",[[#showtooltip
/castsequence [nomod]reset=120 6,猎豹守护;布林顿5000]]
,[[点一下是用氮气腰带加速，在点完腰带的120秒内再点，是猎豹加速，120秒后氮气好了，又变成氮气。]]}
,{"f5","135815",[[#showtooltip
/use [mod]移动银行;照明弹]]
,[[直接点是照明弹，按住ctrl/alt是公会银行]]}
,{"f6","133971",[[#showtooltip [combat]治疗滋补剂;烹饪
/use [combat]治疗石;[btn:2]永恒炭炉;[btn:3]魔焰营火;烹饪
/use [combat]粒子护盾
/use [combat]治疗滋补剂]]
,[[战斗时会显示你的药水数量，点一下吃。
但吃的时候会先吃术士糖，没糖吃护盾，没护盾才吃药水。
非战斗状态右键中间是生不同的火，左键做食物。]]}
,{"f7","135966",[[#showtooltip
/use [@focus,help] [@target,help] [combat,@player][mod]丝纹绷带;急救;]]
,[[战斗中是用绷带，绷带优先顺序，焦点友军加焦点，目标友军加目标，不是就绷带自己。
非战斗是急救]]}
,{"f8","236222",[[#showtooltip
/use [combat]荣誉勋章;[mod]空间撕裂器 - 52区;虚灵之门]]
,[[战斗中是PVP章。
平时左键是炉石，按住ctrl/alt是52区传送]]}
,{"f9","1444943",[[#showtooltip
/use [nocombat,nomod]达拉然炉石;[nocombat]虫洞生成器：诺森德;[pet:灵魂兽,@target,help][pet:灵魂兽,@player]灵魂治愈;[pet:魁麟,@target,help][pet:魁麟,@focus,help]永恒守护者;[pet:熔岩犬]远古狂乱;]]
,[[战斗时是当前宠物的特技
当你带的灵魂兽时，是按目标友军和自己的顺序放治疗
当你带魁麟是复活，复活优先复活目标，其次复活焦点。
带熔岩犬是嗜血。
非战斗是达拉然炉石，按住ctrl/alt是诺森德传送]]}
,{"f10","892831",[[#showtooltip
/use [combat]觉醒火盆;[nocombat,mod]虫洞生成器：潘达利亚;[nocombat]虫洞离心机]]
,[[战斗中是觉醒火盆，战斗结束后复活一个5码内目标
平时左键是德拉诺传送，按住ctrl/alt是潘达利亚传送]]}
,{"f11","1053367",[[#showtooltip
/equip [equipped:远程武器,nomod]幽光鱼竿;[nomod]泰坦之击
/use [mod]暗流]]
,[[点击切换神器和鱼竿，按住ctrl/alt是鱼竿技能暗流]]}
,{"f12","237296",[[#showtooltip
/use [combat]暗月的凝视;[mod]基维斯;终极版侏儒军刀]]
,[[非战斗是军刀，群活被砍以后，这个还是有用的。ctrl/alt是基维斯
战斗中是暗月的凝视，可以替换]]}
};

local MAX_MACRO = 100
local function LoadMarco(i)
	local m = macros[i]
	return m[1],m[2],m[3],m[4]
end

local function OptionbuttonOnClick(id,button)
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	if ((id==1) and (numAccountMacros==MAX_ACCOUNT_MACROS))   then
		print("|cffdfdf00账号宏满")
		return
	elseif ((id==2) and (numCharacterMacros==MAX_CHARACTER_MACROS)) then
		print("|cffdfdf00角色宏满")
		return
	end
	if id~=1 and id~=2 then
		return
	end
	if InCombatLockdown() then 
		print("|cffdfdf00战斗中无法导入宏")
		return
	end
	local mac = MrMacroFrame.selectedMacro.mac
	CreateMacro(mac[1],"INV_Misc_QuestionMark",mac[3],id==2)
	MacroFrame_Update()
end

local function CreateButton(id,name)
    local f = CreateFrame("Button",nil,MrMacroFrame,"OptionsButtonTemplate")
    f:SetSize(125,22)
	f:RegisterForClicks("LeftButtonUp","RightButtonUp")
    f:SetText(name)
    f:SetScript("OnClick",function(self,button) OptionbuttonOnClick(id,button) end)
    f:SetScript("OnLeave",function() GameTooltip:Hide() end)
    return f
end

local function MrMacroShowMacro()
	local checked
	for i in pairs(macros) do
		local name, texture = LoadMarco(i)
		name = "|cffdfdf00"..name
		macroButtonName = "MrMacroMacroBtn"..i;
		macroButton = _G[macroButtonName];
		macroIcon = _G[macroButtonName.."Icon"];
		macroName = _G[macroButtonName.."Name"];
		macroButton:Enable()
		macroIcon:SetTexture(texture);
		macroName:SetText(name);
	end
	if not MrMacroFrame.selectedMacro then
		MrMacroMacroBtn1:Click()
	end
end

function CreateMrMacroButton()
	local button = CreateFrame('BUTTON',nil,MacroFrame,"OptionsButtonTemplate")
	button:SetSize(100,21)
	button:SetText("常用宏推荐")
	button:SetPoint("BOTTOMRIGHT",MacroFrame,"BOTTOM",11,5)
	button:SetScript("OnClick",function() 
		if MrMacroFrame then ToggleFrame(MrMacroFrame) else CreateMrMacroFrame() end
	end)
end

function CreateMrMacroFrame()
	local f = CreateFrame("Frame","MrMacroFrame",MacroFrame,"ButtonFrameTemplate")
	f:SetSize(330,420)
	f:SetPoint("LEFT",MacroFrame,"RIGHT",10,0)
	f:RegisterForDrag("LeftButton")
	f:EnableMouse(true)
	--f:SetScript("OnDragStart",function(self) MacroFrame:StartMoving()end)
	--f:SetScript("OnDragStop",function(self) MacroFrame:StopMovingOrSizing() end)
	f:SetScript("OnShow",MrMacroShowMacro)

	MrMacroFramePortrait:SetTexture("Interface\\MacroFrame\\MacroFrame-Icon")
	MrMacroFrameTitleText:SetText("常用宏推荐")

	f.HorizontalBarLeft = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarLeft:SetSize(276,16)
	f.HorizontalBarLeft:SetPoint("TOPLEFT",f,"TOPLEFT",2,-156)
	f.HorizontalBarLeft:SetTexCoord(0,1,0,.25)

	f.HorizontalBarRight = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarRight:SetSize(44,16)
	f.HorizontalBarRight:SetPoint("LEFT",f.HorizontalBarLeft,"RIGHT")
	f.HorizontalBarRight:SetTexCoord(0,0.29296875,.25,.5)

	f.HorizontalBarLeft2 = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarLeft2:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarLeft2:SetSize(276,16)
	f.HorizontalBarLeft2:SetPoint("TOPLEFT",f,"TOPLEFT",2,-256)
	f.HorizontalBarLeft2:SetTexCoord(0,1,0,.25)

	f.HorizontalBarRight2 = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarRight2:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarRight2:SetSize(44,16)
	f.HorizontalBarRight2:SetPoint("LEFT",f.HorizontalBarLeft2,"RIGHT")
	f.HorizontalBarRight2:SetTexCoord(0,0.29296875,.25,.5)

	f.scroll = CreateFrame("ScrollFrame",nil,f,"UIPanelScrollFrameTemplate")
	f.scroll:SetSize(288,95)
	f.scroll:SetPoint("TOPLEFT",f,"TOPLEFT",10,-65)
	f.scroll.top = f.scroll:CreateTexture(nil,"ARTWORK")
	f.scroll.top:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	f.scroll.top:SetSize(31,102)
	f.scroll.top:SetPoint("TOPLEFT",f.scroll,"TOPRIGHT",-2,5)
	f.scroll.top:SetTexCoord(0,0.484375,0,0.4)
	f.scroll.bottom = f.scroll:CreateTexture(nil,"ARTWORK")
	f.scroll.bottom:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	f.scroll.bottom:SetSize(31,106)
	f.scroll.bottom:SetPoint("BOTTOMLEFT",f.scroll,"BOTTOMRIGHT",-2,-2)
	f.scroll.bottom:SetTexCoord(0.515625,1.0,0,0.4140625)
	f.scrollchild = CreateFrame("Frame")
	f.scrollchild:SetSize(20,20)
	f.scrollchild :SetPoint("TOPLEFT",f.scroll,"TOPLEFT")
	f.scroll:SetScrollChild(f.scrollchild)

	f.import1 = CreateButton(1,"导入到通用宏")
	f.import2 = CreateButton(2,"导入到角色专用宏")
	f.import1:SetPoint("BOTTOMLEFT",f,"BOTTOMLEFT",4,4)
	f.import2:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-4,4)


	f.macname = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	f.macname:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
	f.macname:SetPoint("TOPLEFT",f.scroll,"BOTTOMLEFT",0,-55)
	
	createMacroBtn()
	createText()
	createNote()
	MrMacroShowMacro()

end

function createText()
	local f = MrMacroFrame
	f.textframe = CreateFrame("Frame",nil,f)
	f.textframe:SetPoint("TOPLEFT",f.scroll,"BOTTOMLEFT",0,-98)
	f.textframe:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-12,45)
	f.textframe:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 6,
		insets = {
			left = 1,
			right = 2,
			top = 4,
			bottom = 5
		}
	})
	f.textscroll = CreateFrame("ScrollFrame","chatframescroll",f.textframe,"UIPanelScrollFrameTemplate")
	f.textscroll:SetPoint("TOPLEFT",f.textframe,"TOPLEFT",5,-5)
	f.textscroll:SetPoint("BOTTOMRIGHT",f.textframe,"BOTTOMRIGHT",-25,5)
	f.text = CreateFrame("EditBox","text",f.textscroll)
	f.textscroll:SetScrollChild(f.text)
	f.text:ClearAllPoints()
	f.text:SetPoint("TOPLEFT",f.textscroll,"TOPLEFT",3,-5)
	f.text:SetPoint("BOTTOMLEFT",f.textscroll,"BOTTOMLEFT",3,15)
	f.text:SetMaxLetters(255)
	f.text:EnableMouse(true)
	f.text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	f.text:SetWidth(280)
	f.text:SetAutoFocus(false)
	f.text:ClearFocus()
	f.text:SetMultiLine(true)
	f.LimitText = f:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	f.LimitText:SetPoint("TOP",f.textframe,"BOTTOM")
	f.LimitText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	f.text:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
	f.text:SetScript("OnCursorChanged",ScrollingEdit_OnCursorChanged)
	f.text:SetScript("OnTextChanged",function(self) 
		f.textChanged = 1
		f.LimitText:SetFormattedText(MACROFRAME_CHAR_LIMIT, f.text:GetNumLetters());
		ScrollingEdit_OnTextChanged(self, self:GetParent());
	end)
end
function createNote()
	local f = MrMacroFrame
	f.noteframe = CreateFrame("Frame",nil,f)
	f.noteframe:SetPoint("TOPLEFT",f.scroll,"BOTTOMLEFT",45,-8)
	f.noteframe:SetPoint("BOTTOMRIGHT",f.textframe,"TOPRIGHT",0,0)
	f.noteframe:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 6,
		insets = {
			left = 1,
			right = 2,
			top = 4,
			bottom = 5
		}
	})
	f.notescroll = CreateFrame("ScrollFrame","chatframescroll",f.noteframe,"UIPanelScrollFrameTemplate")
	f.notescroll:SetPoint("TOPLEFT",f.noteframe,"TOPLEFT",5,-5)
	f.notescroll:SetPoint("BOTTOMRIGHT",f.noteframe,"BOTTOMRIGHT",-25,5)
	f.note = CreateFrame("EditBox","note",f.notescroll)
	f.notescroll:SetScrollChild(f.note)
	f.note:ClearAllPoints()
	f.note:SetPoint("TOPLEFT",f.notescroll,"TOPLEFT",3,-5)
	f.note:SetPoint("BOTTOMLEFT",f.notescroll,"BOTTOMLEFT",3,15)
	f.note:SetMaxLetters(1000)
	f.note:EnableMouse(true)
	f.note:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	f.note:SetWidth(230)
	f.note:SetAutoFocus(false)
	f.note:ClearFocus()
	f.note:SetMultiLine(true)
end

function createMacroBtn()
	local f = MrMacroFrame
	f.icon = CreateFrame("CheckButton", "MrMacroIcon", f, "MacroButtonTemplate")
	f.icon:SetPoint("TOPLEFT",f.scroll,"BOTTOMLEFT",3,-12)
	f.icon:SetScript("OnClick",function(self) self:SetChecked() end)
	for i=1,MAX_MACRO do
		local b = CreateFrame("CheckButton", "MrMacroMacroBtn"..i, f.scrollchild, "MacroButtonTemplate")
		b:SetPoint("TOPLEFT",f.scrollchild,"TOPLEFT",mod(i-1,6)*48+6,-floor((i-1)/6)*45-2)
		b:SetScript("OnClick",function(self)
			for id = 1,MAX_MACRO  do
				_G["MrMacroMacroBtn"..id]:SetChecked(false)
			end
			self:SetChecked(true)
			local name, texture, body, note = LoadMarco(i)
			self.mac = {name,texture,body}
			MrMacroFrame.selectedMacro = self
			f.text:SetText(body)
			MrMacroIconIcon:SetTexture(texture);
			f.macname:SetText(name);
			f.note:SetText(note);
			f.text:ClearFocus()
		end)
		b:SetScript("OnDragStart",function(self) 
			return
		end)
		b:SetScript("OnLeave",function() GameTooltip:Hide()end)
	end
end

if not IsAddOnLoaded("Blizzard_MacroUI") then
	local f = CreateFrame'Frame'
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent",function(self,event,addon)
		if addon=="Blizzard_MacroUI" then
			self:UnregisterEvent("ADDON_LOADED")
			CreateMrMacroButton()
		end
	end)
else
	CreateMrMacroButton()
end

--------------------------------------------------PolarBearRandomHearthstone----------------------------------------## Author:霜刃北极熊  ## Version:2.0
local random = math.random 
local insert = table.insert

--所有炉石ID 
local hearthstones={ 
	--> 节日炉石
	162973, --冬天爷爷的炉石 278244
	163045, --无头骑士的炉石 278559
	165669, --春节长者的炉石 285362
	165670, --小匹德菲特的可爱炉石 
	165802, --复活节的炉石
	166746, --吞火者的炉石
	166747, --美酒节狂欢者的炉石
	168907, --全息数字化炉石
	172179, --永恒旅者的炉石
	--> 其它
	64488, --旅店老板的女儿
	93672, --黑暗之门
	54452, --虚灵之门
	142542, --城镇传送门 231504   
} 

--玩家拥有的炉石
local playerhas={}

--通过宏"/click PBRH"调用随机炉石 
local PolarBearRandomHearthstone = CreateFrame("Button", "PBRH", nil, "SecureActionButtonTemplate") 

--随机选择一个炉石 
local function randomhearthstone() 
    if not UnitAffectingCombat("player") then 
        choosen=playerhas[random(#playerhas)] 
        PolarBearRandomHearthstone:SetAttribute("toy", choosen) 
    end 
end 

PolarBearRandomHearthstone:HookScript("OnClick",randomhearthstone) 
PolarBearRandomHearthstone:RegisterEvent("PLAYER_LOGIN") 
PolarBearRandomHearthstone:SetScript("OnEvent",function()
    for i,v in ipairs(hearthstones) do
        if PlayerHasToy(v) then
            insert(playerhas,v)
        end
    end
    if #playerhas == 0 then
        PolarBearRandomHearthstone:SetAttribute("type", "item")
        PolarBearRandomHearthstone:SetAttribute("item", "item:6948")
    else
        PolarBearRandomHearthstone:SetAttribute("type", "toy")
        randomhearthstone()
    end
end)


--#showtooltip [nomod]黑暗之门;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
--/cast [btn:2]飞行管理员的哨子;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
--/castrandom [nomod]54452,64488,93672,142542,162973,163045,166746,
--/run local a={54452,64488,93672,142542,162973,163045,166746} rhs=rhs or CreateFrame("Button","rhs",nil,"SecureActionButtonTemplate") rhs:SetAttribute("type","item") --rhs:SetAttribute("item",GetItemInfo(a[random(#a)]))
--/click rhs