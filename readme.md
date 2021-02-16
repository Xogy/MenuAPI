#Standalone menu API

This menu is for my projects, it is upon you if you like it and want to use it.<br>
However, it isn't really ready to use and it has only like 4 functions and single<br>
type of the menu. So use it on your own decision 


### MenuAPI

**1. Functions (client side)**

------------

------------

Example

```LUA
local menu = CreateMenu("identifier")

menu.SetMenuTitle("Healing menu")

menu.SetProperties({
    float = "right",
    position = "top",
})

menu.AddItem(1 ,"heal me", function()
    SetEntityHealth(PlayerPedId(), 200)
    menu.Close()
end)

menu.Open()
```

Example with events
```LUA
local vehicles = {
    [1] = { label = "police car", model = "police"},
    [2] = { label = "A FOCKING TANK?!", model = "rhino"},
    [3] = { label = "a nice car!", model = "cerberus3"}
}

local menu = CreateMenu("identifier")

menu.SetMenuTitle("Vehicle spawner")

menu.SetProperties({
    float = "right",
    position = "top",
})

for k,v in ipairs(vehicles) do
    menu.AddItem(k, v.label, nil, { model = v.model })
end

menu.OnSelectEvent(function(index, data)
    RequestModel(data.model)
    local coords = GetEntityCoords(PlayerPedId())
    while not HasModelLoaded(data.model) do
        Wait(33)
    end
    local vehicle = CreateVehicle(data.model, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, true)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(data.model)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)    
end)

menu.Open()
```
