require "MainCreationMethods"

GS_Professions = {};
GS_Professions.DoProfessions = function()

    local STARS = ProfessionFactory.addProfession("lunhuizhe", getText("UI_prof_lunhuizhe"), "lunhuizhe", 12);
    STARS:addXPBoost(Perks.Strength, 3);
    STARS:addXPBoost(Perks.Fitness, 3);
    STARS:addFreeTrait("lunhuizhe");
end

Events.OnGameBoot.Add(GS_Professions.DoProfessions);
Events.OnCreateLivingCharacter.Add(GS_Professions.DoProfessions);
