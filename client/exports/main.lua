function CloseAll()
    SendNUIMessage({ type = "ui", status = false })
end

exports("CloseAll", CloseAll)
