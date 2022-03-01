local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe", getText("UI_trait_lunhuizhe"), 6, getText("UI_trait_lunhuizhe_desc"), false,
        false)
end

local function initGSItems(playerObj)
    local inv = playerObj:getInventory()
    if playerObj:HasTrait("lunhuizhe") then
        inv:AddItem("GodSpace.God_Watch")
        inv:AddItem("GodSpace.zomboid_medicine")
        inv:AddItems("GodSpace.god_point", 100)
    end
end

local function getItem(zombie)
    local player = getPlayer()
    if player:HasTrait("lunhuizhe") then
        playera:getInventory():AddItems("GodSpace.god_point", 5)
    end

end

Events.OnGameBoot.Add(initGSTraits)
Events.OnNewGame.Add(initGSItems)
Events.OnZombieDead.Add(getItem)
