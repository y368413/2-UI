local addonname, namespace = ...
AngryKeystones_revise_Config = {}
AngryKeystones_revise_Data = {}
if not AngryKeystones_revise_Data.keepTrackerState then
    AngryKeystones_revise_Data.keepTrackerState={}
end
local C_Timer_NewTicker = C_Timer.NewTicker

-- 保存追踪窗体的状态
local function keep_tracker_state()
    local keepTrackerState_temp = {}
    local tracker = ObjectiveTrackerFrame;
    for i=1, #tracker.MODULES do
        local module = tracker.MODULES[i];
        keepTrackerState_temp[i] = module:IsCollapsed()
    end
    AngryKeystones_revise_Data.keepTrackerState = keepTrackerState_temp
    return keepTrackerState_temp
end

local function active_keep_tracker_state()
    -- 如果处于非副本状态（野外），可用使用最小化按钮主动保存追踪窗口状态。
    local _, zoneType, difficulty, _, maxPlayers, _, _, mapID, _, _ = GetInstanceInfo()
    if zoneType == "none" or difficulty == 0 then
        keep_tracker_state()
    end
end

-- 将追踪窗体恢复成之前的状态
-- 当进入游戏时，MODULES为空值。放在区域加载之后可以解决。
local function renew_tracker_state()
    local tracker = ObjectiveTrackerFrame;
    for i=1, #tracker.MODULES do
        local module = tracker.MODULES[i];
        module:SetCollapsed(AngryKeystones_revise_Data.keepTrackerState[i])
        ObjectiveTracker_Update(0, nil, module);
    end
end

-- 关闭无关的追踪窗体，只保留大秘境（地下城）的追踪窗体。
local function closs_tracker()
    local tracker = ObjectiveTrackerFrame;
    for i=1, #tracker.MODULES do
        local module = tracker.MODULES[i];
        if not module:IsCollapsed() then
            module:SetCollapsed(not module:IsCollapsed());
            ObjectiveTracker_Update(0, nil, module);
        end
    end
    -- 打开地下城的追踪窗体
    if ObjectiveTrackerBlocksFrame.ScenarioHeader.module:IsCollapsed() then
        ObjectiveTracker_MinimizeModuleButton_OnClick(ObjectiveTrackerBlocksFrame.ScenarioHeader.MinimizeButton)
    end
end

local function zone_change_func()
    -- 区域名称，区域类型，难度ID，难度名称，最大玩家数量，动态难度，是否是动态的，地图ID，_，_
    local _, zoneType, difficulty, _, maxPlayers, _, _, mapID, _, _ = GetInstanceInfo()
    -- difficulty：1普通地下城，2英雄地下城，23史诗地下城，8大秘境，14普通团本，15英雄团本，16史诗团本
    if difficulty == 8 then
         -- 这里需要注意，挑战模式CHALLENGE_MODE_START也会在这里触发
    elseif difficulty == 1 or difficulty == 2 or difficulty == 23 then
        closs_tracker()
        -- SetCVar("nameplateShowFriends", 0)
    elseif difficulty == 14 or difficulty == 15 or difficulty == 16 then
        closs_tracker()
        -- SetCVar("nameplateShowFriends", 0)
    elseif zoneType == "scenario" or difficulty == 167 then
        closs_tracker()
        -- SetCVar("nameplateShowFriends", 1)
    elseif zoneType == "none" or difficulty == 0 then
        -- 如果上线后直接进入副本则，无法保存这段时间内的改变
        -- 还有个办法，就是在这期间，只要点击了缩小按钮则保存
        -- 我还需要做整体缩放的匹配
        renew_tracker_state()
        -- SetCVar("nameplateShowFriends", 1)
    end
end


local function Addon_OnEvent(frame, event, ...)
    if event == "ADDON_LOADED" then

        -- 自身插件已经被加载
        if IsAddOnLoaded(addonname) == true then

        end

        -- Blizzard_ChallengesUI插件会晚于用户插件被加载
        if IsAddOnLoaded("Blizzard_ChallengesUI") == true then

        end

        -- Blizzard_ObjectiveTracker插件会早于用户插件被加载
        if IsAddOnLoaded("Blizzard_ObjectiveTracker") == true then

        end
    elseif event == "CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN" then
        closs_tracker() -- 关闭无关的追踪窗体
        SlotKeystone() -- 将钥石放入插槽
    elseif event == "CHALLENGE_MODE_START" then
        closs_tracker() -- 关闭无关的追踪窗体
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- 与ZONE_CHANGED_NEW_AREA事件相同。需要使用计时器。
        C_Timer_NewTicker(0.05, zone_change_func, 1)
    elseif event == "PLAYER_LEAVING_WORLD" then
    elseif event == "ENCOUNTER_START" then
        closs_tracker() -- 关闭无关的追踪窗体
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        -- 这里由于未知的原因会偶发区域变化出现错误的信息。例如，difficulty为0的彼界，或difficulty的23的暗影界。
        -- 可能是由于服务器访问的时间差，也可能是由于内部事件调用顺序导致的信息更新不及时（用户插件访问的顺序在更新的顺序前面导致）
        -- 但好在使用了计时器后可以消除这个错误，可能是由于计时器可以稳定在信息更新后触发。我尝试过1s、0.5s和0.1s，都可以消除区域信息的错误。
        -- 无论如何，它现在运行得很好。
        -- 参考：https://wowpedia.fandom.com/wiki/API_C_Timer.After
        -- https://www.townlong-yak.com/framexml/live/C_TimerAugment.lua
        C_Timer_NewTicker(0.05, zone_change_func, 1)
    end
end

local Listener = CreateFrame('Frame', nil) -- 用于监听事件的窗体
Listener:SetScript('OnEvent', Addon_OnEvent) -- 注册应对不同事件的脚本

Listener:RegisterEvent("ADDON_LOADED") -- 当任何一个插件被加载的时候触发该事件

Listener:RegisterEvent("CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN") -- 当与钥石孔互动的时候触发该事件
Listener:RegisterEvent("CHALLENGE_MODE_START") -- 开始挑战模式
Listener:RegisterEvent("CHALLENGE_MODE_COMPLETED") -- 挑战模式完成

-- 进出副本（读条）时候会先触发离开游戏，再触发进入游戏，最后触发区域改变
Listener:RegisterEvent("PLAYER_ENTERING_WORLD") -- 玩家进入游戏  reload结束之后也会触发 玩家进出副本（读条）后会触发
Listener:RegisterEvent("PLAYER_LEAVING_WORLD") -- 玩家离开游戏 reload开始之前也会触发 玩家进出副本（读条）前会触发

Listener:RegisterEvent("ENCOUNTER_START") -- 遭遇战开始（boss战）
Listener:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- 区域改变 玩家进入游戏也会触发 reload不会触发



-- 根据暴雪追踪窗体Blizzard_ObjectiveTracker（之后简称BO）插件的加载顺序。
-- BO的载入是在用户插件之前的，但初始化函数ObjectiveTracker_Initialize()却是在我们插件之后被调用的。
-- 具体来说，ObjectiveTrackerFrame的初始化是在其PLAYER_ENTERING_WORLD事件中被调用的。
-- 而BO的PLAYER_ENTERING_WORLD事件调用比我们插件的PLAYER_ENTERING_WORLD事件调用要晚。
-- 这导致我们的插件在玩家进入游戏之前（或者说BO插件的事件初始化之前），如果调用了MODULES，就会出现nil值的情况。
-- 而ObjectiveTracker_Update()会在BO的初始化之前调用，因此我们也不能直接钩住该方法。否则也会出现nil值的情况。
-- 只能在初始化ObjectiveTracker_Initialize()之后再考虑MODULES的使用问题。
-- 这里使用的是最小化按钮的后钩方法。若使用ObjectiveTracker_Update()难以在副本中准确地控制追踪窗体的保存。
hooksecurefunc("ObjectiveTracker_Initialize", function ()
    local tracker = ObjectiveTrackerFrame;
    for i=1, #tracker.MODULES do
        ObjectiveTrackerFrame.MODULES[i].Header.MinimizeButton:HookScript("OnClick", active_keep_tracker_state)
    end
end)