--  click on item
RegisterNUICallback("clickItem", function(data)
    local identifier = data.identifier
    local menuData = CachedMenu[identifier].Items[data.index]
    if CachedMenu[identifier] and menuData then
        local callBack = menuData.cb
        if callBack then
            callBack()
        end
        CallOn(identifier, "selectitem", data.index, menuData.data or {})
    end
end)

-- calls when player select new item, and check for events & call them
RegisterNUICallback("selectNew", function(data)
    local identifier = data.identifier
    if CachedMenu[identifier] and CachedMenu[identifier].Items[data.index] then
        CallOn(identifier, "changeitem", data.newIndex, data.oldIndex, CachedMenu[identifier].Items[data.newIndex].data or {})
    end
end)


-- unregister events if resource is stopped
AddEventHandler('onResourceStop', function(resourceName)
    RemoveEventsWithNameResource(resourceName)
end)