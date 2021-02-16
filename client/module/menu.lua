function CreateMenu(identifier)
    local self = {}
    local _menuTitle = "RCORE"
    local _properties = {
        float = "right",
        position = "middle",
    }
    local items = {}
    --------------
    self.SetMenuTitle = function(title)
        _menuTitle = title
    end

    self.GetMenuTitle = function()
        return _menuTitle
    end
    --------------
    self.SetProperties = function(properties)
        _properties = properties
    end

    self.GetProperties = function()
        return _properties
    end
    --------------
    self.OnCloseEvent = function(cb)
        On(identifier, "close", cb)
    end

    self.OnOpenEvent = function(cb)
        On(identifier, "open", cb)
    end

    self.OnChangeItemEvent = function(cb)
        On(identifier, "changeitem", cb)
    end

    self.OnSelectEvent = function(cb)
        On(identifier, "selectitem", cb)
    end

    self.On = function(eventName, cb)
        On(identifier, eventName, cb)
    end
    --------------
    self.AddItem = function(index, text, cb, data)
        items[index] = {
            label = text,
            index = index,
            data = data or {},
            cb = cb,
        }
    end
    --------------
    self.Open = function()
        if not CachedMenu[identifier] then
            CachedMenu[identifier] = {}
        end
        CachedMenu[identifier] = {
            MenuTitle = _menuTitle,
            Properties = _properties,
            Items = items,
        }
        SendNUIMessage({ type = "reset" })
        SendNUIMessage({ type = "title", title = _menuTitle })
        for k, v in ipairs(items) do
            SendNUIMessage({
                type = "add",
                label = v.label,
                index = k,
            })
        end
        SendNUIMessage({ type = "ui", identifier = identifier, properties = _properties, status = true })
        CallOn(identifier, "open")
    end
    --------------
    self.Close = function()
        SendNUIMessage({ type = "ui", status = false })
        CallOn(identifier, "close")
    end
    --------------
    self.Destroy = function()
        SendNUIMessage({ type = "ui", status = false })
        CachedMenu[identifier] = nil
        Events[identifier] = nil
    end
    return self
end

exports("CreateMenu", CreateMenu)
