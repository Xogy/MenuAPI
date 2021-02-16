CachedMenu = {}

function RegisterKey(fc, uniqid, description, key)
    RegisterCommand(uniqid, fc, false)
    RegisterKeyMapping(uniqid, description, 'keyboard', key)
end
--------------
-- Sending info about changing item in menu
--------------
RegisterKey(function()
    SendNUIMessage({ type = "up" })
end, "menuapiup", "Key up", "UP")

RegisterKey(function()
    SendNUIMessage({ type = "down" })
end, "menuapidown", "Key down", "DOWN")
--------------
-- Sending info about selecting item
--------------
RegisterKey(function()
    SendNUIMessage({ type = "enter" })
end, "menuapie", "Key E", "E")

RegisterKey(function()
    SendNUIMessage({ type = "enter" })
end, "menuapienter", "Key ENTER", "RETURN")
--------------
-- closing menu keys
--------------
RegisterKey(function()
    CloseAll()
end, "menuapiesc", "Key ESC", "escape")

RegisterKey(function()
    CloseAll()
end, "menuapiescaper", "Key backspace", "back")
--------------

--CreateThread(function()
--    Wait(200)
--    local vehicles = {
--        [1] = { label = "police car", model = "police"},
--        [2] = { label = "A FOCKING TANK?!", model = "rhino"},
--        [3] = { label = "a nice car!", model = "cerberus3"}
--    }
--
--    local menu = CreateMenu("identifier")
--
--    menu.SetMenuTitle("Vehicle spawner")
--
--    menu.SetProperties({
--        float = "right",
--        position = "middle",
--    })
--
--    for k,v in ipairs(vehicles) do
--        menu.AddItem(k, v.label, nil, { model = v.model })
--    end
--
--    menu.OnSelectEvent(function(index, data)
--        RequestModel(data.model)
--        local coords = GetEntityCoords(PlayerPedId())
--        while not HasModelLoaded(data.model) do
--            Wait(33)
--        end
--        local vehicle = CreateVehicle(data.model, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, true)
--        SetVehicleOnGroundProperly(vehicle)
--        SetModelAsNoLongerNeeded(data.model)
--        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--    end)
--
--    menu.Open()
--end)