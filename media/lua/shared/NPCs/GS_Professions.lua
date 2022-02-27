require "MainCreationMethods"

GS_Professions = {};
GS_Professions.DoProfessions = function()

    local STARS = ProfessionFactory.addProfession("lunhuizhe", getText("UI_prof_lunhuizhe"), "profession_veteran2", 0);
    STARS:addXPBoost(Perks.Aiming, 3);
    STARS:addXPBoost(Perks.Reloading, 3);
    STARS:addXPBoost(Perks.Strength, 3);
    STARS:addXPBoost(Perks.Fitness, 3);
    STARS:addFreeTrait("Desensitized");
end

Events.OnGameBoot.Add(GS_Professions.DoProfessions);
Events.OnCreateLivingCharacter.Add(GS_Professions.DoProfessions);
