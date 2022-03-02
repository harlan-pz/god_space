require "MainCreationMethods"

-- 初始化特性
local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe", getText("UI_trait_lunhuizhe"), 6, getText("UI_trait_lunhuizhe_desc"), false,
        false)
    TraitFactory.addTrait("warrior_primary", getText("UI_trait_warrior_primary"), 6,
        getText("UI_trait_warrior_primary_desc"), false, false)
    TraitFactory.addTrait("warrior_middle", getText("UI_trait_warrior_middle"), 6,
        getText("UI_trait_warrior_middle_desc"), false, false)
    TraitFactory.addTrait("warrior_senior", getText("UI_trait_warrior_senior"), 6,
        getText("UI_trait_warrior_senior_desc"), false, false)
end

local function initModData(_player)
    local player = _player
    local modData = player:getModData()
    if player:HasTrait("lunhuizhe") and modData.maxShieldValue == nil then
        modData.maxShieldValue = 20
    end
    if player:HasTrait("lunhuizhe") and modData.shieldValue == nil then
        modData.shieldValue = modData.maxShieldValue
    end
    if player:HasTrait("warrior_primary") then
        modData.maxShieldValue = 50
    end
    if player:HasTrait("warrior_primary") then
        modData.maxShieldValue = 100
    end
    if player:HasTrait("warrior_primary") then
        modData.maxShieldValue = 200
    end
end

-- 初始化人物物品
local function initGSItems(playerObj)
    local inv = playerObj:getInventory()
    if playerObj:HasTrait("lunhuizhe") then
        inv:AddItem("GodSpace.God_Watch")
        inv:AddItems("GodSpace.god_point", 100)
        inv:AddItems("GodSpace.side_quests_d", 3)
    end
end

-- 杀死僵尸事件
local function getItem(zombie)
    local player = getPlayer()
    if player:HasTrait("lunhuizhe") then
        player:getInventory():AddItems("GodSpace.god_point", ZombRand(5))
        if ZombRand(100) < 6 then
            player:getInventory():AddItems("GodSpace.side_quests_d", 1)
        end
        if ZombRand(1000) < 6 then
            player:getInventory():AddItems("GodSpace.side_quests_c", 1)
        end
        if ZombRand(10000) < 6 then
            player:getInventory():AddItems("GodSpace.side_quests_b", 1)
        end
    end
end

-- 添加职业
GS_Professions = {};
GS_Professions.DoProfessions = function()
    local lunhuizhe_projession = ProfessionFactory.addProfession("lunhuizhe", getText("UI_prof_lunhuizhe"), "lunhuizhe",
        12);
    lunhuizhe_projession:addXPBoost(Perks.Strength, 3);
    lunhuizhe_projession:addXPBoost(Perks.Fitness, 3);
    lunhuizhe_projession:addFreeTrait("lunhuizhe");
end

-- 护盾实现
local function defendAttack(_player)
    local player = _player
    local modData = player:getModData()
    if player:HasTrait("lunhuizhe") then
        if player:getBodyDamage():getHealth() < 100 and modData.shieldValue > 0 then
            player:getBodyDamage():RestoreToFullHealth()
            modData.shieldValue = modData.shieldValue - ZombRand(5) > 0 and modData.shieldValue - ZombRand(5) or 0
            player:Say(getText("IGUI_Shield_Value") .. modData.shieldValue)
        end
    end
end

Events.OnGameBoot.Add(initGSTraits)
Events.OnGameBoot.Add(GS_Professions.DoProfessions);
Events.OnNewGame.Add(initGSItems)
Events.OnNewGame.Add(initModData)
Events.OnCreateLivingCharacter.Add(GS_Professions.DoProfessions);
Events.OnCreateLivingCharacter.Add(initModData);
Events.OnZombieDead.Add(getItem)
Events.OnPlayerUpdate.Add(defendAttack);

