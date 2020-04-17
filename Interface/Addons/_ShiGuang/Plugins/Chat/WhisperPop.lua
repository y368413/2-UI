--[[------------------------------- 密语语音提示 ---------------------------
local WhisperSoundTip = CreateFrame("Frame")
function WhisperSoundTip:CHAT_MSG_WHISPER() PlaySoundFile("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\Whisper.ogg", "Master") end
WhisperSoundTip:SetScript("OnEvent",function(self, event, ...)
	if self[event] then self[event](self, ...) else self:UnregisterEvent(event) end
end)
WhisperSoundTip:RegisterEvent("CHAT_MSG_WHISPER")]]

-------------------- WhisperPop.lua-- Abin--2010-9-28------------------------------------------------------------
WhisperPop = {}
WhisperPop.IGNORED_MESSAGES = { "<DBM>", "<BWS>", "<BigWigs>", "<BIGWIGS>" } -- Add your ignore tags
WhisperPop.db = { sound = 1, time = 1, help = 1 }
WhisperPop.newNames = {}
WhisperPop.filter = {"<LFG>", "任务进度提示%s?[:：]", "%[接受任务%]", "%(任务完成%)", "<大脚组队提示>", "<大脚团队提示>", "<大脚团队提示>", "【网%.易%.有%.爱】", "EUI:", "EUI_RaidCD", "EUI[:_]", "打断:.+|Hspell", "PS 死亡: .+>", "%*%*.+%*%*", "受伤源自 |Hspell ", "Fatality:.+> ", "成功打断>.+<的%-", "<iLvl>", ("%-"):rep(30), "<小队物品等级:.+>", "祝您"}
--"信誉","下单","网游","速带","查店","平台","平臺","工作室","专卖店","大卡","小卡","点卡","点心","點卡","點心","烧饼","大饼","小饼","烧圆形","大圆形","小圆形","烧rt2","大rt2","小rt2","rt2rt2","担保","擔保","承接","手工","手打","代打","代练","代刷","带打","带练","带刷","dai打","dai练","dai刷","带评级","代评级","打金","卖金","售金","出金","萬金","万金","w金","打g","卖g","售g","萬g","万g","wg","详情","详谈","详询","信誉","信赖","充值","储值","套餐","刷屏[勿见]","扰屏[勿见]","绑定.*上马","上马.*绑定","价格公道","货到付款","非诚勿扰","先.*后钱","先.*后款","价.*优惠","代.*s1","售.*s1","游戏币","最低价","无黑金","不封号","无风险","好再付","年老店","金=","g=","元=","5173","支付宝","支付寶","淘宝","淘寶","皇冠","冲冠","热销","促销","加q","企业q","咨询","联系","电话","旺旺","口口","扣扣","叩叩","歪歪","丫丫","大神带你打","高手帮忙打","竞技场大师","血腥舞钢fm","满及", "taobao","8o","9o","八[o0]","九[o0]","０","○","①","②","③","④","⑤","⑥","⑦","⑧","⑨","泏","釒", "淘寶","淘宝","旺旺","純手工","纯手工","牛肉","萬斤","手工金","手工G","平臺","黑一賠","皇冠店","代練","代打","沖鑽","衝鑽","非球不愛","積分","總元帥","高階督軍","高督","1-85","消保","好評率","大尾巴","平台交易","担保","承接","工作室","纯手工","游戏币","代打","代练","战点","手工金","手工G","托管","带级","皇冠店","一赔","套装消费","點心","冲钻","店铺","皇冠","小卡","大卡","大饼","小饼","特惠","加盟","七煌","套餐","手工带","塞纳","尘埃","Style","落叶","代刷","代抓","带刷","牛肉","专业","毕业","大桥","QQ","企鹅","联系","点心","-60","-100","-90","2200","2400","3200","0元","消保","好评","优惠","付款","默默","续费","充值","大桥","美味","梦想","黄金","战场","征服","打扰","小花","大花","出货","丫丫","声旺","一波流","小號","渃葉","熵会","落夜","天意","佰圆","二佰","二二","金币","收金","万G","點訫","军装","浅唱","吖妹","续费","大时间","小时间","660","保驾护航","贰百","0万","W金","PJ40","肖废","万金","0块","3015","點芯","-100","90-","美味","W=","可散卖","一百","⒈","⒐","⒉","⒎","萬G","畅游","￥","代刷","陶宝","點訫","宝儿","點.卡","饼干","老牌经营","G出售","买G","重.拳.戈.隆","全.网.最.低","全网","荣.誉_征.服","RMB=","包团包毕业","风神无敌","无敌0灯","小可爱","刷红玉","荣.誉","征.服","荣.征","誉.服","波塞冬斯","的Q","小-可","可-爱","H副本","抱团","最后一波","站神","小.甜.心","大/小","小.可","可.爱","十万G","带红玉","接招募","二.佰","42.W","千与千寻","夕瑶歌尽","大{rt2}","小{rt2}","刷屏[勿见]","扰屏[勿见]","月下G","包团","包毕业","挑Z","雪亽","陶{rt2}","{rt2}shop","冰{rt2}","点{rt2}","冰{@}点","挑{@}战","上.陶","锈水财阀","水财阀","{*}冰","{*}点","{*}竞{*}技","月下G团","牛牛","冰封H黑","封H黑石","内销G团","强力老板","躺尸老板","价格便宜啦","黑石G团","皇朝","老板无竞争","强力消费","来老板","跨服H黑石","G团包过","消费老板","消费的老板","支F宝","纵横魔兽","支持躺尸","黑石铸造厂","$带走","比例1W","马云消费","散卖","正负","消废","职业老板","清倉","H畢業","黑手门票","宝搜","内销","赈灾团","畢業","可散","大脚团队提示",


function WhisperPop:IsIgnoredMessage(text)
	local pattern
	for _, pattern in ipairs(self.IGNORED_MESSAGES) do
		if strfind(text, pattern) then
			return pattern
		end
	end
end

function WhisperPop:IsFilterMessage(text)
	local pattern
	local dofilter = false
	for _, pattern in ipairs(self.filter) do
		if strfind(text, pattern) then
			dofilter = true
		end
	end
	return dofilter
end

function WhisperPop:CreateCommonFrame(name, parent, titleText)
	local frame = CreateFrame("Button", name, parent)
	frame:Hide()
	frame:SetWidth(165)
	frame:SetHeight(262)
	frame:SetClampedToScreen(true)
	frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 } })

	local title = frame:CreateFontString(name.."Title", "ARTWORK", "GameFontNormal")
	title:SetPoint("TOP", 0, -7)
	title:SetText(titleText)
	frame.title = title

	local button = CreateFrame("Button", name.."CloseButton", frame, "UIPanelCloseButton")
	frame.topClose = button
	button:SetPoint("TOPRIGHT", -2, -2)
	button:SetWidth(24)
	button:SetHeight(24)

	return frame
end

function WhisperPop:CreatePlayerButton(button, name, parent)
	if not button then
		button = CreateFrame("Frame", name, parent)
		button:SetWidth(100)
		button:SetHeight(20)
	end

	button.classIcon = button:CreateTexture(button:GetName().."ClassIcon", "ARTWORK")	
	button.classIcon:SetWidth(16)
	button.classIcon:SetHeight(16)
	button.classIcon:SetPoint("LEFT", 4, 0)

	button.nameText = button:CreateFontString(button:GetName().."NameText", "ARTWORK", "GameFontHighlightSmallLeft")
	button.nameText:SetPoint("LEFT", button.classIcon, "RIGHT", 2, 0)

	button.SetPlayer = function(self, class, name)			
		self.nameText:SetText(name)
		local coords = CLASS_ICON_TCOORDS[class]
		if coords then
			self.classIcon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
			self.classIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
			self.classIcon:Show()
		elseif class == "GM" then
			self.classIcon:SetTexture("Interface\\CHATFRAME\\UI-CHATICON-BLIZZ")
			self.classIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			self.classIcon:Show()
		elseif class == "BN" then
			self.classIcon:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Share")
			self.classIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			self.classIcon:Show()
		else
			self.classIcon:Hide()
		end
	end

	return button
end

function WhisperPop:OnNewMessage(name, text, inform, guid)
	if not inform and self.db.sound then
		PlaySoundFile("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\Whisper.ogg", "Master") -- Got new message!
	end
end

function WhisperPop:GetNumNewNames()
	return getn(self.newNames)
end

function WhisperPop:GetNewName(id)
	return self.newNames[id or 1]
end

function WhisperPop:OnListUpdate()
	wipe(self.newNames)
	local i
	for i = 1, self.list:GetDataCount() do
		local data = self.list:GetData(i)
		if data.new then
			tinsert(self.newNames, data.name)
		end
	end

	self.tipFrame:SetTip(self.newNames[1])
end

function WhisperPop:ToggleFrame()
	if WhisperPop.mainFrame:IsShown() then
		WhisperPop.mainFrame:Hide()
	else
		WhisperPop.mainFrame:Show()
	end
end
----------------------------- MainFrame.lua------ 2010-9-28------------------------------------------------------------
local function SetFrameMobile(frame)
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
end

-- Tip frame
local tipFrame = CreateFrame("Button", "WhisperPopTipFrame", UIParent)
WhisperPop.tipFrame = tipFrame
SetFrameMobile(tipFrame)
--[[if GetCVar("portal") == "CN" then
tipFrame:SetPoint("BOTTOMLEFT", UIParent,"BOTTOMLEFT",285, 0)
else
tipFrame:SetPoint("BOTTOMLEFT", UIParent,"BOTTOMLEFT",262, 0)
end]]
tipFrame:SetPoint("BOTTOMLEFT", _G.ChatFrame1Tab, "TOPLEFT", 3, 3)
tipFrame:SetWidth(21)
tipFrame:SetHeight(21)
tipFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

tipFrame.icon = tipFrame:CreateTexture(tipFrame:GetName().."Icon", "ARTWORK")
tipFrame.icon:SetAllPoints(tipFrame)
tipFrame.icon:SetTexture("Interface\\FriendsFrame\\broadcast-hover")
--tipFrame.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
tipFrame.icon:Hide()
tipFrame.icon:SetDesaturated(true)
tipFrame.text = tipFrame:CreateFontString(tipFrame:GetName().."Text", "ARTWORK", "GameFontNormalSmall")
tipFrame.text:SetPoint("LEFT", tipFrame, "RIGHT")

local function TipFrame_OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.5 then
		self.elapsed = 0
		if self.icon:IsShown() then
			self.icon:Hide()
		else
			self.icon:Show()
		end
	end
end

function tipFrame:SetTip(name)
	if type(name) ~= "string" then
		name = nil
	end

	if name == self.name then
		return
	end

	self.name = name
	self.elapsed = 0
	--self.icon:Show()
	if name then
		self.icon:SetDesaturated(false)
		self.text:SetText(name)
		self:SetScript("OnUpdate", TipFrame_OnUpdate)
	else
		self.icon:Hide()
		self.icon:SetDesaturated(true)
		self.text:SetText()
		self:SetScript("OnUpdate", nil)
	end
end

tipFrame:SetScript("OnClick", function(self)
	WhisperPop:ToggleFrame()
end)

-- Main frame
local frame = WhisperPop:CreateCommonFrame("WhisperPopFrame", UIParent, CHAT_WHISPERPOP_TITLE)
WhisperPop.mainFrame = frame
tinsert(UISpecialFrames, frame:GetName())
SetFrameMobile(frame)
frame:SetToplevel(true)
frame:SetFrameStrata("DIALOG")
frame:SetPoint("BOTTOMLEFT", UIParent,"BOTTOMLEFT",10, 210)

-- Player list
local list = UICreateVirtualScrollList(frame:GetName().."List", frame, 10)
WhisperPop.list = list
list:SetHeight(200)
list:SetPoint("TOPLEFT", 7, -28)
list:SetPoint("TOPRIGHT", -7, -28)

local topLine = list:CreateTexture(nil, "ARTWORK")
topLine:SetTexture("Interface\\OptionsFrame\\UI-OptionsFrame-Spacer")
topLine:SetHeight(16)
topLine:SetPoint("LEFT", list, "TOPLEFT", -1, 5)
topLine:SetPoint("RIGHT", list, "TOPRIGHT", 1, 5)

local bottomLine = list:CreateTexture(nil, "ARTWORK")
bottomLine:SetTexture("Interface\\OptionsFrame\\UI-OptionsFrame-Spacer")
bottomLine:SetHeight(16)
bottomLine:SetPoint("LEFT", list, "BOTTOMLEFT", -1, -2)
bottomLine:SetPoint("RIGHT", list, "BOTTOMRIGHT", 1, -2)

local function CompareData(data, name)
	return data.name == name
end

local function DeleteButton_OnClick(self)
	WhisperPop.messageFrame:Hide()
	list:RemoveData(list:FindData(self:GetParent().name, CompareData))
	WhisperPop:OnListUpdate()
end

function list:OnButtonCreated(button)
	WhisperPop:CreatePlayerButton(button)
	button:RegisterForClicks("AnyUp")

	local del = CreateFrame("Button", button:GetName().."Delete", button, "UIPanelCloseButton")
	button.deleteButton = del
	del:SetWidth(16)
	del:SetHeight(16)
	del:SetPoint("RIGHT")
	del:SetScript("OnClick", DeleteButton_OnClick)

	button.nameText:SetPoint("RIGHT", del, "LEFT")
end

function list:OnButtonUpdate(button, data)
	button.name = data.name
	button:SetPlayer(data.class, data.name)
	if data.new then
		button.nameText:SetTextColor(0, 1, 0)
	elseif data.received then
		button.nameText:SetTextColor(1, 1, 1)
	else
		button.nameText:SetTextColor(0.5, 0.5, 0.5)
	end
end

function list:OnButtonEnter(button, data)
	if WhisperPop.db.receiveonly and not data.received then
		WhisperPop.messageFrame:Hide()
		return
	end

	if data.new then
		data.new = nil
		button.nameText:SetTextColor(1, 1, 1)
		WhisperPop:OnListUpdate()
	end

	WhisperPop.messageFrame:ClearAllPoints()

	if button:GetLeft() > 350 then
		WhisperPop.messageFrame:SetPoint("RIGHT", button, "LEFT", -4, 0)
	else
		WhisperPop.messageFrame:SetPoint("LEFT", button, "RIGHT", 4, 0)
	end

	WhisperPop.messageFrame:SetData(data.class, data.name, data.messages, data.bnFriend)
	WhisperPop.messageFrame:StopCounting()
end

function list:OnButtonLeave(button, data)
	WhisperPop.messageFrame:StartCounting()
end

function list:OnButtonClick(button, data, flag)
	local presenceID = BNet_GetBNetIDAccount(data.name)
	if flag == "RightButton" then
		-- Right click brings up unit drop down menu
		if data.bnFriend then
			FriendsFrame_ShowBNDropdown(data.name, 1, nil, "BN_WHISPER", _, nil, presenceID)
		else
			FriendsFrame_ShowDropdown(data.name, 1)
		end
	elseif flag == "LeftButton" then
		if IsShiftKeyDown() then
			-- Query player info
			SendWho("n-"..data.name)
		elseif IsAltKeyDown() then
			-- Invite
			C_PartyInfo.ConfirmInviteUnit(data.name)
		else
			if data.bnFriend then
				SetItemRef( "BNplayer:"..(data.name)..":"..presenceID, ("|Hplayer:%1$s|h[%1$s]|h"):format(data.name), "LeftButton" )
			else
				ChatFrame_SendTell(data.name)
			end
		end
	end
end

list:RegisterEvent("CHAT_MSG_WHISPER")
list:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
list:RegisterEvent("CHAT_MSG_BN_WHISPER")
list:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
--list:RegisterEvent("CHAT_MSG_BN_CONVERSATION")

list:SetScript("OnEvent", function (self, event, text, name, _, _, _, status, _, _, _, _, _, guid, BNguid)
	if type(text) ~= "string" or type(name) ~= "string" or (BNguid == 0 and (type(guid) ~= "string")) or WhisperPop:IsIgnoredMessage(text) or WhisperPop:IsFilterMessage(text) or status == "DND" then
		return
	end
	
	local bnFriend = event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM"
	-- Whenever we recieve a whisper message, we check if the person is already in list, if it is, we bring it to top
	local inform = event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER_INFORM"
	if event == "CHAT_MSG_WHISPER" then
		if not strfind(name, "-") then
			name = name.."-"..GetRealmName()
		end
	end
	local timeStamp = "|cffffd200"..strsub(date(), 10, 17).."|r"
	local reading = WhisperPop.messageFrame:IsReading() == name
	local idx = list:FindData(name, CompareData)
	local data = list:GetData(idx)
	if data then
		if idx ~= 1 then
			list:ShiftData(idx, 1)
		elseif reading then
			WhisperPop.messageFrame:AddMessage(timeStamp, text, inform, bnFriend)
			WhisperPop.messageFrame:UpdateHeight()
		end
	else
		data = { name = name, class = class, messages = {}, bnFriend = bnFriend } -- Person not in list, create a new record for him
		if bnFriend then
			data.class = "BN"
		elseif status == "GM" then
			data.class = "GM"
		elseif type(guid) == "string" then
			data.class = select(2, GetPlayerInfoByGUID(guid))
		end
		list:InsertData(data, 1)
	end

	tinsert(data.messages, { text = text, time = timeStamp, timeraw = time(), inform = inform })
	if inform then
		-- Replying a person removes the "new" mark from him
		data.new = nil
	else
		data.received = 1
		if not reading then
			data.new = 1
		end
	end

	list:UpdateData(1)
	WhisperPop:OnNewMessage(name, text, inform, guid, bnFriend)
	WhisperPop:OnListUpdate()
end)
-------------------------------- MessageFrame.lua------ 2010-9-28------------------------------------------------------------
local FRAME_WIDTH = 320
local INDENT_LEFT = 8
local INDENT_RIGHT = 28
local LIST_WIDTH = FRAME_WIDTH - INDENT_LEFT - INDENT_RIGHT
local MESSAGE_MIN_HEIGHT = 48
local MESSAGE_MAX_HEIGHT = 400
local MESSAGE_ADD_HEIGHT = 35
local COUNTING_TIME = 0.3

-- Message frame
local frame = WhisperPop:CreateCommonFrame("WhisperPopMessageFrame", WhisperPop.mainFrame)
WhisperPop.messageFrame = frame
frame:SetWidth(FRAME_WIDTH)

local label = WhisperPop:CreatePlayerButton(nil, frame:GetName().."Label", frame)
label:SetPoint("TOPLEFT", INDENT_LEFT, -5)
label:SetPoint("TOPRIGHT", -INDENT_RIGHT, -5)

-- The ScrollingMessageFrame that displays message text lines
local list = CreateFrame("ScrollingMessageFrame", "WhisperPopScrollingMessageFrame", frame, "ChatFrameTemplate")
list:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
list:SetWidth(LIST_WIDTH)
list:Show()
list:SetFading(false)
list:SetMaxLines(1000)
list:SetJustifyH("LEFT")
list:SetIndentedWordWrap(false)
list:SetFrameStrata("DIALOG")
list:SetScript("OnLoad", nil)
list:SetScript("OnEvent", nil)
list:SetScript("OnUpdate", nil)
list:UnregisterAllEvents()

-- A hidden FontString to determine height of every message text
local totalHeight = 0
local testFont = list:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
testFont:SetPoint("TOPLEFT", list, "BOTTOMLEFT")
testFont:SetWidth(LIST_WIDTH)
testFont:SetJustifyH("LEFT")
testFont:SetNonSpaceWrap(true)
testFont:Hide()
testFont:SetText("ABC")
local SINGLE_HEIGHT = testFont:GetHeight()

frame:EnableMouseWheel(true)
frame:SetScript("OnMouseWheel", function(self, delta)
	if delta == 1 then
		if IsShiftKeyDown() then
			list:ScrollToTop()
		else
			list:ScrollUp()
		end
	elseif delta == -1 then
		if IsShiftKeyDown() then
			list:ScrollToBottom()
		else
			list:ScrollDown()
		end
	end
end)

function frame:IsReading()
	if self:IsShown() then
		return self.name
	end
end

function frame:UpdateHeight()
	if totalHeight < SINGLE_HEIGHT then
		totalHeight = SINGLE_HEIGHT
	end

	if totalHeight > MESSAGE_MAX_HEIGHT then
		totalHeight = MESSAGE_MAX_HEIGHT
	end

	self:SetHeight(max(totalHeight, MESSAGE_MIN_HEIGHT) + MESSAGE_ADD_HEIGHT + 2)
	list:SetHeight(totalHeight + 2)
end

function frame:AddMessage(timeStamp, text, inform, bnFriend)
	if inform and WhisperPop.db.receiveonly then
		return
	end

	local useTime = WhisperPop.db.time
	local r, g, b
	if inform then
		r, g, b = 0.5, 0.5, 0.5
	elseif bnFriend then
		r, g, b = 0, 1, 0.96
	else
		r, g, b = 1, 0.5, 1
	end

	local term, tag
	for tag in gmatch(text, "%b{}") do
		term = strlower(gsub(tag, "[{}]", ""))
		if ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]] then
			text = gsub(text, tag, ICON_LIST[ICON_TAG_LIST[term]] .. "0|t")
		end
	end

	text = useTime and timeStamp.." "..text or text
	list:AddMessage(text, r, g, b, inform and 1 or 0)

	if totalHeight < MESSAGE_MAX_HEIGHT then
		testFont:SetText(text)
		totalHeight = totalHeight + testFont:GetHeight()
	end
end

function frame:SetData(class, name, messages, bnFriend)
	if self:IsReading() == name then
		return
	end

	self.name = name
	label:SetPlayer(class, name)
	list:Clear()
	totalHeight = 0

	local data
	for _, data in ipairs(messages) do
		self:AddMessage(data.time, data.text, data.inform, bnFriend)
	end

	self:Show()
	self:UpdateHeight()
	list:ScrollToBottom()
end

frame:SetScript("OnUpdate", function(self)
	if self.hideTime and GetTime() > self.hideTime then
		self.hideTime = nil
		self:Hide()
	end
end)

function frame:StartCounting()
	self.hideTime = GetTime() + COUNTING_TIME
end

function frame:StopCounting()
	self.hideTime = nil
end

local function StartCounting()
	frame:StartCounting()
end

local function StopCounting()
	frame:StopCounting()
end

frame:SetScript("OnEnter", StopCounting)
frame:SetScript("OnLeave", StartCounting)

frame.topClose:SetScript("OnEnter", StopCounting)
frame.topClose:SetScript("OnLeave", StartCounting)

list:SetScript("OnHyperlinkEnter", StopCounting)
list:SetScript("OnHyperlinkLeave", StartCounting)

local function CreateScrollButton(name, parentFuncName)
	local button = CreateFrame("Button", list:GetName().."Button"..name, list)
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Down")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	button.parentFuncName = parentFuncName
	button:SetScript("OnClick", function(self) list[self.parentFuncName](list) end)
	button:SetScript("OnEnter", StopCounting)
	button:SetScript("OnLeave", StartCounting)
	return button
end

-- Scroll buttons
local endButton = CreateScrollButton("End", "ScrollToBottom")
endButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)

local flash = endButton:CreateTexture(endButton:GetName().."Flash", "OVERLAY")
flash:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-BlinkHilight")
flash:SetAllPoints(endButton)
flash:Hide()

endButton:SetScript("OnUpdate", function(self, elapsed)
	if list:AtBottom() then
		flash:Hide()
		return
	end

	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.5 then
		self.elapsed = 0
		if flash:IsShown() then
			flash:Hide()
		else
			flash:Show()
		end
	end
end)

local downButton = CreateScrollButton("Down", "ScrollDown")
downButton:SetPoint("BOTTOM", endButton, "TOP", 0, -6)

local upButton = CreateScrollButton("Up", "ScrollUp")
upButton:SetPoint("BOTTOM", downButton, "TOP", 0, -6)
--------------------- OptionFrame.lua---- Abin--------------------------------------------------------------
--<Bindings>
--	<Binding name="WHISPERPOP_TOGGLE" header="WHISPERPOP_TITLE" category="BINDING_MAORUI_BUTTONCLICK">
--	 WhisperPop:ToggleFrame()
--  </Binding>
--</Bindings>
--BINDING_HEADER_WHISPERPOPTITLE = WHISPERPOP_LOCALE["title"]
--BINDING_NAME_WHISPERPOPTOGGLE = WHISPERPOP_LOCALE["toggle frame"]

-- Option frame
local frame = CreateFrame("Frame", "WhisperPopOptionFrame", WhisperPop.mainFrame)
frame:SetWidth(135)
frame:SetHeight(20)
frame:SetPoint("BOTTOMLEFT", 12, 7)

local prev
local function CreateOptionButton(name, icon, key, tooltipTitle, tooltipText)
	local button = CreateFrame(key and "CheckButton" or "Button", frame:GetName()..name.."Button", frame)
	button:SetWidth(14)
	button:SetHeight(14)
	if prev then
		button:SetPoint("LEFT", prev, "RIGHT", 6, 0)
	else
		button:SetPoint("LEFT")
	end
	prev = button

	button.key, button.tooltipTitle, button.tooltipText = key, tooltipTitle, tooltipText

	button.icon = button:CreateTexture(nil, "BORDER")
	button.icon:SetAllPoints(button)
	button.icon:SetTexture(icon)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	if key then
		local checkedTexture = button:CreateTexture(nil, "OVERLAY")
		button:SetCheckedTexture(checkedTexture)
		checkedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		checkedTexture:SetPoint("TOPLEFT", button.icon, "TOPLEFT", -4, 4)
		checkedTexture:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 4, -4)
	end

	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	button.Float = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
		self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -1, 1)
	end

	button.Sink = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
		self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 1, -1)
	end

	button.Restore = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetAllPoints(self)
	end

	button.ShowTooltip = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:ClearLines()
		if self.tooltipTitle then
			GameTooltip:AddLine(self.tooltipTitle)
		end

		if self.tooltipText then
			GameTooltip:AddLine(self.tooltipText, 0, 1, 0, 1)
		end

		GameTooltip:Show()
	end

	button:SetScript("OnEnter", function(self)
		self:Float()
		self:ShowTooltip()
	end)

	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
		self:Restore()
	end)

	button:SetScript("OnMouseDown", button.Sink)
	button:SetScript("OnMouseUp", button.Restore)

	button:SetScript("OnClick", function(self, ...)
		WhisperPop.messageFrame:Hide()
		if self.key then
			if WhisperPop.db[self.key] then
				WhisperPop.db[self.key] = nil
			else
				WhisperPop.db[self.key] = 1
			end
		end

		if type(button.OnClick) == "function" then
			button:OnClick(...)
		end
	end)

	return button
end

-- Option buttons
local recOnlyButton = CreateOptionButton("ReceiveOnly", "Interface\\Icons\\INV_Scroll_10", "receiveonly", WHISPERPOP_LOCALE["receive only"], WHISPERPOP_LOCALE["receive only tooltip"])
local soundButton = CreateOptionButton("Sound", "Interface\\Icons\\INV_Misc_Bell_01", "sound", WHISPERPOP_LOCALE["sound notifying"], WHISPERPOP_LOCALE["sound notifying tooltip"])
local timeButton = CreateOptionButton("Time", "Interface\\Icons\\INV_Misc_PocketWatch_02", "time", WHISPERPOP_LOCALE["time"], WHISPERPOP_LOCALE["time tooltip"])

local clearButton = CreateOptionButton("Clear", "Interface\\Icons\\Spell_Shadow_SacrificialShield", nil, WHISPERPOP_LOCALE["delete messages"], WHISPERPOP_LOCALE["delete messages tooltip"])
local keepButton = CreateOptionButton("Keep", "Interface\\ChatFrame\\UI-ChatIcon-BlinkHilight", "keep", WHISPERPOP_LOCALE["keep messages"], WHISPERPOP_LOCALE["keep messages tooltip"])

function clearButton:OnClick()
	WhisperPop.list:Clear()
	WhisperPop:OnListUpdate()
end

frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGOUT" then
        if WhisperPop.db.keep then
            WhisperPop.db.keepDatas = WhisperPopFrameList.listData
        else
            WhisperPop.db.keepDatas = nil
        end
    elseif event == "VARIABLES_LOADED" then
		if type(ShiGuangDB.WhisperPop) ~= "table" then
			ShiGuangDB.WhisperPop = WhisperPop.db
		else
			WhisperPop.db = ShiGuangDB.WhisperPop
        end

        if WhisperPop.db.keep then
            WhisperPopFrameList.listData = WhisperPop.db.keepDatas or WhisperPopFrameList.listData;
            local keepTime = time() - 60*60*24;
            for i = #WhisperPopFrameList.listData, 1, -1 do
                local messages = WhisperPopFrameList.listData[i].messages
                while messages and messages[1] and (not messages[1].timeraw or messages[1].timeraw < keepTime) do
                    table.remove(messages, 1)
                end
                if not messages or #messages == 0 then
                    table.remove(WhisperPopFrameList.listData, i)
                end
            end
            WhisperPop.db.keepDatas = nil
            WhisperPopFrameList.needRefresh = 1
            DEFAULT_CHAT_FRAME:AddMessage("提示：密语记录插件正在记录并保存私聊信息，如果您正在网吧等公共环境，建议关闭此功能。", 1, .5, .5);

        end

		recOnlyButton:SetChecked(WhisperPop.db.receiveonly)
		soundButton:SetChecked(WhisperPop.db.sound)
        timeButton:SetChecked(WhisperPop.db.time)
        keepButton:SetChecked(WhisperPop.db.keep)
	end
end)
-------------------------------------------------- Slash handler-------------------------------------------------
SLASH_WHISPERPOP1 = "/whisperpop"
SlashCmdList["WHISPERPOP"] = function() WhisperPop:ToggleFrame() end