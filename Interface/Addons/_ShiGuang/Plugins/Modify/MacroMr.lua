local MrDIYMacros = {{"坐骑","168267",[[#showtooltips
/castsequence  [btn:2]旅行者的苔原猛犸象;[mod:shift]雄壮远足牦牛;[mod:alt]猩红水黾;[mod:ctrl]黑曜夜之翼;
#showtooltips 无敌
/run C_MountJournal.SummonByID(0)
/cast 幽魂之狼
/cast 旅行形态
/cast 滑翔
]]
,[[功能和随机偏好坐骑一致。增加了:
左键随机坐骑，右键水黾。按住ctrl-机油坐骑，shift-大象，alt-牦牛。]]}
,{"炉石","163045",[[#showtooltip [nomod]"炉石";[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
/cast [btn:2]飞行管理员的哨子;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘
/castrandom [nomod,btn:1]54452,64488,93672,142542,162973,163045,165669,165670,165802,166746,166747,168907,
]]
,[[随机使用炉石。
Shift+Alt+Ctrl 又有不同效果]]}
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
,{"胜利","163213",[[#showtooltip 胜利在望
/focus target
/cleartarget
/targetenemy [help][dead][noexists]
/cast 胜利在望
/target focus
/clearfocus
/startattack]]
,[[不丢失当前目标，距离不够技能打不出去，选最近目标施放技能]]}
,{"分解","169872",[[#showtooltip
/cast 分解
/actfunctions 分解
/use]]
,[[2UI专属快速分解，无脑一直点，慎用!!!!!
选矿、研磨、开锁同理，替换宏名称、技能名称即可]]}
,{"追踪","141605",[[/actfunctions 追踪]]
,[[2UI专属LR快速对应种族追踪，对着动物使用，追踪该种族生物，再点取消。]]}
,{"坐骑","13262",[[/actfunctions 坐骑
/use]]
,[[2UI专属坐骑智能宏，可在esc-选项-插件-[便捷]副业功能中，自定义设置。]]}
};

local MAX_MACRO = 100
local function LoadMarco(i)
	local m = MrDIYMacros[i]
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
    local f = CreateFrame("Button",nil,MrMacroFrame,"UIPanelButtonTemplate")  --OptionsButtonTemplate
    f:SetSize(125,22)
	f:RegisterForClicks("LeftButtonUp","RightButtonUp")
    f:SetText(name)
    f:SetScript("OnClick",function(self,button) OptionbuttonOnClick(id,button) end)
    f:SetScript("OnLeave",function() GameTooltip:Hide() end)
    return f
end

local function MrMacroShowMacro()
	local checked
	for i in pairs(MrDIYMacros) do
		local name, texture = LoadMarco(i)
		name = "|cffdfdf00"..name
		macroButtonName = "MrMacroMacroBtn"..i;
		macroButton = _G[macroButtonName];
		macroIcon = _G[macroButtonName.."Icon"] or macroButton.Icon;
		macroName = _G[macroButtonName.."Name"] or macroButton.Name;
		macroButton:Enable()
		macroIcon:SetTexture(texture);
		macroName:SetText(name);
	end
	if not MrMacroFrame.selectedMacro then
		MrMacroMacroBtn1:Click()
	end
end

function CreateMrMacroButton()
	local button = CreateFrame('BUTTON',nil,MacroFrame,"UIPanelButtonTemplate")  --OptionsButtonTemplate
	button:SetSize(100,21)
	button:SetText("常用宏推荐")
	button:SetPoint("BOTTOMLEFT",MacroFrame,"BOTTOMLEFT",82,4)
	button:SetScript("OnClick",function() 
		if MrMacroFrame then ToggleFrame(MrMacroFrame) else CreateMrMacroFrame() end
	end)
end

function CreateMrMacroFrame()
	local f = CreateFrame("Frame","MrMacroFrame",MacroFrame,"ButtonFrameTemplate")
	f:SetSize(660,420)
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
	f.HorizontalBarLeft:SetSize(606,16)
	f.HorizontalBarLeft:SetPoint("TOPLEFT",f,"TOPLEFT",2,-156)
	f.HorizontalBarLeft:SetTexCoord(0,1,0,.25)

	f.HorizontalBarRight = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarRight:SetSize(44,16)
	f.HorizontalBarRight:SetPoint("LEFT",f.HorizontalBarLeft,"RIGHT")
	f.HorizontalBarRight:SetTexCoord(0,0.29296875,.25,.5)

	f.HorizontalBarLeft2 = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarLeft2:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarLeft2:SetSize(606,16)
	f.HorizontalBarLeft2:SetPoint("TOPLEFT",f,"TOPLEFT",2,-256)
	f.HorizontalBarLeft2:SetTexCoord(0,1,0,.25)

	f.HorizontalBarRight2 = f:CreateTexture(nil,"ARTWORK")
	f.HorizontalBarRight2:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar")
	f.HorizontalBarRight2:SetSize(44,16)
	f.HorizontalBarRight2:SetPoint("LEFT",f.HorizontalBarLeft2,"RIGHT")
	f.HorizontalBarRight2:SetTexCoord(0,0.29296875,.25,.5)

	f.scroll = CreateFrame("ScrollFrame",nil,f,"UIPanelScrollFrameTemplate")
	f.scroll:SetSize(618,95)
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
	--[[f.textframe:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 6,
		insets = {
			left = 1,
			right = 2,
			top = 4,
			bottom = 5
		}
	})]]
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
	f.text:SetWidth(610)
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
	--[[f.noteframe:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 6,
		insets = {
			left = 1,
			right = 2,
			top = 4,
			bottom = 5
		}
	})]]
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
	f.note:SetWidth(560)
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
		b:SetPoint("TOPLEFT",f.scrollchild,"TOPLEFT",mod(i-1,13)*47+13,-floor((i-1)/13)*45-2)
		b:SetScript("OnClick",function(self)
			for id = 1,MAX_MACRO  do
				_G["MrMacroMacroBtn"..id]:SetChecked(false)
			end
			self:SetChecked(true)
			local name, texture, body, note = LoadMarco(i)
			self.mac = {name,texture,body}
			MrMacroFrame.selectedMacro = self
			f.text:SetText(body)
			--MrMacroIconIcon:SetTexture(texture);
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

if not C_AddOns.IsAddOnLoaded("Blizzard_MacroUI") then
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

do
    -- 宏界面
    local tempScrollPer = nil
    
    -- 初始化函数，调整宏界面元素的大小和位置
    local Init = function()
        -- 当选择宏时恢复滚动条位置
        hooksecurefunc(MacroFrame, "SelectMacro", function(self, index)
                if tempScrollPer then
                    -- 恢复宏选择框的滚动条位置
                    MacroFrame.MacroSelector.ScrollBox:SetScrollPercentage(tempScrollPer)
                    tempScrollPer = nil -- 重置临时存储
                end
        end)
        
        -- 设置外框高度和宽度
        MacroFrame:SetHeight(338 * 2.03) -- 外框高度
        MacroFrame:SetWidth(338 * 2.55) -- 外框宽度
        
        -- 调整宏选择框的高度
        MacroFrame.MacroSelector:SetHeight(590) -- 宏图标区域高度
        MacroFrame.MacroSelector:SetWidth(515) -- 宏图标区域宽度
        
        -- 设置每行显示10个图标
        if MacroFrame.MacroSelector.SetCustomStride then
            MacroFrame.MacroSelector:SetCustomStride(10) -- 每行显示10个图标
        end
        
        -- 调整宏选择框和输入框的位置，使其横向排列
        MacroFrameSelectedMacroBackground:ClearAllPoints()
        MacroFrameSelectedMacroBackground:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT", 518, -60)
        
        MacroFrameTextBackground:ClearAllPoints()
        MacroFrameTextBackground:SetPoint("TOPLEFT", MacroFrame, "TOPLEFT", 518, -132)
        MacroFrameTextBackground:SetHeight(510) -- 输入框高度
        
        MacroFrameScrollFrame:SetHeight(500) -- 滚动条高度
        
        MacroFrameCharLimitText:ClearAllPoints()
        MacroFrameCharLimitText:SetPoint("TOP", MacroFrameTextBackground, "BOTTOM", 0, 0)
        
        MacroHorizontalBarLeft:ClearAllPoints()
    end
    
    -- 如果MacroFrame已经加载，立即执行初始化
    if MacroFrame then
        Init()
    else
        -- 创建一个框架以监听ADDON_LOADED事件，确保Blizzard_MacroUI加载时执行初始化
        local f = CreateFrame("Frame")
        f:SetScript("OnEvent", function(self, event, addon)
                -- 当加载Blizzard_MacroUI插件时，进行初始化
                if event == "ADDON_LOADED" then
                    if addon == "Blizzard_MacroUI" then
                        Init() -- 初始化宏界面
                        f:UnregisterEvent("ADDON_LOADED") -- 完成后取消注册
                    end
                elseif MacroFrame then
                    -- 每次更新宏界面时，记录当前滚动条位置
                    tempScrollPer = MacroFrame.MacroSelector.ScrollBox.scrollPercentage
                end
        end)
        
        f:RegisterEvent("ADDON_LOADED") -- 监听宏插件的加载事件
        -- 当宏界面更新时，确保在显示时滚动条位置能恢复
        f:RegisterEvent("UPDATE_MACROS")
    end
end
--#showtooltip [nomod]黑暗之门;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
--/cast [btn:2]飞行管理员的哨子;[mod:ctrl]达拉然炉石;[mod:alt]要塞炉石;[mod:shift]海军上将的罗盘;
--/castrandom [nomod]54452,64488,93672,142542,162973,163045,166746,
--/run local a={54452,64488,93672,142542,162973,163045,166746} rhs=rhs or CreateFrame("Button","rhs",nil,"secureActionButtonTemplate") rhs:SetAttribute("type","item") --rhs:SetAttribute("item",GetItemInfo(a[random(#a)]))
--/click rhs