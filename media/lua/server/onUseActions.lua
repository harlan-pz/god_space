function Recipe.OnCreate.exchangeGodRepairLight(items, result, player)
    player:getBodyDamage():RestoreToFullHealth()
    player:Say(getText("IGUI_God_Repaire_Light_Work"))
end

function Recipe.OnCreate.useRepairTool(items, result, player)
    player:getPrimaryHandItem():setCondition(player:getPrimaryHandItem():getConditionMax())
    player:Say(getText("IGUI_Use_Repair_Tool"))
end
