--## Author: ykiigor  ## SavedVariables: VLegionToDo
local LegionToDoVersion = "5.5"
local VERSION_NUMERIC = 55

local GetCurrentRegion
do
	local realmsDB = {	--1:US 2:EU 0:Other
		[500]=2,	[501]=2,	[502]=2,	[503]=2,	[504]=2,	[505]=2,
		[506]=2,	[507]=2,	[508]=2,	[509]=2,	[510]=2,	[511]=2,
		[512]=2,	[513]=2,	[515]=2,	[516]=2,	[517]=2,	[518]=2,
		[519]=2,	[521]=2,	[522]=2,	[523]=2,	[524]=2,	[525]=2,
		[526]=2,	[527]=2,	[528]=2,	[529]=2,	[531]=2,	[533]=2,
		[535]=2,	[536]=2,	[537]=2,	[538]=2,	[539]=2,	[540]=2,
		[541]=2,	[542]=2,	[543]=2,	[544]=2,	[545]=2,	[546]=2,
		[547]=2,	[548]=2,	[549]=2,	[550]=2,	[551]=2,	[552]=2,
		[553]=2,	[554]=2,	[556]=2,	[557]=2,	[558]=2,	[559]=2,
		[560]=2,	[561]=2,	[562]=2,	[563]=2,	[564]=2,	[565]=2,
		[566]=2,	[567]=2,	[568]=2,	[569]=2,	[570]=2,	[571]=2,
		[572]=2,	[573]=2,	[574]=2,	[575]=2,	[576]=2,	[577]=2,
		[578]=2,	[579]=2,	[580]=2,	[581]=2,	[582]=2,	[583]=2,
		[584]=2,	[585]=2,	[586]=2,	[587]=2,	[588]=2,	[589]=2,
		[590]=2,	[591]=2,	[592]=2,	[593]=2,	[594]=2,	[600]=2,
		[601]=2,	[602]=2,	[604]=2,	[605]=2,	[606]=2,	[607]=2,
		[608]=2,	[609]=2,	[610]=2,	[611]=2,	[612]=2,	[613]=2,
		[614]=2,	[615]=2,	[616]=2,	[617]=2,	[618]=2,	[619]=2,
		[621]=2,	[622]=2,	[623]=2,	[624]=2,	[625]=2,	[626]=2,
		[627]=2,	[628]=2,	[629]=2,	[630]=2,	[631]=2,	[632]=2,
		[633]=2,	[635]=2,	[636]=2,	[637]=2,	[638]=2,	[639]=2,
		[640]=2,	[641]=2,	[642]=2,	[643]=2,	[644]=2,	[645]=2,
		[646]=2,	[647]=2,	[1080]=2,	[1081]=2,	[1082]=2,	[1083]=2,
		[1084]=2,	[1085]=2,	[1086]=2,	[1087]=2,	[1088]=2,	[1089]=2,
		[1090]=2,	[1091]=2,	[1092]=2,	[1093]=2,	[1096]=2,	[1097]=2,
		[1098]=2,	[1099]=2,	[1104]=2,	[1105]=2,	[1106]=2,	[1117]=2,
		[1118]=2,	[1119]=2,	[1121]=2,	[1122]=2,	[1123]=2,	[1127]=2,
		[1298]=2,	[1299]=2,	[1300]=2,	[1301]=2,	[1303]=2,	[1304]=2,
		[1305]=2,	[1306]=2,	[1307]=2,	[1308]=2,	[1309]=2,	[1310]=2,
		[1311]=2,	[1312]=2,	[1313]=2,	[1314]=2,	[1316]=2,	[1317]=2,
		[1318]=2,	[1319]=2,	[1320]=2,	[1321]=2,	[1322]=2,	[1323]=2,
		[1324]=2,	[1326]=2,	[1327]=2,	[1328]=2,	[1330]=2,	[1331]=2,
		[1332]=2,	[1333]=2,	[1334]=2,	[1335]=2,	[1336]=2,	[1337]=2,
		[1378]=2,	[1379]=2,	[1380]=2,	[1381]=2,	[1382]=2,	[1383]=2,
		[1384]=2,	[1385]=2,	[1386]=2,	[1387]=2,	[1388]=2,	[1389]=2,
		[1391]=2,	[1392]=2,	[1393]=2,	[1394]=2,	[1395]=2,	[1400]=2,
		[1401]=2,	[1404]=2,	[1405]=2,	[1406]=2,	[1407]=2,	[1408]=2,
		[1409]=2,	[1413]=2,	[1415]=2,	[1416]=2,	[1417]=2,	[1587]=2,
		[1588]=2,	[1589]=2,	[1595]=2,	[1596]=2,	[1597]=2,	[1598]=2,
		[1602]=2,	[1603]=2,	[1604]=2,	[1605]=2,	[1606]=2,	[1607]=2,
		[1608]=2,	[1609]=2,	[1610]=2,	[1611]=2,	[1612]=2,	[1613]=2,
		[1614]=2,	[1615]=2,	[1616]=2,	[1617]=2,	[1618]=2,	[1619]=2,
		[1620]=2,	[1621]=2,	[1622]=2,	[1623]=2,	[1624]=2,	[1625]=2,
		[1626]=2,	[1922]=2,	[1923]=2,	[1924]=2,	[1925]=2,	[1926]=2,
		[1927]=2,	[1928]=2,	[1929]=2,
		[1]=1,	[2]=1,	[3]=1,	[4]=1,	[5]=1,	[6]=1,
		[7]=1,	[8]=1,	[9]=1,	[10]=1,	[11]=1,	[12]=1,
		[13]=1,	[14]=1,	[15]=1,	[16]=1,	[47]=1,	[51]=1,
		[52]=1,	[53]=1,	[54]=1,	[55]=1,	[56]=1,	[57]=1,
		[58]=1,	[59]=1,	[60]=1,	[61]=1,	[62]=1,	[63]=1,
		[64]=1,	[65]=1,	[66]=1,	[67]=1,	[68]=1,	[69]=1,
		[70]=1,	[71]=1,	[72]=1,	[73]=1,	[74]=1,	[75]=1,
		[76]=1,	[77]=1,	[78]=1,	[79]=1,	[80]=1,	[81]=1,
		[82]=1,	[83]=1,	[84]=1,	[85]=1,	[86]=1,	[87]=1,
		[88]=1,	[89]=1,	[90]=1,	[91]=1,	[92]=1,	[93]=1,
		[94]=1,	[95]=1,	[96]=1,	[97]=1,	[98]=1,	[99]=1,
		[100]=1,	[101]=1,	[102]=1,	[103]=1,	[104]=1,	[105]=1,
		[106]=1,	[107]=1,	[108]=1,	[109]=1,	[110]=1,	[111]=1,
		[112]=1,	[113]=1,	[114]=1,	[115]=1,	[116]=1,	[117]=1,
		[118]=1,	[119]=1,	[120]=1,	[121]=1,	[122]=1,	[123]=1,
		[124]=1,	[125]=1,	[126]=1,	[127]=1,	[128]=1,	[129]=1,
		[130]=1,	[131]=1,	[151]=1,	[153]=1,	[154]=1,	[155]=1,
		[156]=1,	[157]=1,	[158]=1,	[159]=1,	[160]=1,	[162]=1,
		[163]=1,	[164]=1,	[1067]=1,	[1068]=1,	[1069]=1,	[1070]=1,
		[1071]=1,	[1072]=1,	[1075]=1,	[1128]=1,	[1129]=1,	[1130]=1,
		[1131]=1,	[1132]=1,	[1136]=1,	[1137]=1,	[1138]=1,	[1139]=1,
		[1140]=1,	[1141]=1,	[1142]=1,	[1143]=1,	[1145]=1,	[1146]=1,
		[1147]=1,	[1148]=1,	[1151]=1,	[1154]=1,	[1165]=1,	[1173]=1,
		[1175]=1,	[1182]=1,	[1184]=1,	[1185]=1,	[1190]=1,	[1258]=1,
		[1259]=1,	[1260]=1,	[1262]=1,	[1263]=1,	[1264]=1,	[1265]=1,
		[1266]=1,	[1267]=1,	[1268]=1,	[1270]=1,	[1271]=1,	[1276]=1,
		[1277]=1,	[1278]=1,	[1280]=1,	[1282]=1,	[1283]=1,	[1284]=1,
		[1285]=1,	[1286]=1,	[1287]=1,	[1288]=1,	[1289]=1,	[1290]=1,
		[1291]=1,	[1292]=1,	[1293]=1,	[1294]=1,	[1295]=1,	[1296]=1,
		[1297]=1,	[1342]=1,	[1344]=1,	[1345]=1,	[1346]=1,	[1347]=1,
		[1348]=1,	[1349]=1,	[1350]=1,	[1351]=1,	[1352]=1,	[1353]=1,
		[1354]=1,	[1355]=1,	[1356]=1,	[1357]=1,	[1358]=1,	[1359]=1,
		[1360]=1,	[1361]=1,	[1362]=1,	[1363]=1,	[1364]=1,	[1365]=1,
		[1367]=1,	[1368]=1,	[1369]=1,	[1370]=1,	[1371]=1,	[1372]=1,
		[1373]=1,	[1374]=1,	[1375]=1,	[1377]=1,	[1425]=1,	[1427]=1,
		[1428]=1,	[1549]=1,	[1555]=1,	[1556]=1,	[1557]=1,	[1558]=1,
		[1559]=1,	[1563]=1,	[1564]=1,	[1565]=1,	[1566]=1,	[1567]=1,
		[1570]=1,	[1572]=1,	[1576]=1,	[1578]=1,	[1579]=1,	[1581]=1,
		[1582]=1,	[3207]=1,	[3208]=1,	[3209]=1,	[3210]=1,	[3234]=1,
		[3721]=1,	[3722]=1,	[3723]=1,	[3724]=1,	[3725]=1,	[3726]=1,
		[3733]=1,	[3734]=1,	[3735]=1,	[3736]=1,	[3737]=1,	[3738]=1,
	}
	local known = nil
	function GetCurrentRegion()
		if known then
			return known
		end
		local guid = UnitGUID("player")
		local _,serverID = strsplit("-",guid)
		local regionID = 0
		if serverID then
			regionID = realmsDB[tonumber(serverID) or -1] or 0
		end
		if regionID == 0 then
			local r = _G.GetCurrentRegion()
			if r == 3 then
				regionID = 2
			elseif r == 1 then
				regionID = 1
			end
		end
		known = regionID
		return regionID
	end
	
end

local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	if data then
		return data.name, data.quantity, data.iconFileID, data.quantityEarnedThisWeek, data.maxWeeklyQuantity, data.maxQuantity, data.discovered, data.quality
	end
end

local ToDoFunc = {}
_G.LegionToDo = {ToDoFunc = ToDoFunc,}

local inspectScantip = CreateFrame("GameTooltip", "LegToDoScanningTooltip", nil, "GameTooltipTemplate")
inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")

local isLevel48 = UnitLevel'player' <= 48
local isLevel50 = UnitLevel'player' <= 50
local isLevel60 = UnitLevel'player' > 50

local coinsQuests = UnitLevel'player' <= 40 and {[36058]=1,[36055]=1,[37452]=1,[37453]=1,[36056]=1,[37457]=1,[37456]=1,[36054]=1,[37455]=1,[37454]=1,[36057]=1,[37458]=1,[37459]=1,[36060]=1,} or
	isLevel48 and {[43895]=1,[43897]=1,[43896]=1,[43892]=1,[43893]=1,[43894]=1,[47851]=1,[47864]=1,[47865]=1,[43510]=1,} or
	{[52835]=1,[52834]=1,[52837]=1,[52840]=1,[52838]=1,[52839]=1,}
local coinsCurrency = UnitLevel'player' <= 40 and 1129 or isLevel48 and 1273 or 1580
	
tinsert(ToDoFunc,function(self,collect)
	local count = 0
	for id,_ in pairs(coinsQuests) do
		if C_QuestLog.IsQuestFlaggedCompleted(id) then
			count = count + 1
		end
	end
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(coinsCurrency)

	totalMax = totalMax ~= 0 and totalMax or (isLevel48 and 6 or 5)
	
	local coinsStr = format("|cff%s%d/%d [%d%s]",count==(isLevel48 and 3 or 2) and "00ff00" or (totalMax == amount and isDiscovered) and "ff8000" or "ff0000",count,isLevel48 and 3 or 2,amount or 0,totalMax == amount and isDiscovered and ",cap" or "")
	if not isLevel60 then
		self:AddDoubleLine("Coins", coinsStr,1,1,1)
		self:AddTexture(133858)
	end
	
	collect.coins = coinsStr
	collect.coinsNow = amount
	collect.coinsMax = totalMax
	collect.coinsWeek = count
	collect.coinsWeekMax = weeklyMax
end)

tinsert(ToDoFunc,function(self,collect)
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1220)
	if isLevel48 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(1397630)
	end
	collect.hallres = amount
	
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1560)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(2032600)
	end
	collect.hallres_bfa = amount

	
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1342)
	if isLevel48 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(803763)
	end
	collect.warsuppl = amount
	
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1226)
	if isLevel48 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(132775)
	end
	collect.nethershard = amount	

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1508)
	if isLevel48 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(1064188)	
	end
	collect.argunite = amount
	
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1533)
	if isLevel48 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(236521)	
	end
	collect.essence = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1166)
	collect.timewarped = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(UnitFactionGroup("player") ~= "Alliance" and 1716 or 1717)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(UnitFactionGroup("player") ~= "Alliance" and 2203914 or 2565243)
	end
	collect.service_medal = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1718)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(2065602)
	end
	collect.residuum = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1721)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(463858)
	end
	collect.manapearl = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1755)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(1003600)
	end
	collect.coalescing = amount

	local bottC = GetItemCount(173363,true)
	collect.coalescing_bott = bottC

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1719)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(646678)
	end
	collect.mementos = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1803)
	if isLevel50 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(3069889)
	end
	collect.echoon = amount


	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1767)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.stygia = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1828)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.soulash = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1813)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.anima = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1810)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.rsouls = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1792)
	collect.honor = amount

	local data = C_CurrencyInfo.GetCurrencyInfo(1191)
	if data then
		collect.valor = data.quantity
		collect.valorEarned = data.totalEarned
		collect.valorMax = data.maxQuantity

		self:AddDoubleLine(data.name, data.quantity, 1,1,1)
		self:AddTexture(data.iconFileID)
	else
		collect.valor = nil
		collect.valorEarned = nil
		collect.valorMax = nil
	end

	local data = C_CurrencyInfo.GetCurrencyInfo(1904)
	if data then
		collect.towerknowledge = data.quantity
		collect.towerknowledgeEarned = data.totalEarned
		collect.towerknowledgeMax = data.maxQuantity

		self:AddDoubleLine(data.name, data.quantity, 1,1,1)
		self:AddTexture(data.iconFileID)
	else
		collect.towerknowledge = nil
		collect.towerknowledgeEarned = nil
		collect.towerknowledgeMax = nil
	end

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1906)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.soulash91 = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1931)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.catalogedresearch = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1977)
	if isLevel60 then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.stygianember = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(2009)
	if isLevel60 and name then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.cosmicflux = amount

	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1979)
	if isLevel60 and name then
		self:AddDoubleLine(name, amount, 1,1,1)
		self:AddTexture(texturePath)
	end
	collect.cyphers = amount
end)

tinsert(ToDoFunc,function(self,collect)
	local covenantID = C_Covenants.GetActiveCovenantID()

	collect.cov = covenantID

	local soulbindID = C_Soulbinds.GetActiveSoulbindID()
	if soulbindID and soulbindID > 0 then
		local soulbindData = C_Soulbinds.GetSoulbindData(soulbindID)
		collect.cov_tree = soulbindData.name
	else
		collect.cov_tree = nil
	end

	local renown = C_CovenantSanctumUI.GetRenownLevel()
	collect.cov_renown = renown
end)

local days3val = 3 * 24 * 60 * 60
local days1val = 24 * 60 * 60
local witheredTrainingDay0 = 1468994400 + days1val * 2

tinsert(ToDoFunc,function(self,collect)
	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1155)
	local amanaStr = format("|cff%s%d/%d",amount==totalMax and "00ff00" or amount >=1300 and "ff8000" or "ff0000",amount,totalMax)
	if isLevel48 then
		self:AddDoubleLine(name, amanaStr,1,1,1)
		self:AddTexture(1377394)
	end
	
	collect.amana = amanaStr
	collect.amanaNow = amount
	collect.amanaMax = totalMax

	local isDone = C_QuestLog.IsQuestFlaggedCompleted(43943)
	if isLevel48 then
		self:AddDoubleLine("Withered Army Training:", isDone and "|cff00ff00Done" or "|cffff0000Not completed",1,1,1)
	end

	local wArmyDay0 = GetCurrentRegion() == 2 and witheredTrainingDay0 or (witheredTrainingDay0 + 8 * 3600)
	
	local diff = days3val - ((time() - wArmyDay0) % days3val)

	local strDiff = format("%dh %dm",(diff / 3600) % 24,(diff / 60) % 60)
	if diff >= days1val then
		strDiff = floor(diff / days1val).."d "..strDiff
	end
	if isLevel48 then
		self:AddDoubleLine("         Reset in",strDiff,1,1,1)
	end
	
	collect.wtraining = isDone
	collect.wtrainingweek = floor((time() - wArmyDay0) / days3val)
end)

tinsert(ToDoFunc,function(self,collect)
	local arguniteQuest = C_QuestLog.IsQuestFlaggedCompleted(48799)

	if not arguniteQuest then
		local isInLog = C_QuestLog.GetLogIndexForQuestID(48799)
		if isInLog and isInLog ~= 0 then
			local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(48799, 1, false)
			if numFulfilled and numRequired then
				collect.arguniteQuest = numFulfilled .. "/" .. numRequired
				if isLevel48 then
					self:AddDoubleLine("Argunite Quest:",collect.arguniteQuest,1,1,1)
				end
			end
		else
			collect.arguniteQuest = nil
		end
	else
		if isLevel48 then
			self:AddDoubleLine("Argunite Quest:","|cff00ff00Done",1,1,1)
		end
		collect.arguniteQuest = true
	end
	
	
	local riftQuest = C_QuestLog.IsQuestFlaggedCompleted(49293)

	if not riftQuest then
		local isInLog = C_QuestLog.GetLogIndexForQuestID(49293)
		if isInLog and isInLog ~= 0 then
			local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(49293, 1, false)
			if numFulfilled and numRequired then
				collect.riftQuest = numFulfilled .. "/" .. numRequired		
				if isLevel48 then
					self:AddDoubleLine("Rift Quest:",collect.riftQuest,1,1,1)
				end
			end
		else
			collect.riftQuest = nil
		end
	else
		if isLevel48 then
			self:AddDoubleLine("Rift Quest:","|cff00ff00Done",1,1,1)
		end
		collect.riftQuest = true
	end

	local recruitLvl1 = C_QuestLog.IsQuestFlaggedCompleted(48910)
	local recruitLvl2 = C_QuestLog.IsQuestFlaggedCompleted(48911)
	local recruitLvl3 = C_QuestLog.IsQuestFlaggedCompleted(48912)
	
	if isLevel48 then
		self:AddDoubleLine("Argus recruits:", (recruitLvl1 and "|cff00ff00+|r" or "|cffff0000-|r").."/"..(recruitLvl2 and "|cff00ff00+|r" or "|cffff0000-|r").."/"..(recruitLvl3 and "|cff00ff00+|r" or "|cffff0000-|r"),1,1,1)
	end
	
	collect.argusRecruit1 = recruitLvl1
	collect.argusRecruit2 = recruitLvl2
	collect.argusRecruit3 = recruitLvl3
end)

local visionQuestReward = {
      57841,"420",
      57845,"430",
      57842,"445",
      57846,"450",
      57843,"455",
      57847,"460",
      57844,"465",
      57848,"470"
}

local miniVisionQuests = {
	58168,
	58155,
	58151,
	58167,
	58156,
}
tinsert(ToDoFunc,function(self,collect)
	local isMiniVisionDone = false
	for i=1,#miniVisionQuests do
		if C_QuestLog.IsQuestFlaggedCompleted(miniVisionQuests[i]) then
			isMiniVisionDone = true
			break
		end
	end

	if isLevel50 then
		self:AddDoubleLine("Mini-Vision:", isMiniVisionDone and "|cff00ff00Done" or "|cffff0000Not completed",1,1,1)
	end
	collect.miniVision = isMiniVisionDone


	collect.visionReward = nil
	if isLevel50 then
		local minLvl
		for i=#visionQuestReward,1,-2 do
			if not C_QuestLog.IsQuestFlaggedCompleted(visionQuestReward[i-1]) then
				minLvl = visionQuestReward[i]
				break
			end
		end
		minLvl = minLvl or "all done"
		
		self:AddDoubleLine("Horrific vision current reward:",minLvl,1,1,1)

		collect.visionReward = minLvl
	end
end)


tinsert(ToDoFunc,function(self,collect)
	if isLevel48 then
		self:AddDoubleLine("Blingtron 6000", C_QuestLog.IsQuestFlaggedCompleted(40753) and "|cff00ff00Done" or "|cffff0000Not completed", 1,1,1)
	end
end)


tinsert(ToDoFunc,function(self,collect)
	local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	
	collect.island = nil
	if questID then
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			if isLevel50 then
				self:AddDoubleLine("Islands", "|cff00ff00Done", 1,1,1)
			end
			collect.island = "|cff00ff00Done"
		else
			local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
			if isLevel50 then
				self:AddDoubleLine("Islands", (numFulfilled or 0).."/"..(numRequired or 0), 1,1,1)
			end
			collect.island = (numFulfilled or 0).."/"..(numRequired or 0)
		end
	end


	local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1710)
	if isLevel50 then
		self:AddDoubleLine(name, amount,1,1,1)
		self:AddTexture(1604167)
	end
	
	collect.dublons = amount
end)

tinsert(ToDoFunc,function(self,collect)
	local questID = UnitFactionGroup("player") ~= "Alliance" and 53416 or 53414

	if C_QuestLog.IsQuestFlaggedCompleted(questID) then
		collect.warfront = true
	else
		collect.warfront = nil
	end

	if isLevel50 then
	--	self:AddDoubleLine("Warfront: Stromgarde", collect.warfront and "|cff00ff00Done" or "|cffff0000Not completed", 1,1,1)
	end

	--The Battle for Darkshore
	local questID = UnitFactionGroup("player") ~= "Alliance" and 53955 or 53992

	if C_QuestLog.IsQuestFlaggedCompleted(questID) then
		collect.warfront2 = true
	else
		collect.warfront2 = nil
	end

	if isLevel50 then
	--	self:AddDoubleLine("Warfront: Darkshore", collect.warfront2 and "|cff00ff00Done" or "|cffff0000Not completed", 1,1,1)
	end

	local questID = UnitFactionGroup("player") ~= "Alliance" and 56137 or 56136

	if C_QuestLog.IsQuestFlaggedCompleted(questID) then
		collect.warfrontHC = true
	else
		collect.warfrontHC = nil
	end

	if isLevel50 then
	--	self:AddDoubleLine("Warfront HC: Stromgarde", collect.warfrontHC and "|cff00ff00Done" or "|cffff0000Not completed", 1,1,1)
	end
end)



local garrison_mission_rewards = {
	[140171] = "mission_nh",
	[140174] = "mission_nh",
	[140178] = "mission_nh",
	[140181] = "mission_nh",
	[140147] = "mission_nh",
	[140151] = "mission_nh",
	[140149] = "mission_nh",
	[140153] = "mission_nh",
	[140180] = "mission_nh",
	[140173] = "mission_nh",
	[140177] = "mission_nh",
	[140183] = "mission_nh",
	[140472] = "mission_nh",
	[140172] = "mission_nh",
	[140175] = "mission_nh",
	[140182] = "mission_nh",
	
	[140163] = "mission_en",
	[140165] = "mission_en",
	[140167] = "mission_en",
	[140169] = "mission_en",
	[139480] = "mission_en",
	[139481] = "mission_en",
	[139482] = "mission_en",
	[139483] = "mission_en",
	[140164] = "mission_en",
	[140166] = "mission_en",
	[140168] = "mission_en",
	[140170] = "mission_en",

	[147497] = "mission_tos",
	[147498] = "mission_tos",
	[147499] = "mission_tos",
	[147500] = "mission_tos",
	[147501] = "mission_tos",
	[147502] = "mission_tos",
	[147503] = "mission_tos",
	[147504] = "mission_tos",
	[147505] = "mission_tos",
	[147506] = "mission_tos",
	[147507] = "mission_tos",
	[147508] = "mission_tos",
	[147509] = "mission_tos",
	[147510] = "mission_tos",
	[147511] = "mission_tos",
	[147512] = "mission_tos",
	
	[139479] = "mission_5ppl_amk",
	[141185] = "mission_5ppl_amk",
	[141186] = "mission_5ppl_amk",
	
	[139478] = "mission_5ppl_kaze",
	[141187] = "mission_5ppl_kaze",
	[141188] = "mission_5ppl_kaze",
	
	[139476] = "mission_5ppl_nelt",
	[141191] = "mission_5ppl_nelt",
	[141192] = "mission_5ppl_nelt",

	[139474] = "mission_5ppl_eye",
	[141197] = "mission_5ppl_eye",
	[141198] = "mission_5ppl_eye",

	[139475] = "mission_5ppl_maw",
	[141193] = "mission_5ppl_maw",
	[141194] = "mission_5ppl_maw",

	[139473] = "mission_5ppl_dht",
	[141199] = "mission_5ppl_dht",
	[141200] = "mission_5ppl_dht",

	[139457] = "mission_5ppl_halls",
	[141195] = "mission_5ppl_halls",
	[141196] = "mission_5ppl_halls",

	[139471] = "mission_5ppl_brh",
	[141203] = "mission_5ppl_brh",
	[141204] = "mission_5ppl_brh",

	[139477] = "mission_5ppl_suramar",
	[141190] = "mission_5ppl_suramar",

	[139472] = "mission_5ppl_cos",
	[141202] = "mission_5ppl_cos",

	[142340] = "mission_5ppl_kara",	
	
	[152313] = "mission_abt",
	[152314] = "mission_abt",
	[152315] = "mission_abt",
	[152316] = "mission_abt",
	[152317] = "mission_abt",
	[152318] = "mission_abt",
	[152319] = "mission_abt",
	[152320] = "mission_abt",
	[152321] = "mission_abt",
	[152322] = "mission_abt",
	[152323] = "mission_abt",
	[152324] = "mission_abt",
	[152325] = "mission_abt",
	[152326] = "mission_abt",
	[152327] = "mission_abt",
	[152328] = "mission_abt",
	
}

tinsert(ToDoFunc,function(self,collect)
	local curr = time()
	
	local active_en, active_nh, active_tos, active_abt
	
	local currentMissions = C_Garrison.GetAvailableMissions(Enum.GarrisonFollowerType.FollowerType_7_0)
	
	if currentMissions then
		for i=1,#currentMissions do
			local rewards = currentMissions[i].rewards
			
			if rewards then
				for j=1,#rewards do
					if rewards[j].itemID then
						local missionType = garrison_mission_rewards[ rewards[j].itemID ]
						if missionType then
							if currentMissions[i].offerEndTime then
								collect.s[missionType] = currentMissions[i].offerEndTime - GetTime() + curr - 10 * 24 * 60 * 60
							end
							if missionType == "mission_en" then
								active_en = true
							elseif missionType == "mission_nh" then
								active_nh = true
							elseif missionType == "mission_tos" then
								--collect.s[missionType] = collect.s[missionType] + 7 * 24 * 60 * 60
								active_tos = true
							elseif missionType == "mission_abt" then
								active_abt = true
							elseif missionType:find("5ppl") then
								collect.s[missionType] = collect.s[missionType] + 7 * 24 * 60 * 60
							end
							break
						end
					end 
				
				end
			end
		end
	end
	
	local mission_en = collect.s.mission_en
	if mission_en then
		while mission_en < curr do
			mission_en = mission_en + (13 * 24 * 60 * 60)
		end
	
		--self:AddDoubleLine("EN Garrison Mission", date("%d.%m.%Y %H:%M",mission_en), 1,1,1,active_en and 0 or 1,1,active_en and 0 or 1)
	end
	
	local mission_nh = collect.s.mission_nh
	if mission_nh then
		while mission_nh < curr do
			mission_nh = mission_nh + (13 * 24 * 60 * 60)
		end
	
		--self:AddDoubleLine("NH Garrison Mission", date("%d.%m.%Y %H:%M",mission_nh), 1,1,1,active_nh and 0 or 1,1,active_nh and 0 or 1)
	end
	
	local mission_tos = collect.s.mission_tos
	if mission_tos then
		while mission_tos < curr do
			mission_tos = mission_tos + (13 * 24 * 60 * 60)
		end
	
		--self:AddDoubleLine("ToS Garrison Mission", date("%d.%m.%Y %H:%M",mission_tos), 1,1,1,active_tos and 0 or 1,1,active_tos and 0 or 1)
	end
	
	local mission_abt = collect.s.mission_abt
	if mission_abt then
		while mission_abt < curr do
			mission_abt = mission_abt + (13 * 24 * 60 * 60)
		end
	
		--self:AddDoubleLine("ABT Garrison Mission", date("%d.%m.%Y %H:%M",mission_abt), 1,1,1,active_abt and 0 or 1,1,active_abt and 0 or 1)
	end
	
	--[[
	for missionType,missionTime in pairs(collect.s) do
		if type(missionType)=='string' and missionType:find("5ppl") then
			self:AddDoubleLine(missionType, date("%d.%m.%Y %H:%M",missionTime), 1,1,1,1,1,1)
		end
	end
	]]
end)


tinsert(ToDoFunc,function(self,collect)
	local curr = time()
	
	local currentMissions = C_Garrison.GetAvailableMissions(Enum.GarrisonFollowerType.FollowerType_9_0)
	
	if currentMissions then
		for i=1,#currentMissions do
			if currentMissions[i].missionID == 2250 then
				if currentMissions[i].offerEndTime then
					collect.s.ashmission = currentMissions[i].offerEndTime - GetTime() + curr - 2 * 24 * 60 * 60

				end
			end
		end
	end

	local ashmission = collect.s.ashmission
	if ashmission then
		while ashmission < curr do
			ashmission = ashmission + (3 * 24 * 60 * 60)
		end

		--self:AddDoubleLine("Next Ash mission", date("%d.%m.%Y %H:%M",ashmission), 1,1,1,1,1,1)
	end
end)


--ELib:Frame(UIParent):SetScript('OnUpdate',function()local q=GetMouseFocus()if not q or not q.link then DInfo'nil' return end DInfo(q.link:gsub("\124","I"))end)
local instances = {
	707,740,767,716,727,762,721,777,726,800,860,900,945,
	968,1001,1041,1036,1023,1030,1012,1022,1002,1021, 1178,
	1188,1185,1184,1183,1189,1186,1182,1187,	1194,
}
local instancesInOptions = {
	1,2,3,4,5,6,7,8,9,10,11,12,13,
	14,15,16,17,18,19,20,21,22,23, 24,
	25,26,27,28,29,30,31,32,	33,
}
local instancesLastBoss = {}
local instancesAttune = {
	--[10] = 44053,
	--[9] = 44053,
}
local instancesShowStatus = {
	isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,isLevel48,
	isLevel50,isLevel50,isLevel50,isLevel50,isLevel50,isLevel50,isLevel50,isLevel50,isLevel50,isLevel50, isLevel50,
	isLevel60,isLevel60,isLevel60,isLevel60,isLevel60,isLevel60,isLevel60,isLevel60,	isLevel60,
}
local instancesMaxBossesFix = {
	[18] = 4,
}


for i=1,#instances do
	instances[i] = EJ_GetInstanceInfo(instances[i])
end

local function IsInArray(arr,subj)
	for i=1,#arr do
		if arr[i]==subj then
			return i
		end
	end
end
local function IsInArray2(arr,subj)
	for i=1,#arr do
		if subj:find("^"..arr[i]) then
			return i
		end
	end
end

tinsert(ToDoFunc,function(self,collect)
	local res = {}
	for i=1,GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses = GetSavedInstanceInfo(i)
	
		if instanceDifficulty == 23 then
			local inArr = IsInArray(instances,instanceName)
			if inArr then
				defeatedBosses = locked and defeatedBosses or 0

				if instancesMaxBossesFix[inArr] then
					totalBosses = instancesMaxBossesFix[inArr]
				end
				
				local _,_,lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
				if defeatedBosses == 0 and lastBossDefeated then
					lastBossDefeated = false
				end
				
				res[inArr] = format("|cff%s%d/%d",totalBosses==defeatedBosses and "00ff00" or lastBossDefeated and "ffff00" or "ff0000",defeatedBosses,totalBosses)
			end
		end
	end
	--self:AddLine("Mythic:")
	for i=1,#instances do
		if instancesShowStatus[i] then
			if instancesAttune[i] and not res[i] and not C_QuestLog.IsQuestFlaggedCompleted(instancesAttune[i]) then
	--			self:AddDoubleLine(instances[i], "|cffff0000Locked",1,1,1)
				collect["instance"..i] = "|cffff0000Locked"
			else
	--			self:AddDoubleLine(instances[i], res[i] or "|cffff0000---",1,1,1)
				collect["instance"..i] = res[i] or "|cffff0000---"
			end
		end
	end
end)


local mythicPlusMaps = C_ChallengeMode.GetMapTable()
tinsert(ToDoFunc,function(self,collect)
	C_MythicPlus.RequestRewards()
	--[[
	C_MythicPlus.RequestMapInfo()
	for i=1,#mythicPlusMaps do
		--local _, _, level, affixes = C_ChallengeMode.GetMapPlayerStats(mythicPlusMaps[i])
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mythicPlusMaps[i])
		if level and level > max then
			max = level
		end
	end
	]]

	local max = C_MythicPlus.GetWeeklyChestRewardLevel() or 0

	self:AddDoubleLine("Weekly max mythic+", max,1,1,1)
	collect["weeklymax"] = max	
end)


local raids = {
	768,861,786,875,946,
	1031,1176,1177,
	1179,
	1180,
	1190,
	1193,
	1195,
}
local raids_max_bosses = {
	7,3,10,9,11,
	8,9,2,
	8,
	12,
	10,
	10,
	11,
}

for i=1,#raids do
	raids[i] = EJ_GetInstanceInfo(raids[i])
end
local raidsDiffs = {
	14,15,16,
}
local raidsDiffsNames = {
	PLAYER_DIFFICULTY1,PLAYER_DIFFICULTY2,PLAYER_DIFFICULTY6,
}

local LFRInstances = {
	{ 1287,1288,1289 }, --EN
	{ 1411 }, -- ToV
	{ 1290,1291,1292,1293 }, -- NH
	{ 1494,1495,1496,1497 }, --ToS
	{ 1610,1611,1612,1613 }, --ABT
	{ 1731,1732,1733 },	--Uldir
	{ UnitFactionGroup("player") ~= "Alliance" and 1948 or 1945,UnitFactionGroup("player") ~= "Alliance" and 1946 or 1949,UnitFactionGroup("player") ~= "Alliance" and 1947 or 1950}, --BfD
	{ 1951 },	--CoS
	{ 2014,2015,2016 },	--EP
	{ 2036,2037,2038,2039 }, --Nyalotha
	{ 2090,2091,2092,2096 }, --Castle Nathria
	{ 2221,2222,2223,2224 }, --SoD
	{ 2291,2292,2293,2294 },	--SotFO
}
local LFRInstancesShowStatus = {
	isLevel48, isLevel48, isLevel48, isLevel48, isLevel48, 
	isLevel50, isLevel50, isLevel50,
	isLevel50,
	isLevel50,
	isLevel60,
	isLevel60,
	isLevel60,
}
local raidToHide = {
	true,true,true,false,false,
	true,true,true,
	true,
	false,
	true,
	true,
	false,
}

tinsert(ToDoFunc,function(self,collect)
	local res = {}
	for i=1,GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses = GetSavedInstanceInfo(i)
	
		if instanceDifficulty and IsInArray(raidsDiffs,instanceDifficulty) then
			local inArr = IsInArray(raids,instanceName) or IsInArray2(raids,instanceName)
			if inArr then
				defeatedBosses = (locked or extended) and defeatedBosses or 0
								
				res[inArr] = res[inArr] or {}
				res[inArr][instanceDifficulty] = {defeatedBosses}
				
				for j=1,(totalBosses or 0) do
					local bossName,unk,isDefeated = GetSavedInstanceEncounterInfo(i,j)
					res[inArr][instanceDifficulty][j*2] = bossName
					res[inArr][instanceDifficulty][j*2+1] = (locked or extended) and isDefeated
				end
			end
		end
	end
	
	self:AddLine("Raids:")
	for i=1,#raids do
		if LFRInstances[i] then
			local def = 0
			local str = ""
			for j=1,#LFRInstances[i] do
				local wingID = LFRInstances[i][j]
				local totalEncounters, encountersCompleted = GetLFGDungeonNumEncounters(wingID) --lfr
				
				totalEncounters = totalEncounters or 0
				encountersCompleted = encountersCompleted or 0
				
				collect["raid"..i.."_lfr_"..j.."d"] = encountersCompleted
				collect["raid"..i.."_lfr_"..j.."m"] = totalEncounters
				
				def = def + encountersCompleted
				
				str = str .. (str ~= "" and "/" or "") .. (encountersCompleted == totalEncounters and "|cff00ff00" or encountersCompleted > 0 and "|cffffff00" or "|cffff0000") .. encountersCompleted .. "|r"
			end
			if LFRInstancesShowStatus[i] and not raidToHide[i] then
				self:AddDoubleLine(raids[i].." "..PLAYER_DIFFICULTY3, str .. " ["..def.."]",1,1,1)
			end
			collect["raid"..i.."_lfr"] = def
		end
		for j=1,#raidsDiffs do
			if res[i] and res[i][ raidsDiffs[j] ] then
				local defeatedBosses = res[i][ raidsDiffs[j] ][1]
				if LFRInstancesShowStatus[i] and not raidToHide[i] then
					self:AddDoubleLine(raids[i].." "..raidsDiffsNames[j], format("|cff%s%d/%d",raids_max_bosses[i]==defeatedBosses and "00ff00" or "ff0000",defeatedBosses,raids_max_bosses[i]) ,1,1,1)
				end
				collect["raid"..i.."_"..j] = defeatedBosses
				for k=1,raids_max_bosses[i] do
					if defeatedBosses == 0 then
						collect["raid"..i.."_"..j.."_b"..k.."_n"] = nil
						collect["raid"..i.."_"..j.."_b"..k.."_s"] = nil					
					else
						collect["raid"..i.."_"..j.."_b"..k.."_n"] = res[i][ raidsDiffs[j] ][k*2]
						collect["raid"..i.."_"..j.."_b"..k.."_s"] = res[i][ raidsDiffs[j] ][k*2+1]
					end
				end
			else
				if LFRInstancesShowStatus[i] and not raidToHide[i] then
					self:AddDoubleLine(raids[i].." "..raidsDiffsNames[j], "|cffff0000---",1,1,1)
				end
				collect["raid"..i.."_"..j] = 0
				for k=1,raids_max_bosses[i] do
					collect["raid"..i.."_"..j.."_b"..k.."_n"] = nil
					collect["raid"..i.."_"..j.."_b"..k.."_s"] = nil
				end
			end
		end
	end
end)


tinsert(ToDoFunc,function(self,collect)
	if isLevel60 then
		return
	end
	local bounties,_,lockedType = C_QuestLog.GetBountiesForMapID(isLevel48 and 619 or 875)
	
	if lockedType then
		if not isLevel60 then
			self:AddDoubleLine("Bounty", "Quest not completed",nil,nil,nil,1,0,0)
		end
		return	
	elseif not bounties or #bounties == 0 then
		if not isLevel60 then
			self:AddDoubleLine("Bounty", "Done",nil,nil,nil,0,1,0)
		end
		return
	end
	if not isLevel60 then
		self:AddLine("Bounty:")
	end
	
	for i=1,#bounties do
		local d = bounties[i]
		local factionName = GetFactionInfoByID(d.factionID)
		
		local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
		if questIndex > 0 then
			local questData = C_QuestLog.GetInfo(questIndex)
			if questData and questData.title then
				factionName = questData.title
			end
		end
		
		local currQ, maxQ = 0,0
		
		for objectiveIndex = 1, d.numObjectives do
			local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(d.questID, objectiveIndex, false)
			
			currQ = numFulfilled or 0
			maxQ = numRequired or 0
		end
		local fNameStr1 = "|T"..d.icon..":0|t "
		local fNameStr = fNameStr1..(factionName or "")
		local bountyStr = format("|cff%s%d/%d",currQ==maxQ and "00ff00" or "ff0000",currQ,maxQ)
		if not isLevel60 then
			self:AddDoubleLine(fNameStr, bountyStr,1,1,1)
		end
		
		local diff = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
	
		if diff then
			local strDiff = format("%dh %dm",(diff / 60) % 24,diff % 60)
			if diff >= 1440 then
				strDiff = floor(diff / 1440).."d "..strDiff
			end
		
			if not isLevel60 then
				self:AddDoubleLine("         Reset in",strDiff,1,1,1)
			end
		
			collect.s["bounty"..i] = fNameStr1.." "..bountyStr
			collect.s["bounty"..i.."end"] = time() + diff * 60
		end
	end
end)

local function calling_sort(a,b)
	return (C_TaskQuest.GetQuestTimeLeftMinutes(a.questID or 0) or 0) < (C_TaskQuest.GetQuestTimeLeftMinutes(b.questID or 0) or 0)
end

local CallingsUpdater = CreateFrame("Frame")
CallingsUpdater:SetScript("OnEvent", function(self, event, ...)
	if event == "COVENANT_CALLINGS_UPDATED" and self.collect then
		local calling = ...
		if calling then
			self.collect.s.bounty1 = nil
			self.collect.s.bounty2 = nil
			self.collect.s.bounty3 = nil

			sort(calling,calling_sort)
			for i=1,#calling do
				local d = calling[i]
				
				local currQ, maxQ = 0,0
				
				for objectiveIndex = 1, d.numObjectives do
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(d.questID, objectiveIndex, false)
					
					currQ = numFulfilled or 0
					maxQ = numRequired or 0

					if objectiveType == "progressbar" then
						currQ = finished and 100 or GetQuestProgressBarPercent(d.questID) or 0
						maxQ = 100
					end

					if not numRequired then
						currQ, maxQ = 0, 1
					end
				end
				local fNameStr1 = "|T"..d.icon..":0|t "
				local fNameStr = fNameStr1..(factionName or "")
				local bountyStr = format("|cff%s%d/%d",currQ==maxQ and "00ff00" or "ff0000",currQ,maxQ)

				
				local diff = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			
				self.collect.s["bounty"..i] = fNameStr1.." "..bountyStr
				if diff then
					self.collect.s["bounty"..i.."end"] = time() + diff * 60
					self.collect.s["bounty"..i.."notime"] = false
				else
					self.collect.s["bounty"..i.."end"] = time() + (3 * 24 * 60 * 60) * 60
					self.collect.s["bounty"..i.."notime"] = true
				end

				self.collect.s["bounty"..i.."name"] = nil
				self.collect.s["bounty"..i.."id"] = d.questID

				local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
				if questIndex and questIndex ~= 0 then
					local questLogData = C_QuestLog.GetInfo(questIndex)
					if questLogData then
						self.collect.s["bounty"..i.."name"] = questLogData.title
					end
				end
			end
		end
	end
end)
if isLevel60 then
	CallingsUpdater:RegisterEvent("COVENANT_CALLINGS_UPDATED")
end

local CallingsPrev = 0
tinsert(ToDoFunc,function(self,collect)
	if not isLevel60 then
		return
	end
	local now = GetTime()
	if not CallingsPrev or now - CallingsPrev > 1 then
		CallingsPrev = now
		CallingsUpdater.collect = collect
		--collect.bounty1 = nil
		--collect.bounty2 = nil
		--collect.bounty3 = nil
		C_CovenantCallings.RequestCallings()
	end
end)


local function formatAzeriteNum(num)
	if num < 5000 then
		return tostring(num)
	elseif num < 100000 then
		return format("%.1fk",num/1000)
	elseif num < 1000000 then
		return format("%dk",num/1000)
	else
		return format("%.2fm",num/1000000)
	end
end

tinsert(ToDoFunc,function(self,collect)
	collect.artifact = nil
	
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		
	collect.azerite = nil
	if azeriteItemLocation then 			
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation); 
		
		if totalLevelXP and totalLevelXP ~= 0 then
			collect.azerite = "|cffff0000"..currentLevel .. "|r|n|cff888888("..floor(xp / totalLevelXP * 100).."%, -"..formatAzeriteNum(totalLevelXP - xp)..")"
		end
	end
end)


tinsert(ToDoFunc,function(self,collect)
	local rewardCounter = 1
	while collect["sl_reward"..rewardCounter] do
		collect["sl_reward"..rewardCounter] = nil
		rewardCounter = rewardCounter + 1
	end
	rewardCounter = 1
	while collect["sl_reward"..rewardCounter.."_progress"] do
		collect["sl_reward"..rewardCounter.."_progress"] = nil
		rewardCounter = rewardCounter + 1
	end
	rewardCounter = 1
	local rewardCounterProgress = 1
	local data = C_WeeklyRewards.GetActivities()
	for i=1,#data do
		local activityInfo = data[i]
		if (activityInfo.progress >= activityInfo.threshold) or (activityInfo.progress > 0) then
			local ilvl = nil
			if activityInfo.id then
				local itemLink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id)
				if itemLink and itemLink ~= "" then
					ilvl = select(4,GetItemInfo(itemLink))
				end
			end

			local isDone = activityInfo.progress >= activityInfo.threshold
			local colorStr = isDone and "|cff00ff00" or "|cffff0000"

			if activityInfo.type == Enum.WeeklyRewardChestThresholdType.Raid then
				local name = DifficultyUtil.GetDifficultyName(activityInfo.level)
				local key = isDone and "sl_reward"..rewardCounter or "sl_reward"..rewardCounterProgress.."_progress"
				collect[key] = colorStr.."Raid "..(name or "")..(ilvl and " ilvl:"..ilvl or "")..format(" %d/%d",min(activityInfo.progress,activityInfo.threshold),activityInfo.threshold)
				if activityInfo.progress >= activityInfo.threshold then
					rewardCounter = rewardCounter + 1
				else
					rewardCounterProgress = rewardCounterProgress + 1
				end
			elseif activityInfo.type == Enum.WeeklyRewardChestThresholdType.MythicPlus then
				local key = isDone and "sl_reward"..rewardCounter or "sl_reward"..rewardCounterProgress.."_progress"
				collect[key] = colorStr.."M+ "..format(WEEKLY_REWARDS_MYTHIC, activityInfo.level)..(ilvl and " ilvl:"..ilvl or "")..format(" %d/%d",min(activityInfo.progress,activityInfo.threshold),activityInfo.threshold)
				if activityInfo.progress >= activityInfo.threshold then
					rewardCounter = rewardCounter + 1
				else
					rewardCounterProgress = rewardCounterProgress + 1
				end
			elseif activityInfo.type == Enum.WeeklyRewardChestThresholdType.RankedPvP then
				local key = isDone and "sl_reward"..rewardCounter or "sl_reward"..rewardCounterProgress.."_progress"
				collect[key] = colorStr.."PvP "..(PVPUtil.GetTierName(activityInfo.level) or "")..(ilvl and " ilvl:"..ilvl or "")..format(" %d/%d",min(activityInfo.progress,activityInfo.threshold),activityInfo.threshold)
				if activityInfo.progress >= activityInfo.threshold then
					rewardCounter = rewardCounter + 1
				else
					rewardCounterProgress = rewardCounterProgress + 1
				end
			end
		end
	end
	collect.sl_rewardMax = #data
end)




tinsert(ToDoFunc,function(self,collect)

	local key = nil
	for bag=0,5 do
		for slot=1,36 do
			local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue = GetContainerItemInfo(bag, slot)

			if itemLink and (itemLink:find("item:138019") or itemLink:find("keystone:") or itemLink:find("item:158923") or itemLink:find("item:180653")) then
				local deep = false
			
				inspectScantip:SetBagItem(bag, slot)
				if inspectScantip:NumLines() > 0 then
					local name = _G["LegToDoScanningTooltipTextLeft1"]:GetText()
					name = name:gsub("^[^:]+: ","")
					if name:find("Каражан") then
						name = name:gsub("^[^:]+: ","Кара: ")
					elseif name:find("Мехагон") then
						name = name:gsub("^[^ ]+ ","")
					end

					local _,_,dungeon,lvl,expire = strsplit(":", itemLink)

					key = lvl .. ": " ..name
				end
				inspectScantip:ClearLines()
			end
		end
	end	
	
	self:AddDoubleLine("Key", key or "---")
	collect.mkey = key
end)

tinsert(ToDoFunc,function(self,collect)
	collect.cloak_res = nil

	local itemLink = GetInventoryItemLink("player", 15)

	if itemLink and itemLink:find("item:169223:") then
		inspectScantip:SetInventoryItem("player", 15)
		if inspectScantip:NumLines() > 0 then
			for j=2, inspectScantip:NumLines() do
				local text = _G["LegToDoScanningTooltipTextLeft"..j]:GetText()
				if text and text ~= "" then
					local res = text:gsub("[,]",""):gsub("(%d+)[ ]+(%d+)","%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")

					if res then
						collect.cloak_res = res
						break
					end
				end
			end
		end
		inspectScantip:ClearLines()
	end
end)


tinsert(ToDoFunc,function(self,collect)
	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
	
	local ilvlStr = format("|cff%s%.1f|r",avgItemLevelEquipped >= 213 and "00ff00" or avgItemLevelEquipped >= 200 and "ffff00" or "ff0000",avgItemLevelEquipped)

	collect.ilvl = ilvlStr
	self:AddDoubleLine("iLvl", ilvlStr,nil,nil,nil,1,1,1)
end)


local firstInvasionEU = 1491375600
local firstInvasionUS = 1491404400
tinsert(ToDoFunc,function(self,collect)
	local curr = time()
	local next = GetCurrentRegion() == 2 and firstInvasionEU or firstInvasionUS
	
	while curr > next do
		next = next + 60 * 60 * 18.5
	end
	if isLevel48 then 
		self:AddDoubleLine("Next Invasion", date("%d.%m.%Y %H:%M",next),nil,nil,nil,1,1,1)
	end
end)

tinsert(ToDoFunc,function(self,collect)
	collect.gold = GetMoney()
	
	local blood = GetItemCount(124124,true)
	collect.blood = blood or 0
	
	collect.warmode = C_PvP.IsWarModeDesired()
end)


local factionsToWatch = {
	2165,
	2170,
	2045,
	1859,
	1894,
	1948,
	1828,
	1883,
	1900,

	2164,
	2163,
	2157,
	2156,
	2103,
	2158,

	2159,
	2160,
	2162,
	2161,

	2391,
	2400,
	2373,

	2415,
	2417,

	2465,
	2410,
	2413,
	2407,

	2432,

	2470,
	2472,

	2478,
}

tinsert(ToDoFunc,function(self,collect)
	for i=1,#factionsToWatch do
		local factionID = factionsToWatch[i]
		local isAdded = false
		if C_Reputation.IsFactionParagon(factionID) then
			local currentValue, threshold, rewardQuestID, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
			
			if currentValue then
				collect["reputation"..factionID.."c"] = mod(currentValue,threshold) + (hasRewardPending and threshold or 0)
				collect["reputation"..factionID.."m"] = threshold
				collect["reputation"..factionID.."p"] = true
				collect["reputation"..factionID.."e"] = nil
				
				isAdded = true
			end
		else
			local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, _, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(factionID)

			if barMin then
				if barMin < 0 then
					barMin, barMax = barMax, barMin
				end
			
				collect["reputation"..factionID.."c"] = barValue - barMin
				collect["reputation"..factionID.."m"] = barMax - barMin
				collect["reputation"..factionID.."p"] = false

				if barValue == 42000 then
					collect["reputation"..factionID.."c"] = 999
					collect["reputation"..factionID.."m"] = 999
				end

				if (factionID == 2432 and (standingID <= 4)) or factionID == 2472 then
					collect["reputation"..factionID.."e"] = standingID
				else
					collect["reputation"..factionID.."e"] = nil
				end
				
				isAdded = true
			end
		end
		if not isAdded then
			collect["reputation"..factionID.."c"] = nil
			collect["reputation"..factionID.."m"] = nil
			collect["reputation"..factionID.."p"] = nil
			collect["reputation"..factionID.."c"] = nil
		end
	end
end)


tinsert(ToDoFunc,function(self,collect)
	local CONQUEST_QUESTLINE_ID = 782;
	local currentQuestID = QuestUtils_GetCurrentQuestLineQuest(CONQUEST_QUESTLINE_ID);
	
	local conq = nil
	if currentQuestID ~= 0 and HaveQuestData(currentQuestID) then
		local objectives = C_QuestLog.GetQuestObjectives(currentQuestID)
		if objectives and objectives[1] then
			conq = objectives[1].numFulfilled .. "/" .. objectives[1].numRequired
		end
	else
		local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(1602)
		conq = amount
	end
	collect.conq = conq

	local rewardAchieved, lastWeekRewardAchieved, lastWeekRewardClaimed, pvpTierMaxFromWins = C_PvP.GetWeeklyChestInfo()
	collect.pvp_cache = rewardAchieved	
end)



tinsert(ToDoFunc,function(self,collect)
	local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()

	local str = nil
	for i=1,2 do
		local prof = (i == 1 and prof1) or (i == 2 and prof2)
		if prof then
			local name, texture, rank, maxRank, numSpells, spelloffset, skillLine, rankModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof)
	
			if name then
				str = (str or "")..(str and str ~= "" and " / " or "").."|T"..texture..":0|t"
				collect["prof"..i.."_name"] = name
			else
				collect["prof"..i.."_name"] = nil
			end
		else
			collect["prof"..i.."_name"] = nil
		end
	end
	collect.prof = str
end)


tinsert(ToDoFunc,function(self,collect)
	collect.cloak_lvl = nil

	local itemLink = GetInventoryItemLink("player",15)
	if itemLink then
		local itemID = itemLink:match("item:(%d+)")
		if itemID == "169223" then
			local ilvl = select(4,GetItemInfo(itemLink))
			if ilvl then
				collect.cloak_lvl = min(15, max((ilvl - 125) / 2 + 1, 1))
			end
		end
	end
end)

tinsert(ToDoFunc,function(self,collect)
	if C_QuestLog.IsQuestFlaggedCompleted(64347) then
		collect.torghastav = true
	else
		collect.torghastav = nil
	end

	local torghast1 = nil
	local torghast2 = nil

	collect.torghast1 = torghast1
	collect.torghast2 = torghast2

	local pois = C_AreaPoiInfo.GetAreaPOIForMap(1543) or {}
	for i=1,#pois do
		local poiID = pois[i]
		local poiData = C_AreaPoiInfo.GetAreaPOIInfo(1543,poiID)
		if poiData and poiData.atlasName == "poi-torghast" then
			local widgetSetID = poiData.widgetSetID
			if widgetSetID then
				local lines = {}

				local setWidgets = C_UIWidgetManager.GetAllWidgetsBySetID(widgetSetID)
				for _, widgetInfo in ipairs(setWidgets) do
					local widgetTypeInfo = UIWidgetManager:GetWidgetTypeInfo(widgetInfo.widgetType)
					if widgetTypeInfo then
						local subWidgetInfo = widgetTypeInfo.visInfoDataFunction(widgetInfo.widgetID)
						if subWidgetInfo then
							lines[#lines+1] = {subWidgetInfo.text:trim():gsub("|[nr]",""):gsub("|c........",""), subWidgetInfo.orderIndex}
						end
					end
				end

				sort(lines,function(a,b)return a[2]<b[2] end)
				for i=1,#lines,2 do
					local floorName = lines[i][1]
					local def = lines[i+1][1]:match("%d+")
					if not def then 
						def = 0 
					else
						def = tonumber(def)
					end
					if torghast1 then
						torghast2 = (def==12 and "|cff00ff00" or def==0 and "|cffff0000" or "|cffffff00")..tostring(def).."/12" .. " " .. floorName
						break
					else
						torghast1 = (def==12 and "|cff00ff00" or def==0 and "|cffff0000" or "|cffffff00")..tostring(def).."/12" .. " " .. floorName
					end
				end
			end
			break
		end
	end

	collect.torghast1 = torghast1
	collect.torghast2 = torghast2
end)


tinsert(ToDoFunc,function(self,collect)
	if C_QuestLog.IsQuestFlaggedCompleted(63414) then
		collect.wrathofthejailer = true
	else
		collect.wrathofthejailer = nil
	end

	if 
		C_QuestLog.IsQuestFlaggedCompleted(63180) or 
		C_QuestLog.IsQuestFlaggedCompleted(63194) or 
		C_QuestLog.IsQuestFlaggedCompleted(63198) or C_QuestLog.IsQuestFlaggedCompleted(63196) or
		C_QuestLog.IsQuestFlaggedCompleted(63199)
	then
		collect.mawhunt = true
	else
		collect.mawhunt = nil
	end

	if C_QuestLog.IsQuestFlaggedCompleted(63854) then
		collect.mawtormentor = true
	else
		collect.mawtormentor = nil
	end

	if 
		C_QuestLog.IsQuestFlaggedCompleted(63823) or 
		C_QuestLog.IsQuestFlaggedCompleted(63824) or 
		C_QuestLog.IsQuestFlaggedCompleted(63543) or
		C_QuestLog.IsQuestFlaggedCompleted(63822)
	then
		collect.mawassault = true
	else
		collect.mawassault = nil
	end

	if 
		C_QuestLog.IsQuestFlaggedCompleted(63949)
	then
		collect.kortiaweekly = true
	else
		collect.kortiaweekly = nil
		if C_QuestLog.GetLogIndexForQuestID(63949) then
			local progress = GetQuestProgressBarPercent(63949)

			if progress ~= 0 then
				collect.kortiaweekly = progress .. "%"
			end
		end
	end

	if 
		C_QuestLog.IsQuestFlaggedCompleted(61981) or 
		C_QuestLog.IsQuestFlaggedCompleted(61982) or 
		C_QuestLog.IsQuestFlaggedCompleted(61983) or
		C_QuestLog.IsQuestFlaggedCompleted(61984)
	then
		collect.anima1k = true
	else
		collect.anima1k = nil
		local questID = nil
		if C_QuestLog.GetLogIndexForQuestID(61981) then questID = 61981
		elseif C_QuestLog.GetLogIndexForQuestID(61982) then questID = 61982
		elseif C_QuestLog.GetLogIndexForQuestID(61983) then questID = 61983
		elseif C_QuestLog.GetLogIndexForQuestID(61984) then questID = 61984 end

		if questID then
			local objectives = C_QuestLog.GetQuestObjectives(questID)
			if objectives and objectives[1] then
				collect.anima1k = objectives[1].numFulfilled .. "/" .. objectives[1].numRequired
			end
		end
	end

	if C_QuestLog.IsQuestFlaggedCompleted(64531) then
		collect.mawworldboss = true
	else
		collect.mawworldboss = nil
	end

	if C_QuestLog.IsQuestFlaggedCompleted(64531) then
		collect.mawworldboss = true
	else
		collect.mawworldboss = nil
	end

	if C_QuestLog.IsQuestFlaggedCompleted(65266) then
		collect.korthialostresearch = true
	else
		collect.korthialostresearch = nil
	end

	if 
		C_QuestLog.IsQuestFlaggedCompleted(64551) or 
		C_QuestLog.IsQuestFlaggedCompleted(64549) or 
		C_QuestLog.IsQuestFlaggedCompleted(64552) or
		C_QuestLog.IsQuestFlaggedCompleted(64553)
	then
		collect.korthiaanimatablemission = true
	else
		collect.korthiaanimatablemission = nil
	end

	if C_QuestLog.IsQuestFlaggedCompleted(65143) then
		collect.zerthworldboss = true
	else
		collect.zerthworldboss = nil
	end


	if 
		C_QuestLog.IsQuestFlaggedCompleted(66042)
	then
		collect.patternswithinpatterns = true
	else
		collect.patternswithinpatterns = nil
		if C_QuestLog.GetLogIndexForQuestID(66042) then
			local progress = GetQuestProgressBarPercent(66042)

			if progress ~= 0 then
				collect.patternswithinpatterns = progress .. "%"
			end
		end
	end
end)

local korthiaRaresList = {
	64257,179802,"Chamber of Knowledge",
	64278,179859,"Chamber of Wisdom",
	64243,179768,"Consumption",
	63830,177903,"Dominated Protector",
	64349,180042,"Covenant: Necrolord",
	64320,180014,"Covenant: Night Fae",
	64313,179985,"Covenant: Venthyr",
	64338,180032,"Covenant: Kyrian",
	64428,179108,"Kroke the Tormented",
	64291,179931,"Relic Breaker Krelva",
	64455,180160,"Reliwik the Defiant",
	64442,177336,"Zelnithop",
	64246,179472,"Konthrogz the Obliterator",
	64245,179760,"Towering Exterminator",
	64457,180162,"Ve'rayn",
	64285,179913,"Deadsoul Hatcher",
	64369,179914,"Observer Yorik",
	64263,179608,"Screaming Shade",
	64284,179911,"Silent Soulstalker",
}

local zerthRaresList = {
	65544,183646,"Furidian",
	65579,178778,"Gluttonous Overgrowth",
	65272,183925,"Tahkwitz",
	65556,183746,"Otiosen",
	65273,183953,"Corrupted Architect",
	65239,181360,"Vexis",
	65555,184409,"Euv'ouk",
	65549,184413,"Shifting Stargorger",
	65251,183764,"Zatojin",
	65587,182158,"Reanimatrox Marzan",
	65240,183722,"Sorranos",
	65557,178229,"Feasting",
	65553,183596,"Chitali the Eldest",
	65582,179043,"Orixal",
	65584,183747,"Vitiane",
	65241,183737,"Xy'rath the Covetous",
	65586,182155,"High Reaver Damaris",
	65581,178563,"Hadeon the Stonebreaker",
	65583,182318,"General Zarathura",
	65551,183748,"Helmix",
	65257,183814,"Otaris the Provoked",
	65548,180978,"Hirukon",
	65550,181249,"Tethos",
	65580,183516,"The Engulfer",
	63988,178963,"Gorkek",
	65574,183927,"Sand Matriarch Ileus",
	64719,180924,"Garudeon",
	65549,179006,"Akkaris",
	64668,180746,"Protector of the First Ones",
	65585,182114,"Iska, Outrider of Ruin",
	64716,180917,"Destabilized Core",
	65547,178508,"Mother Phestis",
	--32 limit here
}

tinsert(ToDoFunc,function(self,collect)
	local res = 0
	collect.korthiaRares = res

	for i=1,#korthiaRaresList,3 do
		if C_QuestLog.IsQuestFlaggedCompleted(korthiaRaresList[i]) then
			res = bit.bor(res,bit.lshift(1,(i-1)/3))
		end
	end
	collect.korthiaRares = res


	local res = 0
	collect.zerthRares = res

	for i=1,#zerthRaresList,3 do
		if C_QuestLog.IsQuestFlaggedCompleted(zerthRaresList[i]) then
			res = bit.bor(res,bit.lshift(1,(i-1)/3))
		end
	end
	collect.zerthRares = res

end)

tinsert(ToDoFunc,function(self,collect)
	local chardata = {}
	collect.missionList = chardata

	local followersList = C_Garrison.GetFollowers(GetPrimaryGarrisonFollowerType(Enum.GarrisonType.Type_9_0))
	local followersTotal,followersOnMission = 0,0
	for _,follower in pairs(followersList) do
		followersTotal = followersTotal + 1
	end

	for _,func in pairs({C_Garrison.GetInProgressMissions}) do
		local missions = func(GetPrimaryGarrisonFollowerType(Enum.GarrisonType.Type_9_0))
		if type(missions) == "table" then
			for i=1,#missions do
				local mission = missions[i]
				
				local fin = mission.offerEndTime and mission.offerEndTime-GetTime()+time() or 0
				if mission.inProgress then
					fin = mission.timeLeftSeconds and mission.timeLeftSeconds+time() or 0
				end
				local rewardStr
				if type(mission.rewards)=="table" and #mission.rewards > 0 then
					local reward = mission.rewards[1]

					if (reward.currencyID) then
						if reward.currencyID == 0 then
							rewardStr = GetCoinTextureString(reward.quantity or 0)
						else
							local name, amount, texturePath = GetCurrencyInfo(reward.currencyID)
							rewardStr = (reward.quantity and reward.quantity > 1 and reward.quantity.."x " or "").."|T"..(reward.icon or texturePath or 0)..":0|t "..(name or "Currency ID"..reward.currencyID)
						end
					elseif (reward.quality) then
						rewardStr = ITEM_QUALITY_COLORS[reward.quality + 1].hex..reward.title..FONT_COLOR_CODE_CLOSE
					elseif (reward.itemID) then
						local itemName, _, itemRarity, _, _, _, _, _, _, itemTexture = GetItemInfo(reward.itemID)
						if not itemTexture then
							itemTexture = select(5,GetItemInfoInstant(reward.itemID)) or 134400
						end
						if reward.itemLink and type(reward.itemLink) == "string" then
							local color = reward.itemLink:match("|c........")
							rewardStr = "|T"..itemTexture..":0|t "..(reward.quantity and reward.quantity > 1 and reward.quantity.."x " or "")..(color or "").. (reward.itemLink:match("|h%[(.-)%]|h") or itemName or "item"..reward.itemID)..(color and "|r" or "")
						elseif itemName then
							rewardStr = "|T"..itemTexture..":0|t "..(reward.quantity and reward.quantity > 1 and reward.quantity.."x " or "").. ITEM_QUALITY_COLORS[itemRarity].hex..itemName..FONT_COLOR_CODE_CLOSE
						end
					elseif (reward.followerXP) then
						rewardStr = reward.name or reward.title
					else
						rewardStr = reward.title
					end
				end				
 				chardata[#chardata+1] = fin
 				chardata[#chardata+1] = rewardStr or ""

				if type(mission.followers)=="table" then
					for j=1,#mission.followers do
						local guid = mission.followers[j]
						for k,follower in pairs(followersList) do
							if follower.followerID == guid then
								followersOnMission = followersOnMission + 1
								followersList[k] = nil
								break
							end
						end
					end
				end
			end
		end
	end

	collect.missionFollowersCount = (followersTotal-followersOnMission).."/"..followersTotal
end)



local MiniMapIcon = CreateFrame("Button", "LibDBIcon10_LegionToDoMinimap", Minimap)
MiniMapIcon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight") 
MiniMapIcon:SetSize(32,32) 
MiniMapIcon:SetFrameStrata("MEDIUM")
MiniMapIcon:SetFrameLevel(8)
MiniMapIcon:SetPoint("CENTER", 80, -12)
MiniMapIcon:SetDontSavePosition(true)
MiniMapIcon:RegisterForDrag("LeftButton")
MiniMapIcon.icon = MiniMapIcon:CreateTexture(nil, "BACKGROUND")
MiniMapIcon.icon:SetTexture(1035049)
MiniMapIcon.icon:SetSize(20,20)
MiniMapIcon.icon:SetPoint("CENTER", 0, 0)
MiniMapIcon.border = MiniMapIcon:CreateTexture(nil, "ARTWORK")
MiniMapIcon.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
MiniMapIcon.border:SetTexCoord(0,0.6,0,0.6)
MiniMapIcon.border:SetAllPoints()
MiniMapIcon:RegisterForClicks("anyUp")
MiniMapIcon:SetScript("OnEnter",function(self) 
	local guid = UnitGUID("player")
	local charData = VLegionToDo.chars[guid]
	if not charData then
		charData = {}
		VLegionToDo.chars[guid] = charData
	end
	if not charData.s then
		charData.s = {}
	end
	local saved = charData.s
	wipe(charData)
	charData.s = saved
	charData.t = time()

	local realmKey = GetRealmName() or ""
	local charName = UnitName'player' or ""

	charData.name = charName
	charData.realm = realmKey
	charData.class = select(2,UnitClass("player"))

	RequestRaidInfo()

	GameTooltip:SetOwner(self, "ANCHOR_LEFT") 
	GameTooltip:AddLine("Shadowlands ToDo") 
	for _,func in pairs(ToDoFunc) do
		pcall(func,GameTooltip,charData)
		--local b,e = pcall(func,GameTooltip,charData) if not b then print(e) end
		--func(GameTooltip,charData)
	end
	GameTooltip:Show() 
end)
MiniMapIcon:SetScript("OnLeave", function(self)    
	GameTooltip:Hide()
end)

local minimapShapes = {
	["ROUND"] = {true, true, true, true},
	["SQUARE"] = {false, false, false, false},
	["CORNER-TOPLEFT"] = {false, false, false, true},
	["CORNER-TOPRIGHT"] = {false, false, true, false},
	["CORNER-BOTTOMLEFT"] = {false, true, false, false},
	["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
	["SIDE-LEFT"] = {false, true, false, true},
	["SIDE-RIGHT"] = {true, false, true, false},
	["SIDE-TOP"] = {false, false, true, true},
	["SIDE-BOTTOM"] = {true, true, false, false},
	["TRICORNER-TOPLEFT"] = {false, true, true, true},
	["TRICORNER-TOPRIGHT"] = {true, false, true, true},
	["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
	["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
}

local function IconMoveButton(self)
	if self.dragMode == "free" then
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", x, y)
		VLegionToDo.IconMiniMapLeft = x
		VLegionToDo.IconMiniMapTop = y
	else
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = Minimap:GetEffectiveScale()
		px, py = px / scale, py / scale
		
		local angle = math.atan2(py - my, px - mx)
		local x, y, q = math.cos(angle), math.sin(angle), 1
		if x < 0 then q = q + 1 end
		if y > 0 then q = q + 2 end
		local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
		local quadTable = minimapShapes[minimapShape]
		if quadTable[q] then
			x, y = x*80, y*80
		else
			local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
			x = math.max(-80, math.min(x*diagRadius, 80))
			y = math.max(-80, math.min(y*diagRadius, 80))
		end
		self:ClearAllPoints()
		self:SetPoint("CENTER", Minimap, "CENTER", x, y)
		VLegionToDo.IconMiniMapLeft = x
		VLegionToDo.IconMiniMapTop = y
	end
end

MiniMapIcon:SetScript("OnDragStart", function(self)
	self:LockHighlight()
	self:SetScript("OnUpdate", IconMoveButton)
	self.isMoving = true
	GameTooltip:Hide()
end)
MiniMapIcon:SetScript("OnDragStop", function(self)
	self:UnlockHighlight()
	self:SetScript("OnUpdate", nil)
	self.isMoving = false
end)

local function OnCloseFrame_Func()
	if InCombatLockdown() then
		return
	elseif not GameMenuFrame:IsVisible() then
		return
	end
	MiniMapIcon:GetScript("OnEnter")(MiniMapIcon)
	MiniMapIcon:GetScript("OnLeave")(MiniMapIcon)
end

local OnCloseFrame = CreateFrame("Frame",nil,GameMenuFrame)
OnCloseFrame:SetPoint("TOPLEFT")
OnCloseFrame:SetSize(1,1)
OnCloseFrame:SetScript("OnShow",function()
	C_Timer.After(.2,OnCloseFrame_Func)
end)

local LegionToDo = CreateFrame("Frame","LegionToDoFrame",UIParent)
LegionToDo:RegisterEvent("ADDON_LOADED")
LegionToDo:RegisterEvent("PLAYER_ENTERING_WORLD")
LegionToDo:RegisterEvent("UPDATE_INSTANCE_INFO")
if UnitLevel'player' < 60 then
	LegionToDo:RegisterEvent('PLAYER_LEVEL_UP')
end
LegionToDo:SetScript("OnEvent",function(self,event,...)
	if event == "PLAYER_ENTERING_WORLD" then
		RequestRaidInfo()
		C_Garrison.RequestLandingPageShipmentInfo()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "UPDATE_INSTANCE_INFO" then
		C_Timer.After(1, function()
			self:UnregisterEvent("UPDATE_INSTANCE_INFO")
			MiniMapIcon:GetScript("OnEnter")(MiniMapIcon)
			MiniMapIcon:GetScript("OnLeave")(MiniMapIcon)
		end)
	elseif event == "PLAYER_LEVEL_UP" then
		local level = ...
		if level <= 48 then
			VLegionToDo.opt_type[UnitGUID'player'] = 1
		elseif level <= 50 then
			VLegionToDo.opt_type[UnitGUID'player'] = 2
		elseif level > 50 then
			VLegionToDo.opt_type[UnitGUID'player'] = 3
		end
	elseif event == "ADDON_LOADED" then
		self:UnregisterEvent("ADDON_LOADED")
		
		VLegionToDo = VLegionToDo or {}
		VLegionToDo.chars = VLegionToDo.chars or {}
		VLegionToDo.black = VLegionToDo.black or {}
		VLegionToDo.charprio = VLegionToDo.charprio or {}
		VLegionToDo.opt = VLegionToDo.opt or {
			amana = true,
			warmy = true,
			gold = true,
			instance1 = true,
			instance2 = true,
			instance3 = true,
			instance4 = true,
			instance5 = true,
			instance6 = true,
			instance7 = true,
			instance8 = true,
			instance9 = true,
			instance10 = true,
			instance11 = true,
			instance12 = true,
			instance13 = true,
			raid1diff1 = true,
			raid1diff2 = true,
			raid1diff3 = true,
			raid2diff1 = true,
			raid2diff2 = true,
			raid2diff3 = true,
			raid3diff1 = true,
			raid3diff2 = true,
			raid3diff3 = true,
			raid4diff1 = true,
			raid4diff2 = true,
			raid4diff3 = true,
			raid5short = true,
			orderres_bfa = true,
			argusrecruits = true,
			service_medal = true,
			residuum = true,
		}
		VLegionToDo.opt_bfa = VLegionToDo.opt_bfa or {
			orderres = true,
			amana = true,
			warmy = true,
			gold = true,
			warsupp = true,
			nethershard = true,
			argunite = true,
			essence = true,
			argunitequest = true,
			riftquest = true,
			blood = true,
			raid6short = true,
			garmisstos = true,
			garmissabt = true,
			argusrecruits = true,
			artlvl = true,
		}
		VLegionToDo.opt_sl = VLegionToDo.opt_sl or {
			coins = true,
			orderres = true,
			orderres_bfa = true,
			warsupp = true,
			nethershard = true,
			amana = true,
			argunite = true,
			essence = true,
			manapearl = true,
			echoon = true,
			coalescing = true,
			mementos = true,
			miniVision = true,
			visionReward = true,
			cloak_lvl = true,
			cloak_res = true,
			argunitequest = true,
			riftquest = true,
			blood = true,
			warmy = true,
			islands = true,
			dublons = true,
			service_medal = true,
			residuum = true,
			warfront2 = true,
			warfront = true,
			warfrontHC = true,
			timewarped = true,
			mplusmax = true,
			conq_points = true,
			pvp_cache = true,
			garmisstos = true,
			garmissabt = true,
			argusrecruits = true,
			artlvl = true,
			azeritelvl = true,
			raid11short = true,
		}
		VLegionToDo.opt_type = VLegionToDo.opt_type or {}
		VLegionToDo.opt_type_auto = VLegionToDo.opt_type_auto or {}
		
		if not VLegionToDo.opt_type[UnitGUID'player'] then
			VLegionToDo.opt_type[UnitGUID'player'] = UnitLevel'player' <= 48 and 1 or UnitLevel'player' <= 50 and 2 or 3
		end
		
		VLegionToDo.ver = VERSION_NUMERIC
		
		if VLegionToDo.IconMiniMapLeft and VLegionToDo.IconMiniMapTop then
			MiniMapIcon:ClearAllPoints()
			MiniMapIcon:SetPoint("CENTER", VLegionToDo.IconMiniMapLeft, VLegionToDo.IconMiniMapTop)
		end
	end
end)
LegionToDo:Hide()
LegionToDo:SetPoint("CENTER")

tinsert(UISpecialFrames, "LegionToDoFrame")

LegionToDo:EnableMouse(true)
LegionToDo:SetMovable(true)
LegionToDo:RegisterForDrag("LeftButton")
LegionToDo:SetScript("OnDragStart", function(self)
	if self:IsMovable() then
		self:StartMoving()
	end
end)
LegionToDo:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
end)

LegionToDo:SetFrameStrata("DIALOG")

local LINE_WIDTH = 230

LegionToDo.f = CreateFrame("ScrollFrame", nil, LegionToDo)
LegionToDo.c = CreateFrame("Frame", nil, LegionToDo.f) 
LegionToDo.f:SetScrollChild(LegionToDo.c)
LegionToDo.f:SetClipsChildren(true)

LegionToDo.c:SetSize(1000,1000)

LegionToDo.f:SetPoint("TOPLEFT",0,-35)
LegionToDo.f:SetPoint("BOTTOMRIGHT",0,5)


LegionToDo.f1 = CreateFrame("ScrollFrame", nil, LegionToDo)
LegionToDo.c1 = CreateFrame("Frame", nil, LegionToDo.f1) 
LegionToDo.f1:SetScrollChild(LegionToDo.c1)
LegionToDo.f1:SetClipsChildren(true)

LegionToDo.c1:SetSize(1000,1000)

LegionToDo.f1:SetPoint("BOTTOMRIGHT",LegionToDo,"TOPRIGHT",0,-35)
LegionToDo.f1:SetPoint("TOPLEFT",LegionToDo,LINE_WIDTH,-5)


LegionToDo.f2 = CreateFrame("ScrollFrame", nil, LegionToDo.c)
LegionToDo.c2 = CreateFrame("Frame", nil, LegionToDo.f2) 
LegionToDo.f2:SetScrollChild(LegionToDo.c2)
--LegionToDo.f2:SetClipsChildren(true)

LegionToDo.c2:SetSize(1000,1000)

LegionToDo.f2:SetPoint("TOPLEFT",LegionToDo.c,"TOPLEFT",LINE_WIDTH,0)
LegionToDo.f2:SetSize(1000,1000)

LegionToDo.b = LegionToDo:CreateTexture(nil,"BACKGROUND")
LegionToDo.b:SetAllPoints()
LegionToDo.b:SetColorTexture(0.04,0.04,0.04,.9)

LegionToDo.shadow = CreateFrame("Frame",nil,LegionToDo, BackdropTemplateMixin and "BackdropTemplate")
do
	LegionToDo.shadow:SetPoint("LEFT",-20,0)
	LegionToDo.shadow:SetPoint("RIGHT",20,0)
	LegionToDo.shadow:SetPoint("TOP",0,20)
	LegionToDo.shadow:SetPoint("BOTTOM",0,-20)
	--LegionToDo.shadow:SetBackdrop({edgeFile="Interface\Addons\_ShiGuang\Media\Modules\Raid\Solid.blp",edgeSize= 28,insets={left=20,right=20,top=20,bottom=20}})
	LegionToDo.shadow:SetBackdropBorderColor(0,0,0,.45)
end

local CreateCheckBox,CreateBorder
do
	local function SetBorderColor(self,colorR,colorG,colorB,colorA,layerCounter)
		layerCounter = layerCounter or ""
		
		self["border_top"..layerCounter]:SetColorTexture(colorR,colorG,colorB,colorA)
		self["border_bottom"..layerCounter]:SetColorTexture(colorR,colorG,colorB,colorA)
		self["border_left"..layerCounter]:SetColorTexture(colorR,colorG,colorB,colorA)
		self["border_right"..layerCounter]:SetColorTexture(colorR,colorG,colorB,colorA)
	end
	local function ELib_Border(parent,size,colorR,colorG,colorB,colorA,outside,layerCounter)
		outside = outside or 0
		layerCounter = layerCounter or ""
		if size == 0 then
			if parent["border_top"..layerCounter] then
				parent["border_top"..layerCounter]:Hide()
				parent["border_bottom"..layerCounter]:Hide()
				parent["border_left"..layerCounter]:Hide()
				parent["border_right"..layerCounter]:Hide()
			end
			return
		end
		
		local textureOwner = parent.CreateTexture and parent or parent:GetParent()
		
		local top = parent["border_top"..layerCounter] or textureOwner:CreateTexture(nil, "BORDER")
		local bottom = parent["border_bottom"..layerCounter] or textureOwner:CreateTexture(nil, "BORDER")
		local left = parent["border_left"..layerCounter] or textureOwner:CreateTexture(nil, "BORDER")
		local right = parent["border_right"..layerCounter] or textureOwner:CreateTexture(nil, "BORDER")

		parent["border_top"..layerCounter] = top
		parent["border_bottom"..layerCounter] = bottom
		parent["border_left"..layerCounter] = left
		parent["border_right"..layerCounter] = right
	
		top:ClearAllPoints()
		bottom:ClearAllPoints()
		left:ClearAllPoints()
		right:ClearAllPoints()
		
		top:SetPoint("TOPLEFT",parent,"TOPLEFT",-size-outside,size+outside)
		top:SetPoint("BOTTOMRIGHT",parent,"TOPRIGHT",size+outside,outside)
	
		bottom:SetPoint("BOTTOMLEFT",parent,"BOTTOMLEFT",-size-outside,-size-outside)
		bottom:SetPoint("TOPRIGHT",parent,"BOTTOMRIGHT",size+outside,-outside)
	
		left:SetPoint("TOPLEFT",parent,"TOPLEFT",-size-outside,outside)
		left:SetPoint("BOTTOMRIGHT",parent,"BOTTOMLEFT",-outside,-outside)
	
		right:SetPoint("TOPLEFT",parent,"TOPRIGHT",outside,outside)
		right:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",size+outside,-outside)
	
		top:SetColorTexture(colorR,colorG,colorB,colorA)
		bottom:SetColorTexture(colorR,colorG,colorB,colorA)
		left:SetColorTexture(colorR,colorG,colorB,colorA)
		right:SetColorTexture(colorR,colorG,colorB,colorA)
		
		parent.SetBorderColor = SetBorderColor
	
		top:Show()
		bottom:Show()
		left:Show()
		right:Show()
	end
	ELib_Border(LegionToDo,1,.3,.3,.3,1)
	
	CreateBorder = ELib_Border
	
	function CreateCheckBox(parent)
		local self = CreateFrame("CheckButton",nil,parent)
		self:SetSize(20,20)
		
		self.text = self:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
		self.text:SetPoint("TOPLEFT",self,"TOPRIGHT",4,0)
		self.text:SetPoint("BOTTOMLEFT",self,"BOTTOMRIGHT",4,0)
		self.text:SetJustifyV("MIDDLE")
		
		self:SetFontString(self.text)
		
		ELib_Border(self,1,0.24,0.25,0.3,1)
		
		self.Texture = self:CreateTexture(nil,"BACKGROUND")
		self.Texture:SetColorTexture(0,0,0,.3)
		self.Texture:SetPoint("TOPLEFT")
		self.Texture:SetPoint("BOTTOMRIGHT")
		
		self.CheckedTexture = self:CreateTexture()
		self.CheckedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self.CheckedTexture:SetPoint("TOPLEFT",-4,4)
		self.CheckedTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self:SetCheckedTexture(self.CheckedTexture)
		
		self.PushedTexture = self:CreateTexture()
		self.PushedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self.PushedTexture:SetPoint("TOPLEFT",-4,4)
		self.PushedTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self.PushedTexture:SetVertexColor(0.8,0.8,0.8,0.5)
		self.PushedTexture:SetDesaturated(true)
		self:SetPushedTexture(self.PushedTexture)
	
		self.DisabledTexture = self:CreateTexture()
		self.DisabledTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		self.DisabledTexture:SetPoint("TOPLEFT",-4,4)
		self.DisabledTexture:SetPoint("BOTTOMRIGHT",4,-4)
		self:SetDisabledTexture(self.DisabledTexture)
			
		self.HighlightTexture = self:CreateTexture()
		self.HighlightTexture:SetColorTexture(1,1,1,.3)
		self.HighlightTexture:SetPoint("TOPLEFT")
		self.HighlightTexture:SetPoint("BOTTOMRIGHT")
		self:SetHighlightTexture(self.HighlightTexture)
				
		return self
	end
end

for i,v in pairs({"Legion","Bfa","Shadowlands"}) do
	local button = CreateFrame("Button", nil, LegionToDo)
	LegionToDo["modeSwitcherCheck"..v] = button
	button:SetSize(20,20)
	
	button.b = button:CreateTexture(nil,"BACKGROUND",nil,1)
	button.b:SetAllPoints()
	button.b:SetColorTexture(0.04,0.04,0.04,.9)
	
	button.icon = button:CreateTexture(nil,"ARTWORK")
	button.icon:SetPoint("CENTER")
	button.icon:SetSize(16,16)
	
	button.icon:SetAtlas("worldquest-icon-burninglegion")
	
	button:SetScript("OnEnter",function(self)
		self.b:SetColorTexture(0.14,0.14,0.14,.9)
	end)
	
	button:SetScript("OnLeave",function(self)
		self.b:SetColorTexture(0.04,0.04,0.04,.9)
	end)
	
	button:SetScript("OnClick",function(self)
		VLegionToDo.opt_type[UnitGUID'player'] = i
		LegionToDo:Hide()
		LegionToDo:Show()
	end)
end
LegionToDo.modeSwitcherCheckLegion:SetPoint("BOTTOMLEFT",LegionToDo,"TOPLEFT",20,1)
LegionToDo.modeSwitcherCheckBfa:SetPoint("BOTTOMLEFT",LegionToDo.modeSwitcherCheckLegion,"BOTTOMRIGHT",2,0)
LegionToDo.modeSwitcherCheckShadowlands:SetPoint("BOTTOMLEFT",LegionToDo.modeSwitcherCheckBfa,"BOTTOMRIGHT",2,0)

LegionToDo.modeSwitcherCheckLegion.icon:SetAtlas("worldquest-icon-burninglegion")
LegionToDo.modeSwitcherCheckBfa.icon:SetTexture(UnitFactionGroup("player") == "Alliance" and "Interface\\FriendsFrame\\PlusManz-Alliance" or "Interface\\FriendsFrame\\PlusManz-Horde")
LegionToDo.modeSwitcherCheckShadowlands.icon:SetAtlas("shadowlands-landingbutton-NightFae-up")



LegionToDo.leftScrollBar = CreateFrame("Slider", nil, LegionToDo)
LegionToDo.leftScrollBar:SetPoint("TOPLEFT",LegionToDo,1,-10)
LegionToDo.leftScrollBar:SetPoint("BOTTOMLEFT",LegionToDo,1,10)
LegionToDo.leftScrollBar:SetWidth(14)

LegionToDo.leftScrollBar.thumb = LegionToDo.leftScrollBar:CreateTexture(nil, "OVERLAY")
LegionToDo.leftScrollBar.thumb:SetColorTexture(0.44,0.45,0.50,.7)
LegionToDo.leftScrollBar.thumb:SetSize(10,20)

LegionToDo.leftScrollBar:SetThumbTexture(LegionToDo.leftScrollBar.thumb)
LegionToDo.leftScrollBar:SetOrientation("VERTICAL")
LegionToDo.leftScrollBar:SetMinMaxValues(0,100)
LegionToDo.leftScrollBar:SetValue(0)

LegionToDo.leftScrollBar.border = LegionToDo.leftScrollBar:CreateTexture(nil, "BORDER")
LegionToDo.leftScrollBar.border:SetColorTexture(.24,.25,.30,1)
LegionToDo.leftScrollBar.border:SetWidth(1)
LegionToDo.leftScrollBar.border:SetPoint("TOP",LegionToDo)
LegionToDo.leftScrollBar.border:SetPoint("BOTTOM",LegionToDo)
LegionToDo.leftScrollBar.border:SetPoint("LEFT",LegionToDo.leftScrollBar,"RIGHT")

LegionToDo.leftScrollBar:SetScript("OnValueChanged",function(self,value)
	LegionToDo.f:SetVerticalScroll(value) 
end)

LegionToDo.leftScrollBar:Hide()



LegionToDo.bottomScrollBar = CreateFrame("Slider", nil, LegionToDo)
LegionToDo.bottomScrollBar:SetPoint("BOTTOMLEFT",LegionToDo,10,-1)
LegionToDo.bottomScrollBar:SetPoint("BOTTOMRIGHT",LegionToDo,-10,-1)
LegionToDo.bottomScrollBar:SetHeight(14)

LegionToDo.bottomScrollBar.thumb = LegionToDo.bottomScrollBar:CreateTexture(nil, "OVERLAY")
LegionToDo.bottomScrollBar.thumb:SetColorTexture(0.44,0.45,0.50,.7)
LegionToDo.bottomScrollBar.thumb:SetSize(20,10)

LegionToDo.bottomScrollBar:SetThumbTexture(LegionToDo.bottomScrollBar.thumb)
LegionToDo.bottomScrollBar:SetOrientation("HORIZONTAL")
LegionToDo.bottomScrollBar:SetMinMaxValues(0,100)
LegionToDo.bottomScrollBar:SetValue(0)

LegionToDo.bottomScrollBar.border = LegionToDo.bottomScrollBar:CreateTexture(nil, "BORDER")
LegionToDo.bottomScrollBar.border:SetColorTexture(.24,.25,.30,1)
LegionToDo.bottomScrollBar.border:SetHeight(1)
LegionToDo.bottomScrollBar.border:SetPoint("LEFT",LegionToDo)
LegionToDo.bottomScrollBar.border:SetPoint("RIGHT",LegionToDo)
LegionToDo.bottomScrollBar.border:SetPoint("BOTTOM",LegionToDo.bottomScrollBar,"TOP")

LegionToDo.bottomScrollBar:SetScript("OnValueChanged",function(self,value)
	LegionToDo.f1:SetHorizontalScroll(value) 
	LegionToDo.f2:SetHorizontalScroll(value) 
end)

LegionToDo.bottomScrollBar:Hide()


LegionToDo:SetScript("OnMouseWheel", function (self,delta)
	if not LegionToDo.leftScrollBar:IsShown() then
		return
	end
	delta = delta * 20
	local min,max = LegionToDo.leftScrollBar:GetMinMaxValues()
	local val = LegionToDo.leftScrollBar:GetValue()
	if (val - delta) < min then
		LegionToDo.leftScrollBar:SetValue(min)
	elseif (val - delta) > max then
		LegionToDo.leftScrollBar:SetValue(max)
	else
		LegionToDo.leftScrollBar:SetValue(val - delta)
	end
end)


LegionToDo.Close = CreateFrame("Button",nil,LegionToDo,"UIPanelCloseButton")
LegionToDo.Close:SetPoint("TOPRIGHT",3,3)

LegionToDo.title = LegionToDo:CreateFontString(nil,"ARTWORK","GameFontWhite")
LegionToDo.title:SetPoint("TOPLEFT",30,-10)
LegionToDo.title:SetText("|cffffff00Shadowlands ToDo "..LegionToDoVersion)

local OPTIONS_TOGGLED = false

LegionToDo.Options = CreateFrame("Button",nil,LegionToDo)
LegionToDo.Options:SetPoint("TOPLEFT",170,0)
LegionToDo.Options:SetScript("OnClick",function(self)
	OPTIONS_TOGGLED = not OPTIONS_TOGGLED
	if OPTIONS_TOGGLED then
		self:SetNormalTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
		self:SetPushedTexture("Interface\\Buttons\\LockButton-Locked-Up")
	else
		self:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
		self:SetPushedTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
	end
	LegionToDo:Hide()
	LegionToDo:Show()
end)
LegionToDo.Options:SetNormalTexture("Interface\\Buttons\\LockButton-Locked-Up")
LegionToDo.Options:SetPushedTexture("Interface\\Buttons\\LockButton-Unlocked-Down")
LegionToDo.Options:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
LegionToDo.Options:SetSize(32, 32)

local CharsListDropdown = CreateFrame("Frame", "LegionToDoCharsListMenuFrame", LegionToDo, "UIDropDownMenuTemplate")

local function CharList_DropDown_SetCharPrio(guid,prio)
	VLegionToDo.charprio[guid] = prio
	LegionToDo:GetScript("OnShow")(LegionToDo)
end

LegionToDo.CharsList = CreateFrame("Button",nil,LegionToDo,"UIPanelButtonTemplate")
LegionToDo.CharsList:SetPoint("TOPLEFT",200,-5)
LegionToDo.CharsList:SetScript("OnClick",function(self)
	if UIDROPDOWNMENU_OPEN_MENU then
		CloseDropDownMenus()
		return
	end
	local db = {}
	local list_realm = {}

	local listWithNames, blacked = {},{}
	for guid,db in pairs(VLegionToDo.chars) do
		local k = db.name.."-"..(db.realm or "")
		if listWithNames[k] then
			if db.t > listWithNames[k].t then
				blacked[ listWithNames[k] ] = true
				listWithNames[k] = db
			else
				blacked[ db ] = true
			end
		else
			listWithNames[k] = db
		end
	end

	for guid,c in pairs(VLegionToDo.chars) do
		if not blacked[ c ] then
			if not db[ c.realm ] then
				db[ c.realm ] = {}
				tinsert(list_realm,c.realm)
			end
			tinsert(db[c.realm],{c.name,guid})
		end
	end
	sort(list_realm)
	local menuTable = {}
	for i=1,#list_realm do
		local list_chars = {}
		local realm = list_realm[i]
		sort(db[realm],function(a,b)return a[1]<b[1] end)
		for j=1,#db[realm] do
			local name,guid = db[realm][j][1],db[realm][j][2]
			list_chars[#list_chars + 1] = {
				text = name, 
				notCheckable = false, 
				keepShownOnClick = true,
				checked = function() 
					return not VLegionToDo.black[guid] 
				end,
				func = function(self)
					VLegionToDo.black[guid] = not VLegionToDo.black[guid] 

					if VLegionToDo.black[guid] then
						_G[self:GetName().."Check"]:Hide()
						_G[self:GetName().."UnCheck"]:Show()
					else
						_G[self:GetName().."Check"]:Show()
						_G[self:GetName().."UnCheck"]:Hide()
					end

					LegionToDo:GetScript("OnShow")(LegionToDo)
				end,
				--isNotRadio = true,
				hasArrow = true,
				menuList = {
					{
						notCheckable = true, 
						text = DELETE, 
						func = function()
							StaticPopupDialogs["LEGIONTODO_REMOVECHAR"] = {
								text = GetLocale() == "ruRU" and ("Удалить всю информацию о персонаже "..name.."?") or
									("Remove data for "..name.."?"),
								button1 = YES,
								button2 = NO,
								OnAccept = function()
									VLegionToDo.chars[ guid ] = nil
									VLegionToDo.black[ guid ] = nil
								end,
								timeout = 0,
								whileDead = true,
								hideOnEscape = true,
								preferredIndex = 3,
							}
							StaticPopup_Show("LEGIONTODO_REMOVECHAR")	
						end,
					},
					{
						notCheckable = false, 
						text = "Prio: Low", 
						checked = function() 
							return VLegionToDo.charprio[guid] == -1
						end,
						func = function()
							CharList_DropDown_SetCharPrio(guid,-1)
						end,
					},
					{
						notCheckable = false, 
						text = "Prio: Normal", 
						checked = function() 
							return not VLegionToDo.charprio[guid]
						end,
						func = function()
							CharList_DropDown_SetCharPrio(guid,nil)
						end,
					},
					{
						notCheckable = false, 
						text = "Prio: High", 
						checked = function() 
							return VLegionToDo.charprio[guid] == 1
						end,
						func = function()
							CharList_DropDown_SetCharPrio(guid,1)
						end,
					},
				},
			}
		end
	
		menuTable[#menuTable + 1] = {
			hasArrow = true,
			menuList = list_chars,
			text = realm, 
			notCheckable = true, 
			keepShownOnClick = true,
		}
	end

	menuTable[#menuTable + 1] = {
		text = CLOSE, func = function() 
			CloseDropDownMenus() 
			LegionToDo:Hide()
			LegionToDo:Show()
		end, notCheckable = true
	}
	EasyMenu(menuTable, CharsListDropdown, "cursor", 10 , -15, "MENU")

end)
LegionToDo.CharsList:SetSize(22, 22)
LegionToDo.CharsList:SetText("C")

local function AtlasToText(atlasName,widthInText,heightInText)
	local info = C_Texture.GetAtlasInfo(atlasName)

	local textureWidth,textureHeight = info.width/(info.rightTexCoord-info.leftTexCoord), info.height/(info.bottomTexCoord-info.topTexCoord)

	return "|T"..info.file..":"..(widthInText or 16)..":"..(heightInText or 16)..":0:0:"..textureWidth..":"..textureHeight..":"..
		format("%d",info.leftTexCoord*textureWidth)..":"..format("%d",info.rightTexCoord*textureWidth)..":"..format("%d",info.topTexCoord*textureHeight)..":"..format("%d",info.bottomTexCoord*textureHeight).."|t"
end

local function LineOnEnter(self)
	self.highlight:Show()
end
local function LineOnLeave(self)
	self.highlight:Hide()
end
local function LineCheckState(self,state)
	if state then
		self.check:Show()
		self.icon:SetPoint("LEFT",24,0)
	else
		self.check:Hide()
		self.icon:SetPoint("LEFT",4,0)
	end
end
local function LineCheckClick(self)
	local optType = VLegionToDo.opt_type[UnitGUID'player']
	VLegionToDo[optType == 1 and "opt" or optType == 2 and "opt_bfa" or "opt_sl"][self.label or "tmp"] = not self:GetChecked()
end

local colNames = {}
local lines = {}

local function GetOrCreateLine(i)
	if not lines[i] then
		local line = CreateFrame("Frame",nil,LegionToDo.c)
		lines[i] = line
		line:SetPoint("TOPLEFT",0,-(i-1)*20 -0)
		line:SetPoint("BOTTOMRIGHT",LegionToDo.c,"TOPRIGHT",0,-i*20 -0)
		
		line.check = CreateCheckBox(line)
		line.check:SetPoint("LEFT",4,0)
		line.check:SetScript("OnClick",LineCheckClick)
		
		line.icon = line:CreateTexture(nil, "BACKGROUND")
		line.icon:SetPoint("LEFT",4,0)
		line.icon:SetSize(1,18)
	
		line.title = line:CreateFontString(nil,"ARTWORK","GameFontWhite")
		line.title:SetPoint("LEFT",line.icon,"RIGHT",1,0)
		line.title:SetPoint("RIGHT",line,"LEFT",LINE_WIDTH,0)
		line.title:SetHeight(18)
		line.title:SetJustifyH("LEFT")
		
		line.highlight = line:CreateTexture(nil, "BACKGROUND", nil, -5) 
		line.highlight:SetAllPoints()
		line.highlight:SetColorTexture(1,1,1,.15)
		line.highlight:Hide()
		
		line:SetScript("OnEnter",LineOnEnter)
		line:SetScript("OnLeave",LineOnLeave)
		
		line.UpdateCheck = LineCheckState
		
		line.cols = {}
	end
	return lines[i]
end

local function LineUpdate(pos,opt,text,icon,style)
	local optType = VLegionToDo.opt_type[UnitGUID'player']
	if not VLegionToDo[optType == 1 and "opt" or optType == 2 and "opt_bfa" or "opt_sl"][opt] or OPTIONS_TOGGLED then
		pos = pos + 1
		local line = GetOrCreateLine(pos)
		line.title:SetText(text)
		line.check.label = opt
		line.check:SetChecked(not VLegionToDo[optType == 1 and "opt" or optType == 2 and "opt_bfa" or "opt_sl"][opt])
		line:UpdateCheck(OPTIONS_TOGGLED)
		line.app = style
		if icon then
			line.icon:SetTexture(icon)
			line.icon:SetWidth(18)	
		else
			line.icon:SetTexture("")
			line.icon:SetWidth(1)			
		end
		line:Show()
	end
	return pos
end

local function LineHide(pos)
	for i=pos+1,#lines do
		lines[i]:Hide()
	end
end

local function ColTooltipOnEnter(self)
 	self.line:GetScript("OnEnter")(self.line)
 	if self.data then
 		GameTooltip:SetOwner(self,"ANCHOR_LEFT")
 		if self.data[-1] then
 			GameTooltip:AddLine(self.data[-1],1,1,1)
 		end
 		for i=1,#self.data,2 do
 			GameTooltip:AddDoubleLine(self.data[i],self.data[i+1])
 		end
 		GameTooltip:Show()
 	end
end
local function ColTooltipOnLeave(self)
	self.line:GetScript("OnLeave")(self.line)
	GameTooltip_Hide()
end
local function ColTooltipOnClick(self)
	if type(self.click) == 'function' then
		self.click(self.data)
	elseif self.click then
		ItemRefTooltip:SetHyperlink(self.click)
	end
end

local function AddColTooltip(self,tooltip,click)
	if not self.tooltip then
		self.tooltip = CreateFrame("Button",nil,self:GetParent())
		self.tooltip:SetAllPoints(self)
		self.tooltip.line = self.line
		self.tooltip:SetScript("OnEnter",ColTooltipOnEnter)
		self.tooltip:SetScript("OnLeave",ColTooltipOnLeave)
		self.tooltip:SetScript("OnClick",ColTooltipOnClick)
	end
	self.tooltip:Show()
	self.tooltip.data = tooltip
	self.tooltip.click = click
end

local function UpdateCustomCheck(data)
	if data.db then
		if data.state then
			data.db[data.name] = nil
		else
			data.db[data.name] = time()
		end
		LegionToDo:GetScript("OnShow")(LegionToDo)
	end
end

local LINES_MAX = 25
local COLS_MAX = 10

local hidden = {}

local thursdayResetDay0EU = 1514358000
local thursdayResetDay0US = 1514300400

LegionToDo:SetScript("OnShow",function(self)
	local count = 0

	count = LineUpdate(count,"coins","Coins","Interface/Icons/inv_misc_elvencoins")
	count = LineUpdate(count,"orderres",GetCurrencyInfo(1220),"Interface/Icons/inv_orderhall_orderresources")
	count = LineUpdate(count,"orderres_bfa",GetCurrencyInfo(1560),"Interface/Icons/inv__faction_warresources")

	local name, _, texturePath = GetCurrencyInfo(1342)
	count = LineUpdate(count,"warsupp",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1226)
	count = LineUpdate(count,"nethershard",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1155)
	count = LineUpdate(count,"amana",name,"Interface/Icons/inv_misc_ancient_mana")
		
	local name, _, texturePath = GetCurrencyInfo(1508)
	count = LineUpdate(count,"argunite",name,texturePath)
	
	local name, _, texturePath = GetCurrencyInfo(1533)
	count = LineUpdate(count,"essence",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1721)
	count = LineUpdate(count,"manapearl",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1803)
	count = LineUpdate(count,"echoon",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1755)
	count = LineUpdate(count,"coalescing",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1719)
	count = LineUpdate(count,"mementos",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1767)
	count = LineUpdate(count,"stygia",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1828)
	count = LineUpdate(count,"soulash",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1906)
	count = LineUpdate(count,"soulash91",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(2009)
	count = LineUpdate(count,"cosmicflux",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1813)
	count = LineUpdate(count,"anima",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1810)
	count = LineUpdate(count,"rsouls",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1191)
	count = LineUpdate(count,"valor",name,texturePath,'small-left2')

	local name, _, texturePath = GetCurrencyInfo(1904)
	count = LineUpdate(count,"towerknowledge",name,texturePath,'small-left2')

	local name, _, texturePath = GetCurrencyInfo(1931)
	count = LineUpdate(count,"catalogedresearch",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1977)
	count = LineUpdate(count,"stygianember",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1979)
	count = LineUpdate(count,"cyphers",name,texturePath)


	count = LineUpdate(count,"miniVision","Mini Vision")
	count = LineUpdate(count,"visionReward","Vision Reward")

	count = LineUpdate(count,"cloak_lvl","Cloak level")
	count = LineUpdate(count,"cloak_res","Cloak resistance")
	
	count = LineUpdate(count,"argunitequest","Argunite quest")
	
	count = LineUpdate(count,"riftquest","Rift quest")

	count = LineUpdate(count,"blood",GetItemInfo(124124) or "Blood of Sargeras",1417744)	

	count = LineUpdate(count,"warmy","Withered Army Training")

	count = LineUpdate(count,"islands","Islands weekly",nil,'small-left')

	count = LineUpdate(count,"dublons",GetCurrencyInfo(1710),"Interface/Icons/inv_misc_azsharacoin")

	local name, _, texturePath = GetCurrencyInfo(UnitFactionGroup("player") ~= "Alliance" and 1716 or 1717)
	count = LineUpdate(count,"service_medal",name,texturePath)

	local name, _, texturePath = GetCurrencyInfo(1718)
	count = LineUpdate(count,"residuum",name,texturePath)
	
	count = LineUpdate(count,"warfront2","Warfront: Darkshore")

	count = LineUpdate(count,"warfront","Warfront: Stromgarde")

	count = LineUpdate(count,"warfrontHC","Warfront HC: Stromgarde")

	count = LineUpdate(count,"anima1k","1000 anima")
	count = LineUpdate(count,"kortiaweekly","Korthia: Weekly")
	count = LineUpdate(count,"patternswithinpatterns","Zerith Mortis: Weekly")

	count = LineUpdate(count,"zerthworldboss","Zerith Mortis: World Boss")
	count = LineUpdate(count,"mawworldboss","Maw: World Boss")
	count = LineUpdate(count,"mawtormentor","Maw: Tormentors")
	count = LineUpdate(count,"mawassault","Maw: Covenant Assault")
	count = LineUpdate(count,"wrathofthejailer","Maw: Wrath of the Jailer")
	count = LineUpdate(count,"mawhunt","Maw: The Hunt")
	count = LineUpdate(count,"korthialostresearch","Korthia: Lost Research")	

	count = LineUpdate(count,"zerthRares","Zerith Mortis: Rares")
	count = LineUpdate(count,"korthiaRares","Korthia: Rares")

	count = LineUpdate(count,"missionTable","Covenant table missions")
	count = LineUpdate(count,"korthiaanimatablemission","Korthia: anima table mission")

	local name, _, texturePath = GetCurrencyInfo(1166)
	count = LineUpdate(count,"timewarped",name,texturePath)

	count = LineUpdate(count,"gold","Gold",nil,'small-left')	
	
	for i=1,#instancesInOptions do
		count = LineUpdate(count,"instance"..i,instances[ instancesInOptions[i] ])
	end

	count = LineUpdate(count,"slreward","Great Vault")
	
	--count = LineUpdate(count,"mplusmax","Weekly max mythic+")
	count = LineUpdate(count,"mpluskey","M+ Key",nil,'small')

	--count = LineUpdate(count,"torghast","Torghast",nil,'small-left2')
	--count = LineUpdate(count,"torghast","Torghast",nil,'small-left2')
	count = LineUpdate(count,"torghastav","Torghast: Adamant Vaults")

	count = LineUpdate(count,"conq_points","Conquest points")
	count = LineUpdate(count,"pvp_cache","PvP cache")

	local name, _, texturePath = GetCurrencyInfo(1792)
	count = LineUpdate(count,"honor",name,texturePath)
	
	count = LineUpdate(count,"garmisstos","ToS Garrison Mission",nil,'small')
	count = LineUpdate(count,"garmissabt","ABT Garrison Mission",nil,'small')
	
	count = LineUpdate(count,"argusrecruits","Argus recruits")
			
	for i=1,#raids do
		count = LineUpdate(count,"raid"..i.."short",raids[i])
		if LFRInstances[i] then
			count = LineUpdate(count,"raid"..i.."difflfr",raids[i].." "..PLAYER_DIFFICULTY3)
		end
		for j=1,#raidsDiffs do
			count = LineUpdate(count,"raid"..i.."diff"..j,raids[i].." "..raidsDiffsNames[j])
		end
	end

	count = LineUpdate(count,"prof","Professions",nil,'center')
	--count = LineUpdate(count,"prof1","Profession 1",nil,'small')
	--count = LineUpdate(count,"prof2","Profession 2",nil,'small')
	
	for i=1,3 do
		count = LineUpdate(count,"bounty"..i,"Bounty #"..i)
	end
	
	
	for i=1,#factionsToWatch do
		local factionID = factionsToWatch[i]	
				
		local name = GetFactionInfoByID(factionID)
		count = LineUpdate(count,"faction"..factionID,FACTION.." "..(name or "#"..factionID),nil,'small')
	end

	count = LineUpdate(count,"cov","Covenant",nil,'center')
	count = LineUpdate(count,"cov_tree","Covenant Tree",nil,'small')
	count = LineUpdate(count,"cov_renown","Covenant Renown",nil,'center')

	count = LineUpdate(count,"warmode","War Mode",nil,'center')

	count = LineUpdate(count,"artlvl","Aftifact LvL",nil,'center')
	count = LineUpdate(count,"azeritelvl","Azerite LvL",nil,'small')
	count = LineUpdate(count,"ilvl","Item Level",nil,'center')

	
	count = LineUpdate(count,"customcheckd1","Daily Check 1",nil,'center')
	count = LineUpdate(count,"customcheckd2","Daily Check 2",nil,'center')
	count = LineUpdate(count,"customcheckd3","Daily Check 3",nil,'center')
	count = LineUpdate(count,"customcheckw1","Weekly Check 1",nil,'center')
	count = LineUpdate(count,"customcheckw2","Weekly Check 2",nil,'center')
	count = LineUpdate(count,"customcheckw3","Weekly Check 3",nil,'center')

	count = LineUpdate(count,"lastupate","Last Update",nil,'small')
	
	LineHide(count)
	
	local sortedList,listWithNames,blacked = {},{},{}
	for guid,db in pairs(VLegionToDo.chars) do
		local k = db.name.."-"..(db.realm or "")
		if listWithNames[k] then
			if db.t > listWithNames[k].t then
				blacked[ listWithNames[k] ] = true
				listWithNames[k] = db
			else
				blacked[ db ] = true
			end
		else
			listWithNames[k] = db
		end
	end
	for guid,db in pairs(VLegionToDo.chars) do
		if not blacked[ db ] or self.TempDiableBlack then
			tinsert(sortedList,{guid,db,db.name,VLegionToDo.charprio[guid] or 0})
		end
	end
	sort(sortedList,function(a,b)
		if a[4] == b[4] then
			return a[3] < b[3]
		else
			return a[4] > b[4]
		end
	end)
	
	local curr = time()
	local playerGUID = UnitGUID'player'
	
	local optType = VLegionToDo.opt_type[UnitGUID'player']
	local optData = VLegionToDo[optType == 1 and "opt" or optType == 2 and "opt_bfa" or "opt_sl"]

	local col = 0
	for _,db_sorted in pairs(sortedList) do
		local guid = db_sorted[1]
		local db = db_sorted[2]
		if not hidden[guid] and (guid==playerGUID or not VLegionToDo.black[guid]) then
			col = col + 1
			
			for i=1,#lines do
				if not lines[i].cols[col] then
					local t = LegionToDo.c2:CreateFontString(nil,"ARTWORK","GameFontWhite")
					t:SetPoint("TOPLEFT",(col-1)*93,-(i-1)*20)
					t:SetSize(90,18)
					t:SetShadowColor(0,0,0)
					t:SetShadowOffset(1,-1)
					
					t.line = lines[i]
					
					t.app = -1
					
					lines[i].cols[col] = t
				end
				
				local lineApp = lines[i].app			
				local t = lines[i].cols[col]
				if t.app ~= lineApp then
					if lineApp == 'small' then
						t:SetFont(t:GetFont(),10)
						t:SetSize(90,0)
						t:SetJustifyH("CENTER")
					elseif lineApp == 'small-left' then
						t:SetFont(t:GetFont(),10)
						t:SetSize(90,18)
						t:SetJustifyH("LEFT")
					elseif lineApp == 'small-left2' then
						t:SetFont(t:GetFont(),10)
						t:SetSize(90,20)
						t:SetJustifyH("LEFT")
						t:SetJustifyV("MIDDLE")
					elseif lineApp == 'center' then
						t:SetFont(GameFontWhite:GetFont())
						t:SetSize(90,18)
						t:SetJustifyH("CENTER")
					else
						t:SetFont(GameFontWhite:GetFont())
						t:SetSize(90,18)
						t:SetJustifyH("LEFT")
					end
					t.app = lineApp
				end
			end
			
			if not colNames[col] then
				colNames[col] = LegionToDo.c1:CreateFontString(nil,"ARTWORK","GameFontWhite")
				colNames[col]:SetPoint("TOPLEFT",(col-1)*93,0)
				colNames[col]:SetWidth(90)
				colNames[col]:SetJustifyH("CENTER")
				colNames[col]:SetFont(colNames[col]:GetFont(),10)
				
				local b = CreateFrame("Button",nil,LegionToDo)
				b:SetAllPoints(colNames[col])
				b.f = colNames[col]
				b:RegisterForClicks("AnyUp")
				b:SetScript("OnClick",function(s,b)
					local guidNow = s.f.guid
					local charName = db.name
					hidden[ guidNow ] = true
					if IsShiftKeyDown() or b == "RightButton" then
								VLegionToDo.black[ guidNow ] = true				
					end
					LegionToDo:Hide()
					LegionToDo:Show()
				end)
			end
			
			colNames[col].guid = guid
			
			colNames[col]:SetText(db.name.."|n"..db.realm)
			local classColorArray = type(CUSTOM_CLASS_COLORS)=="table" and CUSTOM_CLASS_COLORS[db.class] or RAID_CLASS_COLORS[db.class]
			if classColorArray then
				colNames[col]:SetTextColor(classColorArray.r,classColorArray.g,classColorArray.b)
			else
				colNames[col]:SetTextColor(.8,.8,.8)
			end
			
			local thursdayReset = GetCurrentRegion() == 2 and thursdayResetDay0EU or thursdayResetDay0US
			local currTime = GetServerTime()
			
			while thursdayReset < currTime do
				thursdayReset = thursdayReset + 604800
			end
			local prevReset = thursdayReset - 604800
			
			local needReset = false
			
			if db.t < prevReset then
				needReset = true
			end

			local thursdayReset = GetCurrentRegion() == 2 and thursdayResetDay0EU or thursdayResetDay0US
			while thursdayReset < currTime do
				thursdayReset = thursdayReset + 86400
			end
			local prevDailyReset = thursdayReset - 86400

			local needDailiyReset = false

			if db.t < prevDailyReset then
				needDailiyReset = true
			end


			local thursdayReset = GetCurrentRegion() == 2 and thursdayResetDay0EU or thursdayResetDay0US
			while thursdayReset < currTime do
				thursdayReset = thursdayReset + 302400
			end
			local prevHalfWeekReset = thursdayReset - 302400

			local needHalfWeekReset = false

			if db.t < prevHalfWeekReset then
				needHalfWeekReset = true
			end

			
			for i=1,#lines do
				if lines[i].cols[col] then
					lines[i].cols[col]:SetText("")
					if lines[i].cols[col].tooltip then
						lines[i].cols[col].tooltip:Hide()
					end
				end
			end
	
			local lineCount = 0
			if not optData["coins"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff00000/"..(isLevel48 and 3 or 2)..(db.coinsNow and " ["..db.coinsNow.."]" or ""))
				else
					lines[lineCount].cols[col]:SetText(format("|cff%s%d/%d [%d%s]",db.coinsWeek==(isLevel48 and 3 or 2) and "00ff00" or (db.coinsMax == db.coinsNow) and "ff8000" or "ff0000",db.coinsWeek or 0,isLevel48 and 3 or 2,db.coinsNow or 0,db.coinsMax == db.coinsNow and db.coinsMax and ",cap" or ""))
				end
			end
			
			if not optData["orderres"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.hallres or "0")
			end

			if not optData["orderres_bfa"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.hallres_bfa or "0")
			end
			
			if not optData["warsupp"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.warsuppl or "0")
			end	
			
			if not optData["nethershard"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.nethershard or "0")
			end	
			
			if not optData["amana"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.amana or "0")
			end
			
			if not optData["argunite"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.argunite or "0")
			end	
			
			if not optData["essence"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.essence or "0")
			end	

			if not optData["manapearl"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.manapearl or "0")
			end

			if not optData["echoon"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.echoon or "0")
			end

			if not optData["coalescing"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				local t = db.coalescing_bott or 0				
				lines[lineCount].cols[col]:SetText((db.coalescing or "0")..(t > 0 and " +"..t.."|T609893:0|t" or ""))
			end

			if not optData["mementos"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.mementos or "0")
			end

			if not optData["stygia"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.stygia or "0")
			end

			if not optData["soulash"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.soulash or "0")
			end

			if not optData["soulash91"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.soulash91 or "0")
			end

			if not optData["cosmicflux"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cosmicflux or "0")
			end

			if not optData["anima"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.anima or "0")
			end

			if not optData["rsouls"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.rsouls or "0")
			end

			if not optData["valor"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				if not db.valorMax or db.valorMax == 0 then
					lines[lineCount].cols[col]:SetText(db.valor or "0")
				else
					lines[lineCount].cols[col]:SetText((db.valor or "0") .. (db.valorEarned and ("\n" ..db.valorEarned.."/"..(db.valorMax or 0)) or ""))
				end
			end

			if not optData["towerknowledge"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText((db.towerknowledge or "0") .. (db.towerknowledgeEarned and ("\n" ..db.towerknowledgeEarned.."/"..(db.towerknowledgeMax or 0)) or ""))
			end

			if not optData["catalogedresearch"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.catalogedresearch or "0")
			end

			if not optData["stygianember"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.stygianember or "0")
			end

			if not optData["cyphers"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cyphers or "0")
			end

			if not optData["miniVision"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needDailiyReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					if db.miniVision == true then
						lines[lineCount].cols[col]:SetText("|cff00ff00Done")
					else
						lines[lineCount].cols[col]:SetText("|cffff0000Not done")
					end			
				end
			end

			if not optData["visionReward"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("470")
				else
					lines[lineCount].cols[col]:SetText(db.visionReward or "")
				end
			end	

			if not optData["cloak_lvl"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cloak_lvl or "-")
			end

			if not optData["cloak_res"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cloak_res or "-")
			end
			
			if not optData["argunitequest"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					if db.arguniteQuest == true then
						lines[lineCount].cols[col]:SetText("|cffff0000Not done")
					else
						lines[lineCount].cols[col]:SetText(db.arguniteQuest and db.arguniteQuest ~= "0/50" and db.arguniteQuest or "|cffff0000-")
					end
				else
					if db.arguniteQuest == true then
						lines[lineCount].cols[col]:SetText("|cff00ff00Done")
					else
						lines[lineCount].cols[col]:SetText(db.arguniteQuest or "|cffff0000-")
					end			
				end
			end	
			
			if not optData["riftquest"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					if db.riftQuest == true then
						lines[lineCount].cols[col]:SetText("|cffff0000Not done")
					else
						lines[lineCount].cols[col]:SetText(db.riftQuest and db.riftQuest ~= "0/3" and db.riftQuest or "|cffff0000-")
					end
				else
					if db.riftQuest == true then
						lines[lineCount].cols[col]:SetText("|cff00ff00Done")
					else
						lines[lineCount].cols[col]:SetText(db.riftQuest or "|cffff0000-")
					end			
				end
			end	
			
			if not optData["blood"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.blood or "0")
			end	
								
			if not optData["warmy"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				local wtraining = db.wtraining
				if db.wtrainingweek ~= floor((time() - witheredTrainingDay0) / days3val) then
					wtraining = nil
				end
				lines[lineCount].cols[col]:SetText(wtraining and "|cff00ff00Done" or "|cffff0000Not done")
			end
			
			if not optData["islands"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1				
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.island or "|cffff0000Not done")
				end				
			end

			if not optData["dublons"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1				
				lines[lineCount].cols[col]:SetText(db.dublons or "0")				
			end

			if not optData["service_medal"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1				
				lines[lineCount].cols[col]:SetText(db.service_medal or "0")
			end

			if not optData["residuum"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1				
				lines[lineCount].cols[col]:SetText(db.residuum or "0")
			end

			if not optData["warfront2"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.warfront2 and "|cff00ff00Done" or "|cffff0000Not done")				
			end
			if not optData["warfront"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.warfront and "|cff00ff00Done" or "|cffff0000Not done")				
			end
			if not optData["warfrontHC"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.warfrontHC and "|cff00ff00Done" or "|cffff0000Not done")				
			end

			if not optData["anima1k"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.anima1k and type(db.anima1k) == "string" and "|cffffff00"..db.anima1k or db.anima1k and "|cff00ff00Done" or "|cffff0000Not done")	
				end
			end

			if not optData["kortiaweekly"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.kortiaweekly and type(db.kortiaweekly) == "string" and "|cffffff00"..db.kortiaweekly or db.kortiaweekly and "|cff00ff00Done" or "|cffff0000Not done")	
				end
			end

			if not optData["patternswithinpatterns"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.patternswithinpatterns and type(db.patternswithinpatterns) == "string" and "|cffffff00"..db.patternswithinpatterns or db.patternswithinpatterns and "|cff00ff00Done" or "|cffff0000Not done")	
				end
			end

			if not optData["zerthworldboss"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.zerthworldboss and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["mawworldboss"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.mawworldboss and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["mawtormentor"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.mawtormentor and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["mawassault"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needHalfWeekReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.mawassault and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["wrathofthejailer"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.wrathofthejailer and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["mawhunt"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needHalfWeekReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.mawhunt and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end


			if not optData["korthialostresearch"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.korthialostresearch and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["zerthRares"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText("")
				
				local c = 0
				local tooltip = {[-1] = "Korthia Rares"}
				local res = db.zerthRares or 0
				for i=1,#zerthRaresList,3 do
					if not self.localizated then
						self.localizated = {}
					end
					if not self.localizated[ "mob"..zerthRaresList[i+1] ] then
						inspectScantip:SetHyperlink("unit:Creature-0-0-0-0-"..zerthRaresList[i+1])
						if inspectScantip:NumLines() > 0 then
							local name = _G["LegToDoScanningTooltipTextLeft1"]:GetText()
							self.localizated[ "mob"..zerthRaresList[i+1] ] = name
						end
						inspectScantip:ClearLines()
					end
					tooltip[#tooltip+1] = self.localizated[ "mob"..zerthRaresList[i+1] ] or zerthRaresList[i+2]
					if bit.band(res,bit.lshift(1,(i-1)/3)) > 0 and not needDailiyReset then
						c = c + 1

						tooltip[#tooltip+1] = "|cff00ff00Done"
					else
						tooltip[#tooltip+1] = "|cffff0000Not done"
					end
				end

				if c > 0 then
					lines[lineCount].cols[col]:SetText(c)
				end
				AddColTooltip(lines[lineCount].cols[col],tooltip)
			end

			if not optData["korthiaRares"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText("")
				
				local c = 0
				local tooltip = {[-1] = "Korthia Rares"}
				local res = db.korthiaRares or 0
				for i=1,#korthiaRaresList,3 do
					if not self.localizated then
						self.localizated = {}
					end
					if not self.localizated[ "mob"..korthiaRaresList[i+1] ] then
						inspectScantip:SetHyperlink("unit:Creature-0-0-0-0-"..korthiaRaresList[i+1])
						if inspectScantip:NumLines() > 0 then
							local name = _G["LegToDoScanningTooltipTextLeft1"]:GetText()
							self.localizated[ "mob"..korthiaRaresList[i+1] ] = name
						end
						inspectScantip:ClearLines()
					end
					tooltip[#tooltip+1] = self.localizated[ "mob"..korthiaRaresList[i+1] ] or korthiaRaresList[i+2]
					if bit.band(res,bit.lshift(1,(i-1)/3)) > 0 and not needDailiyReset then
						c = c + 1

						tooltip[#tooltip+1] = "|cff00ff00Done"
					else
						tooltip[#tooltip+1] = "|cffff0000Not done"
					end
				end

				if c > 0 then
					lines[lineCount].cols[col]:SetText(c)
				end
				AddColTooltip(lines[lineCount].cols[col],tooltip)
			end


			if not optData["missionTable"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText("")
				
				local tooltip = {[-1] = "Missions"}
				local done,total = 0,0
				if db.missionList then
					local res = {}
					for i=1,#db.missionList,2 do
						res[#res+1] = {db.missionList[i],db.missionList[i+1]}
					end
					sort(res,function(a,b)return a[1]<b[1] end)
					for i=1,#res do
						local obj = res[i]
						tooltip[#tooltip+1] = obj[2]
	
						local fin = max(obj[1]-time(),0)
						tooltip[#tooltip+1] = fin > 0 and format("|cffaaaaaa(in %d:%02d)|r |cffffff00%s|r",fin/3600,(fin%3600)/60,date("%X",obj[1])) or "|cff00ff00done|r"
						if fin == 0 then
							done = done + 1
						end
						total = total + 1
					end
					if db.missionFollowersCount then
						tooltip[#tooltip+1] = " "
						tooltip[#tooltip+1] = " "
						tooltip[#tooltip+1] = "Free followers:"
						tooltip[#tooltip+1] = (db.missionFollowersCount:find("^0/") and "|cffff0000" or "")..db.missionFollowersCount
					end
				end

				if total > 0 then
					lines[lineCount].cols[col]:SetText((done == 0 and "|cffff0000" or done == total and "|cff00ff00" or "|cffffff00")..done.."/"..total.."|r")
				end
				AddColTooltip(lines[lineCount].cols[col],tooltip)
			end

			if not optData["korthiaanimatablemission"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.korthiaanimatablemission and "|cff00ff00Done" or "|cffff0000Not done")	
				end			
			end

			if not optData["timewarped"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1				
				lines[lineCount].cols[col]:SetText(db.timewarped or "0")
			end
			
			if not optData["gold"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if db.gold then
					lines[lineCount].cols[col]:SetText(GetCoinTextureString(db.gold - db.gold % 10000))
				end
			end		
			
			for i=1,#instancesInOptions do
				if not optData["instance"..i] or OPTIONS_TOGGLED  then
					lineCount = lineCount + 1
					if needReset then
						lines[lineCount].cols[col]:SetText("|cffff0000---")
					else
						lines[lineCount].cols[col]:SetText(db["instance"..instancesInOptions[i]] or "")
					end
				end
			end

			if not optData["slreward"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				local tooltip = ""
				local rewardsCount = 0
				local rewardsDone = 1
				while db["sl_reward"..rewardsDone] do
					rewardsCount = rewardsCount + 1
					tooltip = tooltip .. db["sl_reward"..rewardsDone] .. "\n"
					rewardsDone = rewardsDone + 1
				end
				local rewardsCountProgress = 1
				while db["sl_reward"..rewardsCountProgress.."_progress"] do
					tooltip = tooltip .. db["sl_reward"..rewardsCountProgress.."_progress"] .. "\n"
					rewardsCountProgress = rewardsCountProgress + 1
				end

				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff00000/"..(db.sl_rewardMax or 9))
				else
					lines[lineCount].cols[col]:SetText("|cff"..(rewardsCount == 0 and "ff0000" or rewardsCount < (db.sl_rewardMax or 9) and "ffff00" or "00ff00")..rewardsCount.."/"..(db.sl_rewardMax or 9))
					AddColTooltip(lines[lineCount].cols[col],{[-1]=tooltip:gsub("\n$","")})
				end
			end
			
			--[[
			if not optData["mplusmax"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("0")
				else
					lines[lineCount].cols[col]:SetText(db.weeklymax or "0")
				end
			end
			]]
			
			if not optData["mpluskey"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("")
				else
					lines[lineCount].cols[col]:SetText(db.mkey or "")
				end
			end

			--[[
			if not optData["torghast"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000-")
				else
					lines[lineCount].cols[col]:SetText(db.torghast1 or "|cffff0000-")
				end

				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000-")
				else
					lines[lineCount].cols[col]:SetText(db.torghast2 or "|cffff0000-")
				end
			end
			]]

			if not optData["torghastav"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("")
				else
					lines[lineCount].cols[col]:SetText(db.torghastav and "|cff00ff00Done" or "|cffff0000Not done")
				end
			end

			if not optData["conq_points"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.conq or "")
			end

			if not optData["pvp_cache"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000Not done")
				else
					lines[lineCount].cols[col]:SetText(db.pvp_cache and "|cff00ff00Done" or "|cffff0000Not done")
				end
			end

			if not optData["honor"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.honor or "0")
			end
						
			if not optData["garmisstos"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				local mission_tos = db.s and db.s.mission_tos
				if mission_tos then
					while mission_tos < curr do
						mission_tos = mission_tos + (13 * 24 * 60 * 60)
					end
					lines[lineCount].cols[col]:SetText(date("%d.%m.%Y %H:%M",mission_tos))
				end
			end	
			
			if not optData["garmissabt"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				local mission_abt = db.s and db.s.mission_abt
				if mission_abt then
					while mission_abt < curr do
						mission_abt = mission_abt + (13 * 24 * 60 * 60)
					end
					lines[lineCount].cols[col]:SetText(date("%d.%m.%Y %H:%M",mission_abt))
				end	
			end
			
			if not optData["argusrecruits"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				if needReset then
					lines[lineCount].cols[col]:SetText("|cffff0000-|r/|cffff0000-|r/|cffff0000-|r")
				else
					lines[lineCount].cols[col]:SetText((db.argusRecruit1 and "|cff00ff00+|r" or "|cffff0000-|r").."/"..(db.argusRecruit2 and "|cff00ff00+|r" or "|cffff0000-|r").."/"..(db.argusRecruit3 and "|cff00ff00+|r" or "|cffff0000-|r"))
				end
			end
			
			for i=1,#raids do
				if not optData["raid"..i.."short"] or OPTIONS_TOGGLED  then
					lineCount = lineCount + 1
					local r = ""
					for j=1,#raidsDiffs do
						if needReset then
							r = r .. (j>1 and " - " or "").."|cffff00000|r"
						else
							local bossesDefeated = db["raid"..i.."_"..j] or 0
							if type(bossesDefeated)=='string' then
								bossesDefeated = tonumber( bossesDefeated:match("(%d+)/%d") or 0,nil ) or 0
							end
							r = r .. (j>1 and " - " or "").."|cff"..(bossesDefeated == raids_max_bosses[i] and "00ff00" or bossesDefeated == 0 and "ff0000" or "ffff00")..bossesDefeated.."|r"
						end
					end	
					lines[lineCount].cols[col]:SetText(r)	
				end
				if LFRInstances[i] and (not optData["raid"..i.."difflfr"] or OPTIONS_TOGGLED) then
					lineCount = lineCount + 1
					local r = ""
					for j=1,#LFRInstances[i] do
						if needReset then
							r = r .. (r~="" and "/" or "") .. "|cffff00000|r"
						else
							local bossesDefeated = db["raid"..i.."_lfr_"..j.."d"] or 0
							local bossesMax = db["raid"..i.."_lfr_"..j.."m"] or 0
							if bossesMax == 0 then
								r = r .. (r~="" and "/" or "") .. "|cffff00000|r"
							else
								r = r .. (r~="" and "/" or "") .. (bossesDefeated == bossesMax and "|cff00ff00" or bossesDefeated > 0 and "|cffffff00" or "|cffff0000") .. bossesDefeated .. "|r"
							end
						end					
					end
					local bossesDefeated = db["raid"..i.."_lfr"] or 0
					if needReset then
						bossesDefeated = 0
					end
					r = r .. " ["..bossesDefeated.."]"					
					
					lines[lineCount].cols[col]:SetText(r)
				end
				for j=1,#raidsDiffs do
					if not optData["raid"..i.."diff"..j] or OPTIONS_TOGGLED  then
						lineCount = lineCount + 1
						if needReset then
							lines[lineCount].cols[col]:SetText("|cffff00000/"..raids_max_bosses[i])
						else
							local bossesDefeated = db["raid"..i.."_"..j] or 0
							if type(bossesDefeated)=='string' then
								bossesDefeated = tonumber( bossesDefeated:match("(%d+)/%d") or 0,nil ) or 0
							end
							lines[lineCount].cols[col]:SetText("|cff"..(bossesDefeated == raids_max_bosses[i] and "00ff00" or bossesDefeated == 0 and "ff0000" or "ffff00")..bossesDefeated.."/"..raids_max_bosses[i])

							local tooltip = {}
							for k=1,raids_max_bosses[i] do
								local name = db["raid"..i.."_"..j.."_b"..k.."_n"]
								if name then
									tooltip[#tooltip+1] = name
									tooltip[#tooltip+1] = db["raid"..i.."_"..j.."_b"..k.."_s"] and "|cff00ff00Done" or "|cffff0000Not done"
								end
							end
							
							if #tooltip > 0 then
								tooltip[-1] = raids[i].." "..raidsDiffsNames[j]
								AddColTooltip(lines[lineCount].cols[col],tooltip)
							end
						end
					end
				end
			end

			if not optData["prof"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				if db.prof then
					lines[lineCount].cols[col]:SetText(db.prof:gsub(":0|",":18|"))
					AddColTooltip(lines[lineCount].cols[col],{[-1]=(db.prof1_name or "")..(db.prof1_name and db.prof2_name and " / " or "")..(db.prof2_name or "")})
				end
			end
			
			local currTime = time()
			for i=1,3 do
				if not optData["bounty"..i] or OPTIONS_TOGGLED  then
					lineCount = lineCount + 1
					local t = (db.s and db.s["bounty"..i] or ""):gsub(":0|t",":18|t")
					lines[lineCount].cols[col]:SetText(t)
					if db.s and db.s["bounty"..i] then
						if db.s and db.s["bounty"..i.."end"] and db.s["bounty"..i.."end"] < currTime then
							local icon = t:gsub("|t.*$","|t")
							lines[lineCount].cols[col]:SetText(icon.." |cffffff00expired")
						end
	
						local tooltip = {
							[-1]=(db.s and db.s["bounty"..i.."name"] or (db.s["bounty"..i.."id"] and C_TaskQuest.GetQuestInfoByQuestID(db.s["bounty"..i.."id"])) or ""),
						}
						if db.s and not db.s["bounty"..i.."notime"] then
							tooltip[#tooltip+1] = "Expire on"
							tooltip[#tooltip+1] = (db.s and db.s["bounty"..i.."end"] and date("%d/%m/%Y %H:%M:%S",db.s["bounty"..i.."end"]) or "")
						end
						AddColTooltip(lines[lineCount].cols[col],tooltip)
					elseif db.s and db.s["bounty"..i.."id"] then
						local qname = C_TaskQuest.GetQuestInfoByQuestID(db.s["bounty"..i.."id"])
						if qname then
							AddColTooltip(lines[lineCount].cols[col],{[-1]=qname})
						end
					end
				end
			end
			
			for i=1,#factionsToWatch do
				local factionID = factionsToWatch[i]			
				if not optData["faction"..factionID] or OPTIONS_TOGGLED then
					lineCount = lineCount + 1
					local r = ""
					if db["reputation"..factionID.."c"] then
						r = (db["reputation"..factionID.."p"] and (db["reputation"..factionID.."c"] >= db["reputation"..factionID.."m"]*1.8 and "|cffff00ff")or db["reputation"..factionID.."p"] and (db["reputation"..factionID.."c"] > db["reputation"..factionID.."m"] and "|cff00ff00" or "")or db["reputation"..factionID.."c"] == -36000 and "|cff666666"or "|cffffff00")..db["reputation"..factionID.."c"].."/"..db["reputation"..factionID.."m"]..(db["reputation"..factionID.."e"] and " ["..db["reputation"..factionID.."e"].."]" or "")
					
					end
					lines[lineCount].cols[col]:SetText(r)					
				
				end
			end

			if not optData["cov"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText("")
				
				local covenantID = db.cov
				local texture = covenantID == 1 and "shadowlands-landingbutton-kyrian-up" or
						covenantID == 2 and "shadowlands-landingbutton-venthyr-up" or
						covenantID == 3 and "shadowlands-landingbutton-NightFae-up" or
						covenantID == 4 and "shadowlands-landingbutton-necrolord-up"

				if texture then
					lines[lineCount].cols[col]:SetText(AtlasToText(texture,30,30))
					local covData = C_Covenants.GetCovenantData(covenantID)
					if covData then
						AddColTooltip(lines[lineCount].cols[col],{[-1]=covData.name})
					end
				else
					lines[lineCount].cols[col]:SetText("")
				end
			end
			if not optData["cov_tree"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cov_tree or "")
			end
			if not optData["cov_renown"] or OPTIONS_TOGGLED then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.cov_renown or "")
			end
			
			if not optData["warmode"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.warmode and "|cff00ff00"..PVP_WAR_MODE_ENABLED or "|cffffff00"..ADDON_DISABLED)
			end	
			
			if not optData["artlvl"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.artifact or "")
			end	
			
			if not optData["azeritelvl"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.azerite or "")
			end	

			if not optData["ilvl"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText(db.ilvl or "")
			end

			for k=1,2 do
				for j=1,3 do
					local name = "customcheck"..(k==1 and "d" or "w")..j
					if not optData[name] or OPTIONS_TOGGLED  then
						local state = false
						if k == 1 and not needDailiyReset and db and db.s and type(db.s[name]) == "number" and db.s[name] > prevDailyReset then
							state = true
						elseif k == 2 and not needReset and db and db.s and type(db.s[name]) == "number" and db.s[name] > prevReset then
							state = true
						end

						lineCount = lineCount + 1
						lines[lineCount].cols[col]:SetText(state and "|A:achievementcompare-GreenCheckmark:0:0|a" or "|A:groupfinder-icon-redx:0:0|a")

						AddColTooltip(lines[lineCount].cols[col],{[-1]="Click to change state",db=db and db.s,name=name,state=state},UpdateCustomCheck)
					end
				end	
			end

			if not optData["lastupate"] or OPTIONS_TOGGLED  then
				lineCount = lineCount + 1
				lines[lineCount].cols[col]:SetText((needReset and "|cffff0000" or "")..date("%d.%m.%Y %H:%M:%S",db.t))
			end	
		end
	end
	
	
	LINES_MAX = type(VLegionToDo.opt_height)=='number' and VLegionToDo.opt_height or LINES_MAX
	local isScrollShown = false
	if count > LINES_MAX then
		LegionToDo.f:SetPoint("TOPLEFT",16,-35)
		LegionToDo.f1:SetPoint("TOPLEFT",LegionToDo,LINE_WIDTH+16,-5)
		LegionToDo.leftScrollBar:Show()
		LegionToDo.leftScrollBar:SetMinMaxValues(0,(count - LINES_MAX) * 20)
		isScrollShown = true
	else
		LegionToDo.f:SetPoint("TOPLEFT",0,-35)
		LegionToDo.f1:SetPoint("TOPLEFT",LegionToDo,LINE_WIDTH,-5)
		LegionToDo.leftScrollBar:Hide()
		LegionToDo.f:SetVerticalScroll(0)
		LegionToDo.leftScrollBar:SetValue(0)
	end
	
	COLS_MAX = type(VLegionToDo.opt_width)=='number' and VLegionToDo.opt_width or COLS_MAX
	local isVScrollShown = false
	if col > COLS_MAX then
		LegionToDo.bottomScrollBar:Show()
		LegionToDo.f:SetPoint("BOTTOMRIGHT",0,5+16)
		LegionToDo.bottomScrollBar:SetMinMaxValues(0,(col - COLS_MAX) * 93)
		isVScrollShown = true
	else
		LegionToDo.bottomScrollBar:Hide()
		LegionToDo.f:SetPoint("BOTTOMRIGHT",0,5)
		LegionToDo.bottomScrollBar:SetValue(0)
	end
	
	LegionToDo:SetHeight(40 + 20*min(count,LINES_MAX) + (isVScrollShown and 16 or 0))
	LegionToDo.c:SetHeight(20 * count)
	LegionToDo.f2:SetHeight(20 * count)
	LegionToDo.c2:SetHeight(20 * count)
	
	LegionToDo:SetWidth(LINE_WIDTH + min(col,COLS_MAX)*93 + (isScrollShown and 16 or 0))
	LegionToDo.c:SetWidth(LINE_WIDTH+10+col * 93)
	LegionToDo.f2:SetWidth(col * 93)
	LegionToDo.c2:SetWidth(col * 93)
	
	for i=col+1,#colNames do
		colNames[i]:SetText("")
		for j=1,#lines do
			if lines[j].cols[i] then
				lines[j].cols[i]:SetText("")
			end
		end
	end
end)

--[[local MiniMapDropdown = CreateFrame("Frame", "LegionToDoMiniMapMenuFrame", nil, "UIDropDownMenuTemplate")
local menuTable = {
	{ text = "Legion ToDo", func = function() 
		CloseDropDownMenus() 
		wipe(hidden)
		LegionToDo:Hide()	
		LegionToDo:Show()
	end, notCheckable = true },
	{ text = RESET, func = function() 
		CloseDropDownMenus() 
		wipe(VLegionToDo.black)
		LegionToDo:Hide()	
		LegionToDo:Show()
	end, notCheckable = true, tooltipOnButton = 1, tooltipTitle = GetLocale() == "ruRU" and "Вновь показать всех скрытых прежде персонажей" or "Show all hidden chars" },
	{ text = CLOSE, func = function() CloseDropDownMenus() end, notCheckable = true },
}]]

MiniMapIcon:SetScript("OnMouseUp", function (self, button)
	--if button == "LeftButton" then
		wipe(hidden)
		if IsControlKeyDown() and IsShiftKeyDown() then
			LegionToDo.TempDiableBlack = true
		elseif IsShiftKeyDown() then
			wipe(VLegionToDo.black)
		end
		LegionToDo:Show()
	--else
		--EasyMenu(menuTable, MiniMapDropdown, "cursor", 10 , -15, "MENU")
	--end
end)

SlashCmdList["LTDSlash"] = function(arg)
	arg = arg:lower()
	if arg == "reset" then
		wipe(VLegionToDo.black)
		LegionToDo:Hide()
		LegionToDo:Show()
	else
		MiniMapIcon:GetScript("OnEnter")(MiniMapIcon)
		MiniMapIcon:GetScript("OnLeave")(MiniMapIcon)
		LegionToDo:Hide()
		LegionToDo:Show()		
	end
end
SLASH_LTDSlash1 = "/sltodo"
SLASH_LTDSlash2 = "/shadowlandstodo"

local function CreateDataBrokerPlugin(firstCall)
	if not LibStub or not LibStub:GetLibrary('LibDataBroker-1.1') then
		if firstCall then
			C_Timer.After(2,function()
				CreateDataBrokerPlugin()
			end)
		end
		return
	end
	local dataObject = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject('LegionToDo', {
		type = 'launcher',
		icon = "Interface\\ICONS\\Ability_IronMaidens_IronWill",
		OnClick = function()
			MiniMapIcon:GetScript("OnEnter")(MiniMapIcon)
			MiniMapIcon:GetScript("OnLeave")(MiniMapIcon)
			LegionToDo:Show()
		end,
		OnEnter = MiniMapIcon:GetScript("OnEnter"),
		OnLeave = MiniMapIcon:GetScript("OnLeave"),
	})
end
CreateDataBrokerPlugin(true)
