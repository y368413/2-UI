--## Author: 高频变压器  ## Version: v5.0_2021.8.12 

--[[
684 [可怕的恐魔]    --军团勋章
683 [暴雪嘉年华]    --英雄的冰封装备
307 [通天峰行动]    --645浴血兵器
308 [我们有钻探机]  --645浴血护甲套装
329 [舞蹈学院]      --超级舞王指南
362/363 [炉石锦标赛]--炉石
682 [食人魔的困境]  --1000要塞资源
685 [恐怖动物园]    --250原油
647 [黑市日志]      --黑市商人 张瑶 的任务
]]

--9.0指挥台成就任务监控 任务ID
--[[
2250 突破平原
2251 盖拉克的复仇
2252 凝团冥殇
2253 消灭巨人
2254 阴暗天空，黑暗未来
2255 德拉沃克的阴谋
2256 豪华设计
2258 斩断丝线
2259 绝望之影
2260 克雷拉，悲哀之翼
]]

local IDs = {684,647,2250,2251,2252,2253,2254,2255,2256,2258,2259,2260}
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("GARRISON_MISSION_FINISHED")
frame:SetScript("OnEvent", function()
    local missions6 = C_Garrison.GetAvailableMissions(Enum.GarrisonFollowerType.FollowerType_6_0)  --6.0要塞
    local missions62 = C_Garrison.GetAvailableMissions(Enum.GarrisonFollowerType.FollowerType_6_2) --6.2船坞
    --local missions7 = C_Garrison.GetAvailableMissions(LE_FOLLOWER_TYPE_GARRISON_7_0)             --7.0职业大厅
    --local missions8 = C_Garrison.GetAvailableMissions(LE_FOLLOWER_TYPE_GARRISON_8_0)             --8.0争霸
    local missions9 = C_Garrison.GetAvailableMissions(Enum.GarrisonFollowerType.FollowerType_9_0)  --9.0指挥台
	
--6.0要塞任务监控
if missions6 ~= nil then
    for i = 1, #missions6 do
		for _, id in pairs(IDs) do
            if missions6[i].missionID == id then
                if id == 684 then
				    PlaySoundFile("Interface\\AddOns\\GarrisonJK\\Sound\\要塞徽章.ogg", "Master")
				    print("|cffff4500→注意! |r\124T237560:16\124t \124cff0070dd\124Hitem:128315:0:0:0:0:0:0:0:0:0:0:0\124h[军团勋章]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")
			    elseif id == 683 then
				    print("|cffff4500→注意! |r\124T236313:16\124t \124cffa335ee\124Hitem:128314:0:0:0:0:0:0:0:0:0:0:0\124h[英雄的冰封装备]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")
			    elseif id == 307 then
				    print("|cffff4500→注意! |r\124T1030914:16\124t \124cffa335ee\124Hitem:114622:0:0:0:0:0:0:0:0:0:0:0\124h[浴血兵器]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")
			    elseif id == 308 then
				    print("|cffff4500→注意! |r\124T1030912:16\124t \124cffa335ee\124Hitem:114746:0:0:0:0:0:0:0:0:0:0:0\124h[浴血护甲套装]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")						
			    elseif id == 329 then
				    print("|cffff4500→注意! |r\124T132171:16\124t \124cff0070dd\124Hitem:118474:0:0:0:0:0:0:0:0:0:0:0\124h[超级舞王指南]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")					
			    elseif id == 362 then
				    print("|cffff4500→注意! |r\124T133743:16\124t \124cff0070dd\124Hitem:118475:0:0:0:0:0:0:0:0:0:0:0\124h[炉石战术指南]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")					
			    elseif id == 363 then
				    print("|cffff4500→注意! |r\124T133743:16\124t \124cff0070dd\124Hitem:118475:0:0:0:0:0:0:0:0:0:0:0\124h[炉石战术指南]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")
			    elseif id == 682 then
				    print("|cffff4500→注意! |r\124T236995:16\124t \124cff0070dd\124Hitem:128313:0:0:0:0:0:0:0:0:0:0:0\124h[巨大的食人魔箱子]\124h\124r|cffff4500 6.0要塞任务刷新了！|r")
                end	
			    break
            end
        end
    end
end

--6.2船坞任务监控
if missions62 ~= nil then
    for i = 1, #missions62 do
		for _, id in pairs(IDs) do
            if missions62[i].missionID == id then
				if id == 647 then
					PlaySoundFile("Interface\\AddOns\\GarrisonJK\\Sound\\黑市任务.ogg", "Master")
				    print("|cffff4500→注意! |r\124T632822:16\124t \124cff0070dd\124Hitem:127989:0:0:0:0:0:0:0:0:0:0:0\124h[浸水的账单]\124h\124r|cffff4500 6.2船坞黑市任务刷新了！|r")
				end
                break
            end
		end
    end
end

--9.0指挥台成就任务监控
if missions9 ~= nil then
    for i = 1, #missions9 do
		for _, id in pairs(IDs) do
            if missions9[i].missionID == id then
				PlaySoundFile("Interface\\AddOns\\GarrisonJK\\Sound\\9.0成就任务.ogg", "Master")
				if id == 2250 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[突破平原]|r刷新了！")
				elseif id == 2251 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[盖拉克的复仇]|r刷新了！")
				elseif id == 2252 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[凝团冥殇]|r刷新了！")
				elseif id == 2253 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[消灭巨人]|r刷新了！")					
				elseif id == 2254 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[阴暗天空，黑暗未来]|r刷新了！")				
				elseif id == 2255 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[德拉沃克的阴谋]|r刷新了！")					
				elseif id == 2256 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[豪华设计]|r刷新了！")
				elseif id == 2258 then
					print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[斩断丝线]|r刷新了！")			
				elseif id == 2259 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[绝望之影]|r刷新了！")	
				elseif id == 2260 then
				    print("|cffff4500→注意! |r 9.0指挥台成就任务：|cffffcd00[克雷拉，悲哀之翼]|r刷新了！")
                end
                break					
            end
		end
    end
end
end)