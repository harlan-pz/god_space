require('NPCs/MainCreationMethods');

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
        inv:AddItem("God_Watch")
        inv:AddItems("god_point", 100)
        inv:AddItems("side_quests_d", 3)
    end
end

-- 杀死僵尸事件
local function getItem(zombie)
    local player = getPlayer()
    if player:HasTrait("lunhuizhe") then
        player:getInventory():AddItems("god_point", ZombRand(2, 10))
        if ZombRand(100) < 6 then
            player:getInventory():AddItems("side_quests_d", 1)
        end
        if ZombRand(100) < 1 then
            player:getInventory():AddItems("side_quests_c", 1)
        end
        if ZombRand(10000) < 6 then
            player:getInventory():AddItems("side_quests_b", 1)
        end
    end
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

-- 枪斗术实现

local function hasGunfightingTrait(character, inventoryItem)
    if inventoryItem ~= nil then
        local scriptItem = inventoryItem:getScriptItem()
        local ssv = scriptItem:getSoundVolume()
        local ssr = scriptItem:getSoundRadius()
        if inventoryItem:getStringItemType() == "RangedWeapon" then
            if character:HasTrait("gunfighting_primary") then
                inventoryItem:setSoundVolume(0.3 * ssv)
                inventoryItem:setSoundRadius(0.3 * ssr)
                return
            end
            if character:HasTrait("gunfighting_middle") then
                inventoryItem:setSoundVolume(0.1 * ssv)
                inventoryItem:setSoundRadius(0.1 * ssr)
                return
            end
            if character:HasTrait("gunfighting_senior") then
                inventoryItem:setSoundVolume(0.01 * ssv)
                inventoryItem:setSoundRadius(0.01 * ssr)
                return
            end
            inventoryItem:setSoundVolume(ssv)
            inventoryItem:setSoundRadius(ssr)
        end
    end
end

Events.OnGameBoot.Add(initGSTraits)
Events.OnGameBoot.Add(GS_Professions.DoProfessions);
Events.OnNewGame.Add(initGSItems)
Events.OnNewGame.Add(initModData)
Events.OnEquipPrimary.Add(hasGunfightingTrait)
Events.OnGameStart.Add(function()
    local player = getPlayer()
    hasGunfightingTrait(player, player:getPrimaryHandItem())
end)
Events.OnCreateLivingCharacter.Add(GS_Professions.DoProfessions);
Events.OnCreateLivingCharacter.Add(initModData);
Events.OnZombieDead.Add(getItem)
Events.OnPlayerUpdate.Add(defendAttack);

