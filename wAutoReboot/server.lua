ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Main Loop
Citizen.CreateThread(function()
    local now = os.date('*t')
    local currentTimeStamp = now.hour * 60 + now.min

    -- For each reboot time, check if we need to change state
    for _, rebootTime in pairs(Config.AutoRebootsTime) do
        local rebootTimeStamp = rebootTime.hour * 60 + rebootTime.min

        if currentTimeStamp < rebootTimeStamp then

            for i=1, #Config.AlertTime do
                local diff = (currentTimeStamp + Config.AlertTime[i].min) % (24 * 60)
                if diff >= rebootTimeStamp then
                    Config.AlertTime[i].state = true
                end
            end
        end
    end

    if Config.Debug then
        Pprint("Etat des variables au lancement:")
        
        for _, alertTime in pairs(Config.AlertTime) do
            Pprint(('Alerte %s min avant : %s'):format(alertTime.min, alertTime.state))
        end

        print()
    end

    Citizen.Wait(75 * 1000)
    
    while true do
        CheckTime()
        Citizen.Wait(Config.DurationBetweenCheck)
    end
end)

-- Check Time function
function CheckTime()
    local now = os.date('*t')
    local currentTimeStamp = now.hour * 60 + now.min

    if Config.Debug then
        Pprint(("Check pour %s."):format(json.encode(now)))
    end

    for _, rebootTime in pairs(Config.AutoRebootsTime) do
        local rebootTimeStamp = rebootTime.hour * 60 + rebootTime.min

        if currentTimeStamp <= rebootTimeStamp then
            if Config.Debug then
                Pprint(('Check pour le reboot %sh%s'):format(rebootTime.hour, rebootTime.min))
            end
            
            for i=1, #Config.AlertTime do
                if not Config.AlertTime[i].state then
                    local diff = (currentTimeStamp + Config.AlertTime[i].min) % (24 * 60)

                    if diff >= rebootTimeStamp then
                        Config.AlertTime[i].state = true
                        
                        if Config.AlertTime[i].weather then
                            if Config.Debug then
                                Pprint(("Changement de meteo vers %s."):format(Config.AlertTime[i].weather))
                            end
                            TriggerEvent('AdminMenu:setWeather', Config.AlertTime[i].weather)
                        end
                        
                        if Config.AlertTime[i].message then
                            DoAnnounce(Config.AlertTime[i])
                        end
                        
                        if Config.AlertTime[i].reboot then
                            Reboot()
                        end

                    end
                end
            end


        else
            if Config.Debug then
                Pprint(('Pas de check pour le reboot %sh%s'):format(rebootTime.hour, rebootTime.min))
            end
        end
    end
    

    if Config.Debug then
        print()
        Pprint("Etat des variables au check:")
        
        for _, alertTime in pairs(Config.AlertTime) do
            Pprint(('Alerte %s min avant : %s'):format(alertTime.min, alertTime.state))
        end

        print()
    end
end

function DoAnnounce (AlertTime)
    if Config.Debug then
        Pprint(("Declenchement de l'alerte pour '%s'"):format(AlertTime.message))
    end

    TriggerClientEvent('AutoReboot:announce', -1, AlertTime.message)
    Citizen.Wait(10000)
    TriggerClientEvent('AutoReboot:announce', -1, nil)
end

function Pprint(msg)
    print(('^7[^3AutoReboot^7]: ^2%s^7'):format(msg))
end

-- Reboot function
function Reboot()
    print('^7[^3AutoReboot^7]: ^2Redémarrage en cours^7')

    -- Kick all player
    print('^7[^3AutoReboot^7]: ^2Début des expulsions^7')
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.kick("🌙 BackLife: La tempête a causé une défaillance technique. Nous rétablissons le systèmes électrique de Paris.")
    end

    TriggerEvent('AdminMenu:setWeather', 'extrasunny')

    print('^7[^3AutoReboot^7]: ^2Redémarrage du server^7')
end

AddEventHandler("onResourceStart", function(name)
    if name == GetCurrentResourceName() then
        print("[^5Auteur^7] : Gastbob40")
        print("[^2Version^7] : Version 1.0.0")
        print("[^3Description^7] : Auto Reboot de BackLife")
    end
end)
