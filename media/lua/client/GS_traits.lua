local function initGSTraits()
    TraitFactory.addTrait("lunhuizhe_new", getText("UI_trait_lunhuizhe_new"), 6, getText("UI_trait_lunhuizhe_new_desc"),
        false, false)

    TraitFactory.addTrait("lunhuizhe_senior", getText("UI_trait_lunhuizhe_senior"), 6,
        getText("UI_trait_lunhuizhe_senior_desc"), false, false)
end

local function initGSItems(playerObj)
    local inv = playerObj:getInventory()
    if playerObj:HasTrait("lunhuizhe_new") then
        inv:AddItem("GodSpace.God_Watch")
        inv:AddItem("GodSpace.zomboid_medicine")
        for i = 1, 100 do
            inv:AddItem("GodSpace.god_point")
        end
    end

    if playerObj:HasTrait("lunhuizhe_senior") then
        inv:AddItem("GodSpace.God_Watch")
        for i = 1, 3 do
            inv:AddItem("GodSpace.zomboid_medicine")
        end

        for i = 1, 200 do
            inv:AddItem("GodSpace.god_point")
        end

    end
end

Events.OnGameBoot.Add(initGSTraits)
Events.OnNewGame.Add(initGSItems)
