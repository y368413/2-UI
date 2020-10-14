-- Configure 配置页面
local _, ns = ...
local _, R = unpack(ns)

R.mult = 1
R.margin = 3

-- 动作条
local barFader = {
	fadeInAlpha = 1,													-- 显示时的透明度
	fadeInDuration = .3,												-- 显示耗时
	fadeOutAlpha = .1,													-- 渐隐后的透明度
	fadeOutDuration = .8,												-- 渐隐耗时
	fadeOutDelay = .5,													-- 延迟渐隐
}
R.Bars = {
	margin = 2,															-- 按键间距
	padding = 2,														-- 边缘间距
	bar1 = {size = 38, fader = nil},									-- BAR1 主动作条（下）
	bar2 = {size = 38, fader = nil},									-- BAR2 主动作条（上）
	bar3 = {size = 36, fader = nil},									-- BAR3 主动作条两侧
	bar4 = {size = 32, fader = barFader},								-- BAR4 右边动作条1
	bar5 = {size = 32, fader = barFader},								-- BAR5 右边动作条2
	petbar = {size = 26, fader = nil},									-- PETBAR 宠物动作条
	stancebar = {size = 26, fader = nil},								-- STANCE + POSSESSBAR 姿态条
	extrabar = {size = 52, fader = nil},								-- EXTRABAR 额外动作条
	leave_vehicle = {size = 32, fader = nil},							-- VEHICLE EXIT 离开载具按钮
}

-- BUFF/DEBUFF相关
R.Auras = {
	IconSize		= 32,											-- BUFF图标大小
	BuffPos			= {"TOPRIGHT", Minimap, "TOPLEFT", -21, -3},		-- BUFF默认位置
	BHPos			= {"CENTER", UIParent, "CENTER", 0, -200},		    -- 血DK助手默认位置
	StaggerPos		= {"CENTER", UIParent, "CENTER", 0, -290},		-- 坦僧工具默认位置
	TotemsPos		= {"CENTER", UIParent, "CENTER", 0, -260},		  -- 图腾助手默认位置
	HunterToolPos		= {"CENTER", UIParent, "CENTER", 0, -310},	-- 射击猎助手默认位置
	StatuePos		= {"BOTTOMLEFT", UIParent, 520, 260},			      -- 武僧雕像默认位置
	EnergyPos	= {"CENTER", UIParent, "CENTER", 0, -195},		    -- 职业能量条默认位置
	ComboPointPos	= {'BOTTOM', UIParent, "CENTER", 16, -210},
	WarlockPowerPos	= {'BOTTOM', UIParent, "CENTER", 0, -210},
	PaladinPowerPos	= {'BOTTOM', UIParent, "CENTER", 0, -180},
	RunePos	= {'BOTTOM', UIParent, "CENTER", 0, -200},
	MonkHarmonyPos	= {'BOTTOM', UIParent, "CENTER", 90, -190},
	MonkStaggerPos	= {'BOTTOM', UIParent, "CENTER", 0, -190},
	MageArcaneChargesPos	= {'BOTTOM', UIParent, "CENTER", 0, -200},
	
  -- 技能监控各组初始位置
	ClassBarPos	  = {"CENTER", UIParent, "CENTER", -102.5, -260},	    -- 职业分组
	AbsorbPos	    = {"CENTER", UIParent, "CENTER",-110, -80},	      -- 吸收分组
	ShieldPos	    = {"CENTER", UIParent, "CENTER",90, -80},	        -- 盾牌分组
	PlayerAuraPos	= {"RIGHT", UIParent, "CENTER", -360, -160},	    -- 玩家光环分组
	TargetAuraPos   = {"LEFT", UIParent, "CENTER", 240, -155},		    -- 目标光环分组
	SpecialPos		= {"RIGHT", UIParent, "CENTER", -240, -155},	    -- 玩家重要光环分组
	FocusPos	    = {"LEFT", UIParent, "CENTER", 360, -160},		    -- 焦点光环分组
	CDPos		    = {"RIGHT", UIParent, "CENTER", -400, -220},	    -- 冷却计时分组
	EnchantPos		= {"RIGHT", UIParent, "CENTER", -203.5, -152.5},	    -- 附魔及饰品分组
	RaidBuffPos		= {"RIGHT", UIParent, "CENTER", -162, -150.5},		-- 团队增益分组
	RaidDebuffPos	= {"LEFT", UIParent, "CENTER", 162, -150.5},			-- 团队减益分组
	WarningPos		= {"LEFT", UIParent, "CENTER", 203.5, -152.5},		    -- 目标重要光环分组
	InternalPos		= {"RIGHT", UIParent, "CENTER", -450, -250},	        -- 法术内置冷却分组
}

-- 头像相关
R.UFs = {
	Playercb		= {"CENTER", UIParent, "CENTER", 0, -270},			-- 玩家施法条默认位置
	Targetcb		= {"CENTER", UIParent, "CENTER", 0, -145},			-- 目标施法条默认位置
	Focuscb			= {"CENTER", UIParent, "CENTER", 0, -130},			-- 焦点施法条默认位置
	FocusPos		= {"LEFT", UIParent, "LEFT", 5, -150},				-- 焦点框体默认位置
	PlayerPlate		= {"CENTER", UIParent, "CENTER", 0, -188},			-- 玩家姓名板默认位置
	BarPoint		= {"CENTER", UIParent, "CENTER", 0, -176},								-- 资源条位置（以自身头像为基准）
	BarSize			= {150, 5},											-- 资源条的尺寸（宽，长）
	BarMargin		= 3,												-- 资源条间隔
}

-- 小地图
R.Minimap = {
	Pos				= {"TOPRIGHT", UIParent, "TOPRIGHT", 0, 0},	-- 小地图位置
}

-- 美化及皮肤
R.Skins = {
	MicroMenuPos 	= {"TOPRIGHT", Minimap, "TOPLEFT", -1, -3},			-- 微型菜单默认坐标
	RMPos  			= {"LEFT", UIParent, "BOTTOMLEFT", 3, 330},					-- 团队工具默认坐标
}

-- 鼠标提示框
R.Tooltips = {
	TipPos 	= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -55, 210},		-- 鼠标提示框默认位置
}

-- 信息条
R.Infobar = {
	Location		= true,												-- 区域信息
	LocationPos		= {"TOP", UIParent,"TOP", 0, -3},					-- 区域信息位置
	Spec			= true,												-- 天赋专精
	SpecPos			= {"TOPLEFT", UIParent,"TOPLEFT",0, 0},				-- 天赋专精位置
	Time			= true,												-- 时间信息
	TimePos			= {"TOPLEFT", UIParent, "TOPLEFT", 25, 2},			-- 时间信息位置
	Guild	 		= true,												-- 公会信息
	GuildPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 95, -3},			-- 公会信息位置
	Friends 		= true,												-- 好友模块
	FriendsPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 130, -3},		-- 好友模块位置
	Durability		= true,												-- 耐久度
	DurabilityPos	= {"TOPLEFT", UIParent, "TOPLEFT", 180, -3},		-- 耐久度位置
	System			= true,												-- 帧数/延迟
	SystemPos		= {"TOPLEFT", UIParent, "TOPLEFT", 220, -3},		-- 帧数/延迟位置
	Latency			= true,												-- 内存占用
	LatencyPos		= {"TOPLEFT", UIParent, "TOPLEFT", 320, -3},		-- 内存占用位置
	MaxAddOns		= 21,												-- 插件信息显示数量
	Bags            = true,
	BagsPos         = {"TOPLEFT", UIParent, "TOPLEFT", 370, -3},
	Gold			= true,												-- 金币信息
	GoldPos			= {"TOPLEFT", UIParent, "TOPLEFT", 400, -3}, 	    -- 金币信息位置
	
	Fonts			= {"Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 14, "OUTLINE"},				-- 字体
	TimeFonts       = {"Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 24, "outline"},
	TTFonts         = {STANDARD_TEXT_FONT, 18, "outline"},
	FontSize		= 13,
	AutoAnchor		= true,												-- 自动对齐
}