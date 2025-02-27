--[[
                                ----o----(||)----oo----(||)----o----

                                          Springfur Alpaca

                                      v2.07 - 8th January 2025
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved
								
                                ----o----(||)----oo----(||)----o----
]]

local SpringfurAlpaca = {}
SpringfurAlpaca.db = {}
-- From Data.lua
SpringfurAlpaca.points = {}
SpringfurAlpaca.textures = {}
SpringfurAlpaca.scaling = {}
SpringfurAlpaca.texturesSpecial = {}
SpringfurAlpaca.scalingSpecial = {}
-- Brown theme
SpringfurAlpaca.colour = {}
SpringfurAlpaca.colour.prefix	= "\124cFFD2691E"	-- X11Chocolate
SpringfurAlpaca.colour.highlight = "\124cFFF4A460"	-- X11SandyBrown
SpringfurAlpaca.colour.plaintext = "\124cFFDEB887"	-- X11BurlyWood

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true, iconChoice = 7, iconChoiceSpecial = 4 } }
local pluginHandler = {}

-- upvalues
local format, next, select = format, next, select
local gsub = string.gsub
local GameTooltip = _G.GameTooltip
local GetAuraDataByIndex = C_UnitAuras.GetAuraDataByIndex
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local HandyNotes = _G.HandyNotes

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Localisation
SpringfurAlpaca.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
SpringfurAlpaca.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			Yojamba = true, Remulos = true, Arugal = true, Felstriker = true,
			Penance = true, Shadowstrike = true, Maladath = true, }			
if SpringfurAlpaca.oceania[realm] then
	SpringfurAlpaca.locale = "enGB"
end

if SpringfurAlpaca.locale == "deDE" then
	L["Character"] = "Charakter"
	L["Account"] = "Accountweiter"
	L["Completed"] = "Abgeschlossen"
	L["Not Completed"] = "Nicht Abgeschlossen"
	L["Options"] = "Optionen"
	L["Map Pin Size"] = "Pin-Größe"
	L["The Map Pin Size"] = "Die Größe der Karten-Pins"
	L["Map Pin Alpha"] = "Kartenpin Alpha"
	L["The alpha transparency of the map pins"] = "Die Alpha-Transparenz der Karten-Pins"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..SpringfurAlpaca.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"
	L["Map Pin Selections"] = "Karten-Pin-Auswahl"
	L["Gold"] = "Gold"
	L["Red"] = "Rot"
	L["Blue"] = "Blau"
	L["Green"] = "Grün"
	L["Cross"] = "Kreuz"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Frost"
	L["Cogwheel"] = "Zahnrad"
	L["White"] = "Weiß"
	L["Purple"] = "Lila"
	L["Yellow"] = "Gelb"
	L["Grey"] = "Grau"
	L["Mana Orb"] = "Manakugel"
	L["Phasing"] = "Synchronisieren"
	L["Raptor egg"] = "Raptor-Ei"
	L["Stars"] = "Sternen"
	L["Screw"] = "Schraube"
	L["Notes"] = "Notizen"
	L["Left"] = "Links"
	L["Right"] = "Rechts"
	L["Try later"] = "Derzeit nicht möglich. Versuche es späte"

elseif SpringfurAlpaca.locale == "esES" or SpringfurAlpaca.locale == "esMX" then
	L["Character"] = "Personaje"
	L["Account"] = "la Cuenta"
	L["Completed"] = "Completado"
	L["Not Completed"] = ( SpringfurAlpaca.locale == "esES" ) and "Sin Completar" or "Incompleto"
	L["Options"] = "Opciones"
	L["Map Pin Size"] = "Tamaño de alfiler"
	L["The Map Pin Size"] = "Tamaño de los pines del mapa"
	L["Map Pin Alpha"] = "Alfa de los pines del mapa"
	L["The alpha transparency of the map pins"] = "La transparencia alfa de los pines del mapa"
	L["Icon Alpha"] = "Transparencia del icono"
	L["The alpha transparency of the icons"] = "La transparencia alfa de los iconos"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..SpringfurAlpaca.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"
	L["Map Pin Selections"] = "Selecciones de pines de mapa"
	L["Gold"] = "Oro"
	L["Red"] = "Rojo"
	L["Blue"] = "Azul"
	L["Green"] = "Verde"
	L["Ring"] = "Anillo"
	L["Cross"] = "Cruz"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Escarcha"
	L["Cogwheel"] = "Rueda dentada"
	L["White"] = "Blanco"
	L["Purple"] = "Púrpura"
	L["Yellow"] = "Amarillo"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de maná"
	L["Phasing"] = "Sincronización"	
	L["Raptor egg"] = "Huevo de raptor"	
	L["Stars"] = "Estrellas"
	L["Screw"] = "Tornillo"
	L["Notes"] = "Notas"
	L["Left"] = "Izquierda"
	L["Right"] = "Derecha"
	L["Try later"] = "No es posible en este momento. Intenta más tarde"

elseif SpringfurAlpaca.locale == "frFR" then
	L["Character"] = "Personnage"
	L["Account"] = "le Compte"
	L["Completed"] = "Achevé"
	L["Not Completed"] = "Non achevé"
	L["Options"] = "Options"
	L["Map Pin Size"] = "Taille des épingles"
	L["The Map Pin Size"] = "La taille des épingles de carte"
	L["Map Pin Alpha"] = "Alpha des épingles de carte"
	L["The alpha transparency of the map pins"] = "La transparence alpha des épingles de la carte"
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..SpringfurAlpaca.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"
	L["Map Pin Selections"] = "Sélections de broches de carte"
	L["Gold"] = "Or"
	L["Red"] = "Rouge"
	L["Blue"] = "Bleue"
	L["Green"] = "Vert"
	L["Ring"] = "Bague"
	L["Cross"] = "Traverser"
	L["Diamond"] = "Diamant"
	L["Frost"] = "Givre"
	L["Cogwheel"] = "Roue dentée"
	L["White"] = "Blanc"
	L["Purple"] = "Violet"
	L["Yellow"] = "Jaune"
	L["Grey"] = "Gris"
	L["Mana Orb"] = "Orbe de mana"
	L["Phasing"] = "Synchronisation"
	L["Raptor egg"] = "Œuf de Rapace"
	L["Stars"] = "Étoiles"
	L["Screw"] = "Vis"
	L["Notes"] = "Remarques"
	L["Left"] = "Gauche"
	L["Right"] = "Droite"
	L["Try later"] = "Pas possible pour le moment. Essayer plus tard"

elseif SpringfurAlpaca.locale == "itIT" then
	L["Character"] = "Personaggio"
	L["Completed"] = "Completo"
	L["Not Completed"] = "Non Compiuto"
	L["Options"] = "Opzioni"
	L["Map Pin Size"] = "Dimensione del pin"
	L["The Map Pin Size"] = "La dimensione dei Pin della mappa"
	L["Map Pin Alpha"] = "Mappa pin alfa"
	L["The alpha transparency of the map pins"] = "La trasparenza alfa dei pin della mappa"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..SpringfurAlpaca.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"
	L["Map Pin Selections"] = "Selezioni pin mappa"
	L["Gold"] = "Oro"
	L["Red"] = "Rosso"
	L["Blue"] = "Blu"
	L["Green"] = "Verde"
	L["Ring"] = "Squillo"
	L["Cross"] = "Attraverso"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Gelo"
	L["Cogwheel"] = "Ruota dentata"
	L["White"] = "Bianca"
	L["Purple"] = "Viola"
	L["Yellow"] = "Giallo"
	L["Grey"] = "Grigio"
	L["Mana Orb"] = "Globo di Mana"
	L["Phasing"] = "Sincronizzazione"
	L["Raptor egg"] = "Raptor Uovo"
	L["Stars"] = "Stelle"
	L["Screw"] = "Vite"
	L["Notes"] = "Note"
	L["Left"] = "Sinistra"
	L["Right"] = "Destra"
	L["Try later"] = "Non è possibile in questo momento. Prova più tardi"

elseif SpringfurAlpaca.locale == "koKR" then
	L["Character"] = "캐릭터"
	L["Account"] = "계정"
	L["Completed"] = "완료"
	L["Not Completed"] = "미완료"
	L["Map Pin Size"] = "지도 핀의 크기"
	L["Options"] = "설정"
	L["The Map Pin Size"] = "지도 핀의 크기"
	L["Map Pin Alpha"] = "지도 핀의 알파"
	L["The alpha transparency of the map pins"] = "지도 핀의 알파 투명도"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."
	L["Map Pin Selections"] = "지도 핀 선택"
	L["Gold"] = "금"
	L["Red"] = "빨간"
	L["Blue"] = "푸른"
	L["Green"] = "녹색"
	L["Ring"] = "반지"
	L["Cross"] = "십자가"
	L["Diamond"] = "다이아몬드"
	L["Frost"] = "냉기"
	L["Cogwheel"] = "톱니 바퀴"
	L["White"] = "화이트"
	L["Purple"] = "보라색"
	L["Yellow"] = "노랑"
	L["Grey"] = "회색"
	L["Mana Orb"] = "마나 보주"
	L["Phasing"] = "동기화 중"
	L["Raptor egg"] = "랩터의 알"
	L["Stars"] = "별"
	L["Screw"] = "나사"
	L["Notes"] = "메모"
	L["Left"] = "왼쪽"
	L["Right"] = "오른쪽"
	L["Try later"] = "지금은 불가능합니다. 나중에 시도하세요"

elseif SpringfurAlpaca.locale == "ptBR" or SpringfurAlpaca.locale == "ptPT" then
	L["Character"] = "Personagem"
	L["Account"] = "à Conta"
	L["Completed"] = "Concluído"
	L["Not Completed"] = "Não Concluído"
	L["Options"] = "Opções"
	L["Map Pin Size"] = "Tamanho do pino"
	L["The Map Pin Size"] = "O tamanho dos pinos do mapa"
	L["Map Pin Alpha"] = "Alfa dos pinos do mapa"
	L["The alpha transparency of the map pins"] = "A transparência alfa dos pinos do mapa"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..SpringfurAlpaca.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"
	L["Map Pin Selections"] = "Seleções de pinos de mapa"
	L["Gold"] = "Ouro"
	L["Red"] = "Vermelho"
	L["Blue"] = "Azul"
	L["Green"] = "Verde"
	L["Ring"] = "Anel"
	L["Cross"] = "Cruz"
	L["Diamond"] = "Diamante"
	L["Frost"] = "Gélido"
	L["Cogwheel"] = "Roda dentada"
	L["White"] = "Branco"
	L["Purple"] = "Roxa"
	L["Yellow"] = "Amarelo"
	L["Grey"] = "Cinzento"
	L["Mana Orb"] = "Orbe de Mana"
	L["Phasing"] = "Sincronização"
	L["Raptor egg"] = "Ovo de raptor"
	L["Stars"] = "Estrelas"
	L["Screw"] = "Parafuso"
	L["Notes"] = "Notas"
	L["Left"] = "Esquerda"
	L["Right"] = "Direita"
	L["Try later"] = "Não é possível neste momento. Tente depois"

elseif SpringfurAlpaca.locale == "ruRU" then
	L["Character"] = "Персонажа"
	L["Account"] = "Счет"
	L["Completed"] = "Выполнено"
	L["Not Completed"] = "Не Выполнено"
	L["Options"] = "Параметры"
	L["Map Pin Size"] = "Размер булавки"
	L["The Map Pin Size"] = "Размер булавок на карте"
	L["Map Pin Alpha"] = "Альфа булавок карты"
	L["The alpha transparency of the map pins"] = "Альфа-прозрачность булавок карты"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..SpringfurAlpaca.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"
	L["Map Pin Selections"] = "Выбор булавки карты"
	L["Gold"] = "Золото"
	L["Red"] = "Красный"
	L["Blue"] = "Синий"
	L["Green"] = "Зеленый"
	L["Ring"] = "Звенеть"
	L["Cross"] = "Крест"
	L["Diamond"] = "Ромб"
	L["Frost"] = "Лед"
	L["Cogwheel"] = "Зубчатое колесо"
	L["White"] = "белый"
	L["Purple"] = "Пурпурный"
	L["Yellow"] = "Желтый"
	L["Grey"] = "Серый"
	L["Mana Orb"] = "Cфера маны"
	L["Phasing"] = "Синхронизация"
	L["Raptor egg"] = "Яйцо ящера"
	L["Stars"] = "Звезды"
	L["Screw"] = "Винт"
	L["Notes"] = "Примечания"
	L["Left"] = "Налево"
	L["Right"] = "Направо"
	L["Try later"] = "В настоящее время это невозможно. Попробуй позже"

elseif SpringfurAlpaca.locale == "zhCN" then
	L["Character"] = "角色"
	L["Account"] = "账号"
	L["Completed"] = "已完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "选项"
	L["Map Pin Size"] = "地图图钉的大小"
	L["The Map Pin Size"] = "地图图钉的大小"
	L["Map Pin Alpha"] = "地图图钉的透明度"
	L["The alpha transparency of the map pins"] = "地图图钉的透明度"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..SpringfurAlpaca.colour.highlight .."显示坐标"
	L["Map Pin Selections"] = "地图图钉选择"
	L["Gold"] = "金子"
	L["Red"] = "红"
	L["Blue"] = "蓝"
	L["Green"] = "绿色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "冰霜"
	L["Cogwheel"] = "齿轮"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黄色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龙蛋"
	L["Stars"] = "星星"
	L["Screw"] = "拧"
	L["Notes"] = "笔记"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍后再试"

elseif SpringfurAlpaca.locale == "zhTW" then
	L["Character"] = "角色"
	L["Account"] = "賬號"
	L["Completed"] = "完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "選項"
	L["Map Pin Size"] = "地圖圖釘的大小"
	L["The Map Pin Size"] = "地圖圖釘的大小"
	L["Map Pin Alpha"] = "地圖圖釘的透明度"
	L["The alpha transparency of the map pins"] = "地圖圖釘的透明度"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..SpringfurAlpaca.colour.highlight .."顯示坐標"
	L["Map Pin Selections"] = "地圖圖釘選擇"
	L["Gold"] = "金子"
	L["Red"] = "紅"
	L["Blue"] = "藍"
	L["Green"] = "綠色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "霜"
	L["Cogwheel"] = "齒輪"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黃色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龍蛋"
	L["Stars"] = "星星"
	L["Screw"] = "擰"
	L["Notes"] = "筆記"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍後再試"

else
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	L["Try later"] = "Not possible at this time. Try later"
	if SpringfurAlpaca.locale == "enUS" then
		L["Grey"] = "Gray"
	end
end

SpringfurAlpaca.name = UnitName( "player" ) or "Character"

if SpringfurAlpaca.locale == "deDE" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Hilft Ihnen, das " ..SpringfurAlpaca.colour.prefix
		.."Frühlingsfell-Alpaka" ..SpringfurAlpaca.colour.highlight .." in Uldum zu erhalten"
	L["Alpaca It In"] = "Wir alpaken's dann mal"
	L["Alpaca It Up"] = "Rackern fürs Alpaka"
	L["Correct Map"] = "Sie sehen die richtige Karte"
	L["Daily Quest"] = "Tägliche Aufgabe"
	L["Gersahl Greens"] = "Gersahlblätter"
	L["Go to Uldum"] = "Gehe nach Uldum"
	L["Incorrect Map"] = "Sie sehen die falsche Karte"
	L["of"] = "@ von #"
	L["Speak to Zidormi"] = "Sprich mit Zidormi"
	L["Springfur Alpaca"] = "Frühlingsfellalpaka"
	L["Uldum Map"] = "Uldum-Karte"
	L["Wrong version of Uldum"] = "@ ist in der falschen Version von Uldum"
	
elseif SpringfurAlpaca.locale == "esES" or SpringfurAlpaca.locale == "esMX" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Te ayuda a obtener " ..SpringfurAlpaca.colour.prefix
		.."el Alpaca de pelaje primaveral" ..SpringfurAlpaca.colour.highlight .." en Uldum"
	L["Alpaca It In"] = "Hay una alpaca en ti"
	L["Alpaca It Up"] = "Una alpaca de traca"
	L["Correct Map"] = "Estás mirando el mapa correcto."
	L["Daily Quest"] = "Búsqueda Diaria"
	L["Gersahl Greens"] = "Verduras Gersahl"
	L["Go to Uldum"] = "Ir a Uldum"
	L["Incorrect Map"] = "Estás mirando el mapa incorrecto."
	L["of"] = "@ de #"
	L["Speak to Zidormi"] = "Hablar con Zidormi"
	L["Springfur Alpaca"] = "Alpaca de pelaje primaveral"
	L["Uldum Map"] = "Mapa de Uldum"
	L["Wrong version of Uldum"] = "@ está en la versión incorrecta de Uldum"

elseif SpringfurAlpaca.locale == "frFR" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Vous aide à obtenir " ..SpringfurAlpaca.colour.prefix
		.."l'alpaga toison-vernale" ..SpringfurAlpaca.colour.highlight .." à Uldum"
	L["Alpaca It In"] = "Alpaga alpagué"
	L["Alpaca It Up"] = "Alpaga gavé"
	L["Correct Map"] = "Vous regardez la bonne carte"
	L["Daily Quest"] = "Quêtes Journalières"
	L["Gersahl Greens"] = "Légume de Gersahl"
	L["Go to Uldum"] = "Aller à Uldum"
	L["Incorrect Map"] = "Vous regardez la mauvaise carte"
	L["of"] = "@ sur #"
	L["Speak to Zidormi"] = "Parlez à Zidormi"
	L["Springfur Alpaca"] = "Alpaga toison-vernale"
	L["Uldum Map"] = "Carte de Uldum"
	L["Wrong version of Uldum"] = "@ est dans la mauvaise version d'Uldum"

elseif SpringfurAlpaca.locale == "itIT" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Ti aiuta a ottenere " ..SpringfurAlpaca.colour.prefix
		.."Alpaca Primopelo" ..SpringfurAlpaca.colour.highlight .." a Uldum"
	L["Alpaca It In"] = "Alpaca 1, Alpaca 2"
	L["Alpaca It Up"] = "Io sono Alpaca"
	L["Correct Map"] = "Stai guardando la mappa corretta"
	L["Daily Quest"] = "Missione Giornaliera"
	L["Gersahl Greens"] = "Insalata di Gersahl"
	L["Go to Uldum"] = "Vai a Uldum"
	L["Incorrect Map"] = "Stai guardando la mappa sbagliata"
	L["of"] = "@ di #"
	L["Speak to Zidormi"] = "Parla con Zidormi"
	L["Springfur Alpaca"] = "Alpaca Primopelo"
	L["Uldum Map"] = "Mappa di Uldum"
	L["Wrong version of Uldum"] = "@ è nella versione sbagliata di Uldum"

elseif SpringfurAlpaca.locale == "koKR" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."울둠에서 " ..SpringfurAlpaca.colour.prefix .."봄털 알파카"
		..SpringfurAlpaca.colour.highlight .."를 얻는 데 도움이 됩니다."
	L["Alpaca It In"] = "알파카 출동!"
	L["Alpaca It Up"] = "알파카만 믿으라고"
	L["Correct Map"] = "당신은 올바른 지도를 보고 있습니다."
	L["Daily Quest"] = "일일 퀘스트"
	L["Gersahl Greens"] = "게샬 채소"
	L["Go to Uldum"] = "울둠으로 이동"
	L["Incorrect Map"] = "당신은 잘못된 지도를 보고 있습니다."
	L["of"] = "#개 중 @개"
	L["Speak to Zidormi"] = "지도르미님과 대화"
	L["Springfur Alpaca"] = "봄털 알파카"
	L["Uldum Map"] = "울둠 지도"
	L["Wrong version of Uldum"] = "@는 잘못된 버전의 울둠을 사용하고 있습니다."

elseif SpringfurAlpaca.locale == "ptBR" or SpringfurAlpaca.locale == "ptPT" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Ajuda você a obter o " ..SpringfurAlpaca.colour.prefix
		.."Alpaca Lã de Primavera" ..SpringfurAlpaca.colour.highlight .." em Uldum"
	L["Alpaca It In"] = "Alpaca pacas"
	L["Alpaca It Up"] = "Alpaca papa"
	L["Correct Map"] = "Você está olhando para o mapa correto"
	L["Daily Quest"] = "Missão Diária"
	L["Gersahl Greens"] = "Folhas de Gersahl"
	L["Go to Uldum"] = "Vá para Uldum"
	L["Incorrect Map"] = "Você está olhando para o mapa incorreto"
	L["of"] = "@ de #"
	L["Speak to Zidormi"] = "Fale com Zidormi"
	L["Springfur Alpaca"] = "Alpaca Lã de Primavera"
	L["Uldum Map"] = "Mapa de Uldum"
	L["Wrong version of Uldum"] = "@ está na versão errada do Uldum"

elseif SpringfurAlpaca.locale == "ruRU" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Помогает вам получить " ..SpringfurAlpaca.colour.prefix
		.."Курчавая альпака" ..SpringfurAlpaca.colour.highlight .." в Ульдум"
	L["Alpaca It In"] = "Альпачиный взгляд"
	L["Alpaca It Up"] = "Добряк среди альпак"
	L["Correct Map"] = "Вы смотрите на правильную карту"
	L["Daily Quest"] = "Ежедневный Квест"
	L["Gersahl Greens"] = "Побеги герсали"
	L["Go to Uldum"] = "Отправиться в Ульдум"
	L["Incorrect Map"] = "Вы смотрите на неправильную карту"
	L["of"] = "@ из #"
	L["Speak to Zidormi"] = "Поговори с Зидорми"
	L["Springfur Alpaca"] = "Курчавая альпака"
	L["Uldum Map"] = "Карта Ульдума"
	L["Wrong version of Uldum"] = "@ находится в неправильной версии Ульдума"

elseif SpringfurAlpaca.locale == "zhCN" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."帮助您获取奥丹姆中的" ..SpringfurAlpaca.colour.prefix .."春裘羊驼"
	L["Alpaca It In"] = "Alpaca It In" -- No Translation available at Wowhead
	L["Alpaca It Up"] = "羊驼要吃饱"
	L["Correct Map"] = "您正在查看正确的地图"
	L["Daily Quest"] = "日常"
	L["Gersahl Greens"] = "基萨尔野菜"
	L["Go to Uldum"] = "前往奥丹姆"
	L["Incorrect Map"] = "您正在查看错误的地图"
	L["of"] = "@ 共 # 个"
	L["Speak to Zidormi"] = "与 希多尔米 通话"
	L["Springfur Alpaca"] = "春裘羊驼"
	L["Uldum Map"] = "奥丹姆地图"
	L["Wrong version of Uldum"] = "@在奥丹姆的版本错误"

elseif SpringfurAlpaca.locale == "zhTW" then
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."幫助您獲取奧丹姆中的" ..SpringfurAlpaca.colour.prefix .."春裘羊駝"
	L["Alpaca It In"] = "Alpaca It In" -- See for simplified. Traditional is a direct translation of that
	L["Alpaca It Up"] = "羊駝要吃飽"
	L["Correct Map"] = "您正在查看正確的地圖"
	L["Daily Quest"] = "每日"
	L["Gersahl Greens"] = "肉荳蔻蔬菜"
	L["Go to Uldum"] = "前往奧丹姆"
	L["Incorrect Map"] = "您正在查看不正確的地圖"
	L["of"] = "@ 共 # 個"
	L["Speak to Zidormi"] = "與 希多爾米 通話"
	L["Springfur Alpaca"] = "春裘羊駝"
	L["Uldum Map"] = "奧丹姆地圖"
	L["Wrong version of Uldum"] = "@在奧丹姆的版本錯誤"
	
else
	L["AddOn Description"] = SpringfurAlpaca.colour.highlight .."Helps you to obtain the " ..SpringfurAlpaca.colour.prefix
		.."Springfur Alpaca" ..SpringfurAlpaca.colour.highlight .." in Uldum"
	L["Correct Map"] = "You are looking at the correct map"
	L["Incorrect Map"] = "You are looking at the incorrect map"
	L["of"] = "@ of #"
	L["Wrong version of Uldum"] = "@ is in the wrong version of Uldum"
end

-- ---------------------------------------------------------------------------------------------------------------------------------

local function VersionOfUldum()

	-- C_Map.GetBestMapForUnit( "player" ) == 249 would also work I'd think?
	-- Memory says that patches ago when doing this I got abends when jumping
	-- in and out of instances and trying to show a map using that code
	for i = 1, 40 do
		local auraData = GetAuraDataByIndex( "player", i )
		if auraData == nil then break end
		for k,v in pairs( auraData ) do
			if k == "spellId" then
				if ( v == 317785 ) then -- Zidormi buff to see the Cataclysm / Old Uldum
					return true
				end
			end
		end
	end
	return false
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter( mapFile, coord )
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
	else
		GameTooltip:SetOwner( self, "ANCHOR_RIGHT" )
	end

	local pin = SpringfurAlpaca.points[ mapFile ] and SpringfurAlpaca.points[ mapFile ][ coord ]
	
	if pin.alpaca then
		GameTooltip:SetText( SpringfurAlpaca.colour.prefix ..L["Springfur Alpaca"] )
		
		if ( SpringfurAlpaca.mapID == 12 ) or ( SpringfurAlpaca.mapID == 947 ) then
			GameTooltip:AddLine( L["Go to Uldum"] .."\n\n" )
		end
		
		local completed = C_QuestLog.IsQuestFlaggedCompleted( 58887 )
		GameTooltip:AddDoubleLine( SpringfurAlpaca.colour.highlight ..L["Alpaca It In"],
			( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..SpringfurAlpaca.name ..")" ) 
								or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..SpringfurAlpaca.name ..")" ) )
		
		if ( completed == false ) then
			--GameTooltip:AddLine( " " )
			completed = C_QuestLog.IsQuestFlaggedCompleted( 58879 )
			GameTooltip:AddLine( "\124cFF1F45FC".. L["Daily Quest"] )
			GameTooltip:AddDoubleLine( SpringfurAlpaca.colour.highlight ..L["Alpaca It Up"],
				( completed == true ) and ( "\124cFF00FF00" ..L["Completed"] .." (" ..SpringfurAlpaca.name ..")" ) 
									or ( "\124cFFFF0000" ..L["Not Completed"] .." (" ..SpringfurAlpaca.name ..")" ) )
			if ( completed == false ) then
				local questText = GetQuestObjectiveInfo( 58879, 1, false )
				if questText then
					GameTooltip:AddDoubleLine( " ", SpringfurAlpaca.colour.plaintext ..questText )
				else
					-- Yeah I got a nil result while thrash testing
					GameTooltip:AddLine( "\124cFFFF0000" ..PERKS_PROGRAM_SERVER_ERROR )
				end
			end
			
			local _, _, _, fulfilled, required = GetQuestObjectiveInfo( 58881, 0, false )
			local progress = L["of"]
			if fulfilled then
				progress = string.gsub( progress, "@", fulfilled )
				progress = string.gsub( progress, "#", required )
				GameTooltip:AddLine( SpringfurAlpaca.colour.highlight .."(" ..progress ..")" )
			else
				GameTooltip:AddLine( "\124cFFFF0000" ..PERKS_PROGRAM_SERVER_ERROR )
			end
		end
		
	elseif pin.gersahlGreens then
		GameTooltip:SetText( SpringfurAlpaca.colour.prefix ..L["Gersahl Greens"] )
		
	else
		GameTooltip:SetText( SpringfurAlpaca.colour.prefix ..L["Springfur Alpaca"] )
		if ( VersionOfUldum() == true ) then
			GameTooltip:AddLine( SpringfurAlpaca.colour.highlight ..L["Speak to Zidormi"] .." (56.02,35.14)\n" )
			local version = string.gsub( L["Wrong version of Uldum"], "@", SpringfurAlpaca.name )
			GameTooltip:AddLine( SpringfurAlpaca.colour.highlight ..version )
		end
		if SpringfurAlpaca.mapID == 1527 then
			GameTooltip:AddLine( SpringfurAlpaca.colour.plaintext .."\n" ..L["Correct Map"] )
		else
			GameTooltip:AddLine( SpringfurAlpaca.colour.plaintext .."\n" ..L["Incorrect Map"] )
		end
	end

	if ( SpringfurAlpaca.db.showCoords == true ) and ( SpringfurAlpaca.mapID ~= 12 ) and ( SpringfurAlpaca.mapID ~= 947 ) then
		--GameTooltip:AddLine( " " )
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( SpringfurAlpaca.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

do
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)
		while coord do
			if pin then
				if pin.alpaca or ( SpringfurAlpaca.mapID == 12 ) or ( SpringfurAlpaca.mapID == 947 ) then
					return coord, nil, SpringfurAlpaca.textures[SpringfurAlpaca.db.iconChoice],
							SpringfurAlpaca.db.iconScale * SpringfurAlpaca.scaling[SpringfurAlpaca.db.iconChoice], SpringfurAlpaca.db.iconAlpha
				elseif pin.gersahlGreens then
					return coord, nil, SpringfurAlpaca.texturesSpecial[SpringfurAlpaca.db.iconChoiceSpecial],
							SpringfurAlpaca.db.iconScale * SpringfurAlpaca.scalingSpecial[SpringfurAlpaca.db.iconChoiceSpecial], SpringfurAlpaca.db.iconAlpha
				else
					if ( VersionOfUldum() == true ) or ( SpringfurAlpaca.mapID ~= 1527 ) then 
						return coord, nil, SpringfurAlpaca.texturesSpecial[ 5 ], -- Red Cross and * 3 to make it big!
							SpringfurAlpaca.db.iconScale * SpringfurAlpaca.scalingSpecial[ 5 ] * 3, SpringfurAlpaca.db.iconAlpha
					end
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		SpringfurAlpaca.mapID = mapID
		return iterator, SpringfurAlpaca.points[mapID]
	end
end

-- ---------------------------------------------------------------------------------------------------------------------------------

-- Interface -> Addons -> Handy Notes -> Plugins -> Springfur Alpaca options
SpringfurAlpaca.options = {
	type = "group",
	name = L["Springfur Alpaca"],
	desc = L["AddOn Description"],
	get = function(info) return SpringfurAlpaca.db[info[#info]] end,
	set = function(info, v)
		SpringfurAlpaca.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..L["Options"],
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = L["Map Pin Size"],
					desc = L["The Map Pin Size"],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = L["Map Pin Alpha"],
					desc = L["The alpha transparency of the map pins"],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..SpringfurAlpaca.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconChoice = {
					type = "range",
					name = L["Springfur Alpaca"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconChoice",
					order = 10,
				},
				iconChoiceSpecial = {
					type = "range",
					name = L["Gersahl Greens"],
					desc = "1 = " ..L["Ring"] .." - " ..L["Gold"] .."\n2 = " ..L["Ring"] .." - " ..L["Red"] 
							.."\n3 = " ..L["Ring"] .." - " ..L["Blue"] .."\n4 = " ..L["Ring"] .." - " 
							..L["Green"] .."\n5 = " ..L["Cross"] .." - " ..L["Red"] .."\n6 = "
							..L["Diamond"] .." - " ..L["White"] .."\n7 = " ..L["Frost"] .."\n8 = " 
							..L["Cogwheel"] .."\n9 = " ..L["Screw"],
					min = 1, max = 9, step = 1,
					arg = "iconChoiceSpecial",
					order = 11,
				},
			},
		},
		notes = {
			type = "group",
			name = L["Notes"],
			inline = true,
			args = {
				noteMenu = { type = "description", name = "A shortcut to open this panel is via the Minimap"
					.." AddOn menu, which is immediately below the Calendar icon.\n\n"
					..NORMAL_FONT_COLOR_CODE .."Mouse " ..L["Left"] ..": " ..HIGHLIGHT_FONT_COLOR_CODE
					.."This panel\n" ..NORMAL_FONT_COLOR_CODE .."Mouse " ..L["Right"] ..": "
					..HIGHLIGHT_FONT_COLOR_CODE .."Show the " ..L["Uldum Map"], order = 20, },
				separator1 = { type = "header", name = "", order = 21, },
				noteChat = { type = "description", name = "Chat command shortcuts are also supported.\n\n"
					..NORMAL_FONT_COLOR_CODE .."/sa" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show this panel\n"
					..NORMAL_FONT_COLOR_CODE .."/sa ?" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show the chat options menu\n"
					..NORMAL_FONT_COLOR_CODE .."/sa m" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show " ..L["Uldum Map"],
					order = 22, },
			},
		},
	},
}

-- ---------------------------------------------------------------------------------------------------------------------------------

function HandyNotes_SpringfurAlpaca_OnAddonCompartmentClick(addonName, buttonName )
	if buttonName and buttonName == "RightButton" then
		OpenWorldMap( 1527 )
		if WorldMapFrame:IsVisible() ~= true then
			print( SpringfurAlpaca.colour.prefix	..L["Springfur Alpaca"] ..": " ..SpringfurAlpaca.colour.plaintext ..L["Try later"] )
		end
	else
		Settings.OpenToCategory( "HandyNotes" )
		LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "SpringfurAlpaca" )
	end
end
 
function HandyNotes_SpringfurAlpaca_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( SpringfurAlpaca.colour.prefix ..L["Springfur Alpaca"] )
	GameTooltip:AddLine( SpringfurAlpaca.colour.highlight .." " )
	GameTooltip:AddDoubleLine( SpringfurAlpaca.colour.highlight ..L["Left"], SpringfurAlpaca.colour.plaintext ..L["Options"] )
	GameTooltip:AddDoubleLine( SpringfurAlpaca.colour.highlight ..L["Right"], SpringfurAlpaca.colour.plaintext ..L["Uldum Map"] )
	GameTooltip:Show()
end

function HandyNotes_SpringfurAlpaca_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

-- ---------------------------------------------------------------------------------------------------------------------------------

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	HandyNotes:RegisterPluginDB("SpringfurAlpaca", pluginHandler, SpringfurAlpaca.options)
	SpringfurAlpaca.db = LibStub("AceDB-3.0"):New("HandyNotes_SpringfurAlpacaDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "SpringfurAlpaca")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_SpringfurAlpacaDB", "AceEvent-3.0")

-- ---------------------------------------------------------------------------------------------------------------------------------

SLASH_SpringfurAlpaca1, SLASH_SpringfurAlpaca2, SLASH_SpringfurAlpaca3 = "/sa", "/sfa", "/alpaca"

local function Slash( options )

	if ( options == "" ) then
		Settings.OpenToCategory( "HandyNotes" )
		LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "SpringfurAlpaca" )
	elseif ( options == "m" ) then
		OpenWorldMap( 1527 )
		if WorldMapFrame:IsVisible() ~= true then
			print( SpringfurAlpaca.colour.prefix	..L["Springfur Alpaca"] ..": " ..SpringfurAlpaca.colour.plaintext ..L["Try later"] )
		end
	else
		print( SpringfurAlpaca.colour.prefix ..L["Options"] ..":\n"
				..SpringfurAlpaca.colour.highlight .."/sa" ..SpringfurAlpaca.colour.plaintext .." Show the HandyNotes options panel\n"
				..SpringfurAlpaca.colour.highlight .."/sa ?" ..SpringfurAlpaca.colour.plaintext .." Show this menu\n"
				..SpringfurAlpaca.colour.highlight .."/sa m" ..SpringfurAlpaca.colour.plaintext .." Show " ..L["Uldum Map"] )
		--if ( SpringfurAlpaca.version >= 100000 ) then
			print( SpringfurAlpaca.colour.prefix .."Tip:" ..SpringfurAlpaca.colour.highlight
				.." Try the Minimap AddOn Menu (below the Calendar)\n" ..L["Left"] .." Mouse:"
				..SpringfurAlpaca.colour.plaintext .." HN options panel; " ..SpringfurAlpaca.colour.highlight ..L["Right"] .." Mouse: "
				..SpringfurAlpaca.colour.plaintext ..L["Uldum Map"] )
		--end
	end
end

SlashCmdList[ "SpringfurAlpaca" ] = function( options ) Slash( options ) end

local points = SpringfurAlpaca.points
local textures = SpringfurAlpaca.textures
local scaling = SpringfurAlpaca.scaling
local texturesSpecial = SpringfurAlpaca.texturesSpecial
local scalingSpecial = SpringfurAlpaca.scalingSpecial

	
points[ 249 ] = {
	[22004500] = { testUldum=true },	
}
points[ 1527 ] = {
	[22004500] = { testUldum=true },	

	[14546125] = { alpaca=true },
	[14666226] = { alpaca=true },
	[15006152] = { alpaca=true },
	[15096237] = { alpaca=true },
	[15236207] = { alpaca=true },	
	[15266171] = { alpaca=true },
	
	[23960988] = { alpaca=true },
	[24290855] = { alpaca=true },
	[24640898] = { alpaca=true },
	[24860978] = { alpaca=true },
	[24990963] = { alpaca=true },
	
	[27374909] = { alpaca=true },
	[27574936] = { alpaca=true },
	[27984805] = { alpaca=true },
	[28204838] = { alpaca=true },
	[28224957] = { alpaca=true },
	[28364936] = { alpaca=true },
	
	[30212913] = { alpaca=true },
	[30322822] = { alpaca=true },
	[30802815] = { alpaca=true },
	[30922842] = { alpaca=true },

	[38480909] = { alpaca=true },
	[38860892] = { alpaca=true },
	[39130981] = { alpaca=true },
	[39150894] = { alpaca=true },
	[39400940] = { alpaca=true },
	[38621018] = { alpaca=true },
	
	[42107031] = { alpaca=true },
	[42207055] = { alpaca=true },
	[42317074] = { alpaca=true },
	[42517011] = { alpaca=true },
	[42567021] = { alpaca=true },
	[42796999] = { alpaca=true },
		
	[45804815] = { alpaca=true },
	[45864857] = { alpaca=true },
	[46354906] = { alpaca=true },
	[46454771] = { alpaca=true },
	[46454877] = { alpaca=true },	

	[52661855] = { alpaca=true },
	[52841952] = { alpaca=true },
	[53111960] = { alpaca=true },
	[53381903] = { alpaca=true },
	[53581838] = { alpaca=true },

	[55006992] = { alpaca=true },
	[55036926] = { alpaca=true },
	[55327034] = { alpaca=true },
	[55566983] = { alpaca=true },
	[55687063] = { alpaca=true },
	[55817028] = { alpaca=true },
	
	[62841464] = { alpaca=true },
	[63161400] = { alpaca=true },
	[63231551] = { alpaca=true },
	[63501544] = { alpaca=true },
	[64281476] = { alpaca=true },

	[63125259] = { alpaca=true },
	[63375298] = { alpaca=true },
	[63505250] = { alpaca=true },
	[63625258] = { alpaca=true },
	[63765217] = { alpaca=true },
		
	[69883949] = { alpaca=true },
	[69974005] = { alpaca=true },
	[70003925] = { alpaca=true },	
	[70363963] = { alpaca=true },
	[70413862] = { alpaca=true },
	[70473911] = { alpaca=true },
	
	[76006798] = { alpaca=true },
	[76036747] = { alpaca=true },
	[76296708] = { alpaca=true },
	[76666833] = { alpaca=true },
	[76766816] = { alpaca=true },
	
	[57408500] = { gersahlGreens=true },
	[59008530] = { gersahlGreens=true },
	[61608290] = { gersahlGreens=true },
	[59107440] = { gersahlGreens=true },
	[59105930] = { gersahlGreens=true },
	[72207630] = { gersahlGreens=true },
	[71107880] = { gersahlGreens=true },
	[70007680] = { gersahlGreens=true },
	[64707940] = { gersahlGreens=true },
	[68907310] = { gersahlGreens=true },
	[64707250] = { gersahlGreens=true },
	[65006880] = { gersahlGreens=true },
	[60706020] = { gersahlGreens=true },
	[58504050] = { gersahlGreens=true },
	[51204430] = { gersahlGreens=true },
	[59607880] = { gersahlGreens=true },
	[58706580] = { gersahlGreens=true },
	[59305130] = { gersahlGreens=true },
	[56005120] = { gersahlGreens=true },
	[59603420] = { gersahlGreens=true },
	[59102880] = { gersahlGreens=true },
	[57302500] = { gersahlGreens=true },
	[57502000] = { gersahlGreens=true },
	[58601640] = { gersahlGreens=true },
	[61701360] = { gersahlGreens=true },
	[57804600] = { gersahlGreens=true },
	[63006440] = { gersahlGreens=true },
	[57805480] = { gersahlGreens=true },
	[54404630] = { gersahlGreens=true },
	[49303700] = { gersahlGreens=true },
	[50503620] = { gersahlGreens=true },
	[48803300] = { gersahlGreens=true },
	[47203020] = { gersahlGreens=true },
	[57601310] = { gersahlGreens=true },
	[56501560] = { gersahlGreens=true },
	[55901890] = { gersahlGreens=true },
	[55502390] = { gersahlGreens=true },
	[56802840] = { gersahlGreens=true },
	[58003190] = { gersahlGreens=true },
	[57703370] = { gersahlGreens=true },
	[56603490] = { gersahlGreens=true },
	[53503530] = { gersahlGreens=true },
	[50703190] = { gersahlGreens=true },
	[59508230] = { gersahlGreens=true },
	[67707730] = { gersahlGreens=true },
	[44102860] = { gersahlGreens=true },
	[42802730] = { gersahlGreens=true },
	[43602570] = { gersahlGreens=true },
	[47102750] = { gersahlGreens=true },
	[61807760] = { gersahlGreens=true },
	[65907600] = { gersahlGreens=true },
}
points[ 12 ] = { -- Kalimdor
	[46009300] = { alpaca=true },
}
points[ 947 ] = { -- Azeroth
	[16007460] = { alpaca=true },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets

textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"
texturesSpecial[1] = "Interface\\Common\\RingBorder"
texturesSpecial[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesSpecial[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesSpecial[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesSpecial[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesSpecial[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesSpecial[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesSpecial[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
texturesSpecial[9] = "Interface\\Vehicles\\UI-Vehicles-Raid-Icon"

scaling[1] = 0.413
scaling[2] = 0.413
scaling[3] = 0.413
scaling[4] = 0.413
scaling[5] = 0.413
scaling[6] = 0.413
scaling[7] = 0.489
scaling[8] = 0.465
scaling[9] = 0.563
scaling[10] = 0.563
scalingSpecial[1] = 0.278
scalingSpecial[2] = 0.368
scalingSpecial[3] = 0.368
scalingSpecial[4] = 0.368
scalingSpecial[5] = 0.323
scalingSpecial[6] = 0.308
scalingSpecial[7] = 0.296
scalingSpecial[8] = 0.428
scalingSpecial[9] = 0.323