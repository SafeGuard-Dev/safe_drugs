local ESX = exports["es_extended"]:getSharedObject()
local isCollecting, isProcessing = false, false

local function ShowHover(text)
    if not displayingHover then
        displayingHover = true
        SendNUIMessage({
            type = 'showHover',
            text = text
        })
    end
end

-- Função para esconder o hover
local function HideHover()
    if displayingHover then
        displayingHover = false
        SendNUIMessage({
            type = 'hideHover'
        })
    end
end

local function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
end

local function CreateBlips()
    for _, point in ipairs(Config.CollectionPoints) do
        local blip = AddBlipForCoord(point.coords)
        SetBlipSprite(blip, Config.Blips.Collection.sprite)
        SetBlipColour(blip, Config.Blips.Collection.color)
        SetBlipScale(blip, Config.Blips.Collection.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Coleta de Safetamina")
        EndTextCommandSetBlipName(blip)
    end

    local processingBlip = AddBlipForCoord(Config.ProcessingPoint.coords)
    SetBlipSprite(processingBlip, Config.Blips.Processing.sprite)
    SetBlipColour(processingBlip, Config.Blips.Processing.color)
    SetBlipScale(processingBlip, Config.Blips.Processing.scale)
    SetBlipAsShortRange(processingBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Processamento de Safetamina")
    EndTextCommandSetBlipName(processingBlip)

    local sellingBlip = AddBlipForCoord(Config.SellingPoint.coords)
    SetBlipSprite(sellingBlip, Config.Blips.Selling.sprite)
    SetBlipColour(sellingBlip, Config.Blips.Selling.color)
    SetBlipScale(sellingBlip, Config.Blips.Selling.scale)
    SetBlipAsShortRange(sellingBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Venda de Safetamina")
    EndTextCommandSetBlipName(sellingBlip)
end

local function CollectSafetamina(coords)
    if isCollecting then return end
    isCollecting = true

    ESX.TriggerServerCallback('safetamina:canPerformAction', function(canPerform, message)
        if canPerform then
            PlayAnimation("amb@world_human_gardener_plant@male@base", "base")
            exports['progressBars']:startUI(Config.Timers.Collection, "A coletar Safetamina...")
            
            Citizen.Wait(Config.Timers.Collection)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('safetamina:collect')
        else
            ESX.ShowNotification(message)
        end
        isCollecting = false
    end)
end

local function ProcessSafetamina()
    if isProcessing then return end
    isProcessing = true

    ESX.TriggerServerCallback('safetamina:canPerformAction', function(canPerform, message)
        if canPerform then
            PlayAnimation("amb@prop_human_bum_bin@idle_b", "idle_d")
            exports['progressBars']:startUI(Config.Timers.Processing, "A processar Safetamina...")
            
            Citizen.Wait(Config.Timers.Processing)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('safetamina:process')
        else
            ESX.ShowNotification(message)
        end
        isProcessing = false
    end)
end

Citizen.CreateThread(function()
    CreateBlips()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isNearAction = false
        
        for _, point in ipairs(Config.CollectionPoints) do
            local distance = #(playerCoords - point.coords)
            if distance < point.radius then
                isNearAction = true
                ShowHover("Pressione E para coletar Safetamina")
                if IsControlJustReleased(0, 38) then
                    CollectSafetamina(point.coords)
                end
                break
            end
        end
        
        local processingCoords = Config.ProcessingPoint.coords
        local processingDistance = #(playerCoords - processingCoords)
        if processingDistance < Config.ProcessingPoint.radius then
            isNearAction = true
            ShowHover("Pressione E para processar Safetamina")
            if IsControlJustReleased(0, 38) then
                ProcessSafetamina()
            end
        end
        
        local sellingCoords = Config.SellingPoint.coords
        local sellingDistance = #(playerCoords - sellingCoords)
        if sellingDistance < Config.SellingPoint.radius then
            isNearAction = true
            ShowHover("Pressione E para vender Safetamina")
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('safetamina:sell')
            end
        end
        
        if not isNearAction and displayingHover then
            HideHover()
        end
    end
end)

RegisterNetEvent('safetamina:alertPolice')
AddEventHandler('safetamina:alertPolice', function(coords)
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    ESX.ShowAdvancedNotification("Alerta de Drogas", "Atividade Suspeita Detectada", "Local: " .. street, "CHAR_CALL911", 1)
    
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 51)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Atividade Suspeita")
    EndTextCommandSetBlipName(blip)
    
    Citizen.SetTimeout(60000, function()
        RemoveBlip(blip)
    end)
end)