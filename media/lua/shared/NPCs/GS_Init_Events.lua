require "MainCreationMethods"

-- 初始化特性
local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe", getText("UI_trait_lunhuizhe"), 6, getText("UI_trait_lunhuizhe_desc"), false,
        false)
end

-- 初始化人物物品
local function initGSItems(playerObj)
    local inv = playerObj:getInventory()
    if playerObj:HasTrait("lunhuizhe") then
        inv:AddItem("GodSpace.God_Watch")
        inv:AddItem("GodSpace.zomboid_medicine")
        inv:AddItems("GodSpace.god_point", 100)
    end
end

-- 杀死僵尸事件
local function getItem(zombie)
    local player = getPlayer()
    if player:HasTrait("lunhuizhe") then
        player:getInventory():AddItems("GodSpace.god_point", ZombRand(5))
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

Events.OnGameBoot.Add(initGSTraits)
Events.OnNewGame.Add(initGSItems)
Events.OnZombieDead.Add(getItem)

Events.OnGameBoot.Add(GS_Professions.DoProfessions);
Events.OnCreateLivingCharacter.Add(GS_Professions.DoProfessions);
