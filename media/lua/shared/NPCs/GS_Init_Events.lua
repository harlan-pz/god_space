require "MainCreationMethods"

-- 初始化特性
local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe", getText("UI_trait_lunhuizhe"), 999, getText("UI_trait_lunhuizhe_desc"), true)
    TraitFactory.addTrait("warrior_primary", getText("UI_trait_warrior_primary"), 999,
        getText("UI_trait_warrior_primary_desc"), true)
    TraitFactory.addTrait("warrior_middle", getText("UI_trait_warrior_middle"), 999,
        getText("UI_trait_warrior_middle_desc"), true)
    TraitFactory.addTrait("warrior_senior", getText("UI_trait_warrior_senior"), 999,
        getText("UI_trait_warrior_senior_desc"), true)
end

local function initModData(_player)
    local player = _player
    local modData = player:getModData()
    if player:HasTrait("lunhuizhe") and modData.maxShieldValue == nil then
        modData.maxShieldValue = 20
    end
    if player:HasTrait("lunhuizhe") and modData.shieldValue == nil then
        modData.shieldValue = modData.maxShieldValue
        modData.canShield = true
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
        player:getInventory():AddItems("GodSpace.god_point", ZombRand(2, 10))
        if ZombRand(100) < 6 then
            player:getInventory():AddItems("GodSpace.side_quests_d", 1)
        end
        if ZombRand(100) < 1 then
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
    lunhuizhe_projession:addXPBoost(Perks.Aiming, 4);
    lunhuizhe_projession:addXPBoost(Perks.Reloading, 4);
    lunhuizhe_projession:addFreeTrait("lunhuizhe");
end

-- 护盾实现
local function defendAttack(_player)
    local player = _player
    local modData = player:getModData()
    local bodydamage = player:getBodyDamage();
    if player:HasTrait("lunhuizhe") then
        if bodydamage:getHealth() < 100 and modData.shieldValue > 0 then
            for n = 0, bodydamage:getBodyParts():size() - 1 do
                local bodyPart = bodydamage:getBodyParts():get(n);
                bodyPart:RestoreToFullHealth();
            end
            -- player:getBodyDamage():RestoreToFullHealth()
            modData.shieldValue = modData.shieldValue - ZombRand(5) > 0 and modData.shieldValue - ZombRand(5) or 0
            if modData.shieldValue == 0 then
                modData.canShield = false
                player:Say(getText("IGUI_Shield_Broken"))
            end
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

