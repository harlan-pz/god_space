function Recipe.OnCreate.exchangeGodRepairLight(items, result, player)
    player:getBodyDamage():RestoreToFullHealth()
    player:getModData().canShield = true
    player:Say(getText("IGUI_God_Repaire_Light_Work"))
    player:Say(getText("IGUI_Shield_Repair"))
end

function Recipe.OnCreate.useRepairTool(items, result, player)
    player:getPrimaryHandItem():setCondition(player:getPrimaryHandItem():getConditionMax())
    player:Say(getText("IGUI_Use_Repair_Tool"))
end

function Recipe.OnCreate.exchangePrimaryWarrior(items, result, player)
    if not player:getTraits():contains("warrior_primary") and not player:getTraits():contains("warrior_middle") and
        not player:getTraits():contains("warrior_senior") then
        player:getTraits():add("warrior_primary")
        player:getModData().maxShieldValue = 50
        player:getModData().shieldValue = 50
        player:getModData().canShield = true
        player:Say(getText("IGUI_Exchange_Primary_Warrior"))
    end
end

function Recipe.OnCreate.exchangeMiddleWarrior(items, result, player)
    if not player:getTraits():contains("warrior_middle") and not player:getTraits():contains("warrior_senior") and
        player:getTraits():contains("warrior_primary") then
        player:getTraits():add("warrior_middle")
        player:getTraits():remove("warrior_primary")
        player:getModData().maxShieldValue = 100
        player:getModData().shieldValue = 100
        player:getModData().canShield = true
        player:Say(getText("IGUI_Exchange_Middle_Warrior"))
    end

end

function Recipe.OnCreate.exchangeSeniorWarrior(items, result, player)
    if not player:getTraits():contains("warrior_senior") and player:getTraits():contains("warrior_middle") then
        player:getTraits():add("warrior_senior")
        player:getTraits():remove("warrior_middle")
        player:getModData().maxShieldValue = 200
        player:getModData().shieldValue = 200
        player:getModData().canShield = true
        player:Say(getText("IGUI_Exchange_Senior_Warrior"))
    end
end

function Recipe.OnCreate.repairShield20(items, result, player)
    if not player:getModData().canShield then
        player:Say(getText("IGUI_Shield_Broken2"))
        return
    end
    if player:getTraits():contains("lunhuizhe") and player:getModData().shieldValue < player:getModData().maxShieldValue then
        player:getModData().shieldValue = player:getModData().shieldValue + 20 > player:getModData().maxShieldValue and
                                              player:getModData().maxShieldValue or player:getModData().shieldValue + 20
    end
    player:Say(getText("IGUI_Max_Shield_Value") .. player:getModData().maxShieldValue)
    player:Say(getText("IGUI_Shield_Value") .. player:getModData().shieldValue)
end

function Recipe.OnCreate.repairShield50(items, result, player)
    if not player:getModData().canShield then
        player:Say(getText("IGUI_Shield_Broken2"))
        return
    end
    if player:getTraits():contains("lunhuizhe") and player:getModData().shieldValue < player:getModData().maxShieldValue then
        player:getModData().shieldValue = player:getModData().shieldValue + 50 > player:getModData().maxShieldValue and
                                              player:getModData().maxShieldValue or player:getModData().shieldValue + 50
    end
    player:Say(getText("IGUI_Max_Shield_Value") .. player:getModData().maxShieldValue)
    player:Say(getText("IGUI_Shield_Value") .. player:getModData().shieldValue)
end
