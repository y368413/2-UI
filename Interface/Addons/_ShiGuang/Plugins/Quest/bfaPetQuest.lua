--[[## Version: 1.1.5 ## Author: Thomas Bemme]]
bfaPetQuestDB = { -- questid, pet, item, TomTom coords--
    --Nazjatar
    {56446,56457,"Chomp","Leathery Venom Gland",71.8,51.0,1355},
    {56450,56462,"Elderspawn of Nalaada","Eel Jelly",51.2,75,1355},
    {56455,56467,"Frenzied Knifefang","Frenzy Fang",59,26.6,1355},
    {56456,56458,"Giant Opaline Conch","Opaline Conch",28.2,26.8,1355},
    {56453,56465,"Kelpstone","Overgrown Stone",46.6,27.8,1355},
    {56452,56464,"Mindshackle","Strange Organ",56.6,8.2,1355},
    {56449,56461,"Pearlhusk Crawler","Pearlescent Shell",50.6,50.2,1355},
    {56444,56445,"Prince Wiggletail","Wiggletail Poking Fork",34.8,27.4,1355},
    {56451,56463,"Ravenous Scalespawn","Mottled Hydra Scale",29.6,49.6,1355},
    {56448,56460,"Shadowspike Lurker","Molted Spineshell",42,14,1355},
    {56447,56459,"Silence","Half Digested Deepcoral Pod",58.2,48,1355},
    {56454,56466,"Voltgorger","Crackling Mandible",37.6,16.6,1355},
    --Mechagon
    {56437,56437,"Sputtertube","Rusty Tube",60.8,46.6,1462},
    {56439,56439,"Creakclank","Mechanical Egg Sac",59.2,51,1462},
    {56438,56438,"Goldenbot XD","Flashing Siren",60.8,56.8,1462},
    {56436,56436,"Gnomefeaster","Small Skull",64.8,64.6,1462},
    {56443,56443,"Unit 17","Mechanical Eye",72,72.6,1462},
    {56441,56441,"Unit 35","Cluckbox",51.2,45.4,1462},
    {56442,56442,"Unit 6","Broken Unit 6",39.6,40,1462},
    {56440,56440,"CK-9 Micro-Oppression Unit","Can Of Critter Spray",65.2,57.6,1462}
}

local menuFrame = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")

local function bfePetQuestCoords(index)
    if IsAddOnLoaded("TomTom") then
        TomTom:AddWaypoint(bfaPetQuestDB[index][7], bfaPetQuestDB[index][5]/100, bfaPetQuestDB[index][6]/100, {
            title = string.format(bfaPetQuestDB[index][3]),
            minimap = true,
            crazy = true,
        })
        TomTom:SetClosestWaypoint()
        print("TomTom waypoint added for ",bfaPetQuestDB[index][3])
    else
        print("Addon TomTom not loaded")
    end
end

local function bfaPetQuestCmd(msg, editbox)
    local menu = { { text = "Pet Quests Incomplete", isTitle = true,notCheckable = true, notClickable = true}, }
    local index=0
    local faction=""
    local bfaPetQuestCounters = {0,0,0,0}
    local NazjatarID = 1355
    local MechagonID = 1462
    local tableShift=1
    englishFaction, localizedFaction = UnitFactionGroup("player")
    if englishFaction=="Horde" then
        index=2
        faction="H: "
    elseif englishFaction=="Alliance" then
        index=1
        faction="A: "
    else
        message("Faction error or neutral faction")
        do return end
    end
    local max=table.maxn(bfaPetQuestDB)
    for bfePetQuestIndex=1, max do
        if not C_QuestLog.IsQuestFlaggedCompleted(bfaPetQuestDB[bfePetQuestIndex][index]) then
            if bfaPetQuestDB[bfePetQuestIndex][7]==NazjatarID then
                bfaPetQuestCounters[1]=bfaPetQuestCounters[1]+1
            elseif bfaPetQuestDB[bfePetQuestIndex][7]==MechagonID then
                bfaPetQuestCounters[2]=bfaPetQuestCounters[2]+1
            end
            table.insert(menu,{ text = bfaPetQuestDB[bfePetQuestIndex][3], func = function() bfePetQuestCoords(bfePetQuestIndex); end, notCheckable = 1, keepShownOnClick = true,})
            --print(faction,bfaPetQuestDB[bfePetQuestIndex][3],RED_FONT_COLOR_CODE,"Not completed",FONT_COLOR_CODE_CLOSE)--
        end
    end
    if bfaPetQuestCounters[1]>0 then
        tableShift=tableShift+1
        table.insert(menu,tableShift,{ text = "Nazjatar", isTitle = true, notCheckable = true, notClickable = true})
    end
    if bfaPetQuestCounters[2]>0 then
        tableShift=tableShift+1
        table.insert(menu,tableShift+bfaPetQuestCounters[1],{ text = "Mechagon", isTitle = true, notCheckable = true, notClickable = true})

    end

    if msg=="c" then
        for bfePetQuestIndex=1, max do
            if C_QuestLog.IsQuestFlaggedCompleted(bfaPetQuestDB[bfePetQuestIndex][index]) then
                if bfaPetQuestDB[bfePetQuestIndex][7]==NazjatarID then
                    bfaPetQuestCounters[3]=bfaPetQuestCounters[3]+1
                elseif bfaPetQuestDB[bfePetQuestIndex][7]==MechagonID then
                    bfaPetQuestCounters[4]=bfaPetQuestCounters[4]+1
                end
                table.insert(menu,{ text = bfaPetQuestDB[bfePetQuestIndex][3], func = function() bfePetQuestCoords(bfePetQuestIndex); end, notCheckable = 1, keepShownOnClick = true,})
                --print(faction,bfaPetQuestDB[bfePetQuestIndex][3],GREEN_FONT_COLOR_CODE,"Completed",FONT_COLOR_CODE_CLOSE)--
            end
        end
        if (bfaPetQuestCounters[3]>0 or bfaPetQuestCounters[4]>0) then
            tableShift=tableShift+1
            table.insert(menu,tableShift+bfaPetQuestCounters[1]+bfaPetQuestCounters[2],{ text = "Pet Quests Complete", isTitle = true, notCheckable = true, notClickable = true})
        end
        if bfaPetQuestCounters[3]>0 then
            tableShift=tableShift+1
            table.insert(menu,tableShift+bfaPetQuestCounters[1]+bfaPetQuestCounters[2],{ text = "Nazjatar", isTitle = true, notCheckable = true, notClickable = true})
        end
        if bfaPetQuestCounters[4]>0 then
            tableShift=tableShift+1
            table.insert(menu,tableShift+bfaPetQuestCounters[1]+bfaPetQuestCounters[2]+bfaPetQuestCounters[3],{ text = "Mechagon", isTitle = true, notCheckable = true, notClickable = true})
        end
    elseif table.maxn(menu)==1 then
        print("All Pet Quests completed")
        do return end
    end
    EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
end

SLASH_PETQUEST_SLASHCMD1,SLASH_PETQUEST_SLASHCMD2 = "/petdone", "/pd"
SlashCmdList["PETQUEST_SLASHCMD"] = bfaPetQuestCmd