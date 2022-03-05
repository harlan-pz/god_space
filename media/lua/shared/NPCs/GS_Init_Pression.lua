require('NPCs/MainCreationMethods');

-- 初始化特性
local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe", getText("UI_trait_lunhuizhe"), 999, getText("UI_trait_lunhuizhe_desc"), true)
    TraitFactory.addTrait("warrior_primary", getText("UI_trait_warrior_primary"), 999,
        getText("UI_trait_warrior_primary_desc"), true)
    TraitFactory.addTrait("warrior_middle", getText("UI_trait_warrior_middle"), 999,
        getText("UI_trait_warrior_middle_desc"), true)
    TraitFactory.addTrait("warrior_senior", getText("UI_trait_warrior_senior"), 999,
        getText("UI_trait_warrior_senior_desc"), true)

    TraitFactory.addTrait("gunfighting_primary", getText("UI_trait_gunfighting_primary"), 999,
        getText("UI_trait_gunfighting_primary_desc"), true)
    TraitFactory.addTrait("gunfighting_middle", getText("UI_trait_gunfighting_middle"), 999,
        getText("UI_trait_gunfighting_middle_desc"), true)
    TraitFactory.addTrait("gunfighting_senior", getText("UI_trait_gunfighting_senior"), 999,
        getText("UI_trait_gunfighting_senior_desc"), true)
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

Events.OnGameBoot.Add(initGSTraits)
Events.OnGameBoot.Add(GS_Professions.DoProfessions);

