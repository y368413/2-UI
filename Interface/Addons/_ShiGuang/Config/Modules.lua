-- Configure 配置页面
local _, ns = ...
local _, R = unpack(ns)

-- 动作条
R.Bars = {
	margin = 2,															-- 按键间距
	padding = 2,														-- 边缘间距
}

-- BUFF/DEBUFF相关
R.Auras = {
	BuffPos			= {"TOPRIGHT", Minimap, "TOPLEFT", -21, -3},		-- BUFF默认位置
	TotemsPos		= {"CENTER", UIParent, "CENTER", 0, -260},		  -- 图腾助手默认位置
	
  -- 技能监控各组初始位置
	ClassBarPos	  = {"CENTER", UIParent, "CENTER", -100, -260},	    -- 职业分组
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
	Playercb		= {"CENTER", UIParent, "CENTER", 0, -265},			-- 玩家施法条默认位置
	Targetcb		= {"CENTER", UIParent, "CENTER", 0, -145},			-- 目标施法条默认位置
	Focuscb			= {"CENTER", UIParent, "CENTER", 0, -130},			-- 焦点施法条默认位置
	FocusPos		= {"LEFT", UIParent, "LEFT", 150, -150},			-- 焦点框体默认位置
	PlayerPlate		= {"CENTER", UIParent, "CENTER", 0, -188},			-- 玩家姓名板默认位置
	BarPoint		= {"CENTER", UIParent, "CENTER", 0, -175},			-- 资源条位置（以自身头像为基准）
	BarSize			= {160,6},											-- 资源条的尺寸（宽，长）
}

-- 小地图
R.Minimap = {
	Pos				= {"TOPRIGHT", UIParent, "TOPRIGHT", 0, 0},	-- 小地图位置
}

-- 美化及皮肤
R.Skins = {
	MicroMenuPos 	= {"TOPRIGHT", Minimap, "TOPLEFT", -1, -3},			-- 微型菜单默认坐标
	RMPos  			= {"TOP", UIParent, "TOP", -430, 8},					-- 团队工具默认坐标
}

-- 鼠标提示框
R.Tooltips = {
	TipPos 	= {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -55, 210},		-- 鼠标提示框默认位置
}

-- 信息条
R.Infobar = {
	CustomAnchor	= false,											-- 自定义位置
	Guild	 		= true,												-- 公会信息
	GuildPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 95, -3},			-- 公会信息位置
	Friends 		= true,												-- 好友模块
	FriendsPos 		= {"TOPLEFT", UIParent, "TOPLEFT", 130, -3},		-- 好友模块位置
	Latency			= true,												-- 内存占用
	LatencyPos		= {"TOPLEFT", UIParent, "TOPLEFT", 320, -3},		-- 内存占用位置
	System			= true,												-- 帧数/延迟
	SystemPos		= {"TOPLEFT", UIParent, "TOPLEFT", 220, -3},		-- 帧数/延迟位置
	Location		= true,												-- 区域信息
	LocationPos		= {"TOP", UIParent,"TOP", 0, -6},					-- 区域信息位置
	Spec			= true,												-- 天赋专精
	SpecPos			= {"TOPLEFT", UIParent,"TOPLEFT",0, 0},				-- 天赋专精位置
	Durability		= true,												-- 耐久度
	DurabilityPos	= {"TOPLEFT", UIParent, "TOPLEFT", 180, -3},		-- 耐久度位置
	Bags            = true,
	BagsPos         = {"TOPLEFT", UIParent, "TOPLEFT", 370, -3},
	Gold			= true,												-- 金币信息
	GoldPos			= {"TOPLEFT", UIParent, "TOPLEFT", 400, -3}, 	    -- 金币信息位置
	Time			= true,												-- 时间信息
	TimePos			= {"TOPLEFT", UIParent, "TOPLEFT", 25, 2},			-- 时间信息位置
	
	TimeFonts       = {"Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 24, "outline"},
	TTFonts         = {STANDARD_TEXT_FONT, 19, "outline"},
}