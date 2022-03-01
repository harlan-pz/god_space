function Recipe.OnCreate.useZomboidMedicine(items, result, player)
    player:getBodyDamage():RestoreToFullHealth()
    player:Say(getText("IGUI_USE_ZOMBOID_MEDICINE"))
end

function Recipe.OnCreate.useRepairTool(items, result, player)
    player:getPrimaryHandItem():setCondition(player:getPrimaryHandItem():getConditionMax())
    player:Say(getText("IGUI_Use_Repair_Tool"))

end
