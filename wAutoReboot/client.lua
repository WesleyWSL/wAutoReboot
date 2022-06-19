ESX = nil
AnnounceText = nil

-- Thread for menu
Citizen.CreateThread(function()
    -- Load ESX
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    ESX.UI.Menu.CloseAll()
end)


RegisterNetEvent('AutoReboot:announce')
AddEventHandler('AutoReboot:announce', function (text)
    AnnounceText = text
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if AnnounceText then
            DrawRect(0.494, 0.200, 5.185, 0.050, 0, 0, 0, 150)
            DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Alerte météorologique ~w~", 255, 255, 255, 255, 1, 0)
            DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, AnnounceText, 255, 255, 255, 255, 7, 0)
        end
    end
end)



function DrawAdvancedTextCNN (x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1 + w, y - 0.02 + h)
end
