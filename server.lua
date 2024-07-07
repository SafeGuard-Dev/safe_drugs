local ESX = nil
local cooldowns = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function CanPerformAction(playerId)
    if cooldowns[playerId] and cooldowns[playerId] > os.time() then
        return false, "Você precisa esperar antes de realizar esta ação novamente."
    end
    return true
end

local function SetCooldown(playerId)
    cooldowns[playerId] = os.time() + (Config.Timers.Cooldown / 1000)
end

local function sendWebhookLog(message)
    local webhookUrl = Config.webhooklogs

    local payload = {
        content = message
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('safetamina:canPerformAction', function(source, cb)
    local canPerform, message = CanPerformAction(source)
    cb(canPerform, message)
end)

RegisterNetEvent('safetamina:collect')
AddEventHandler('safetamina:collect', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local canPerform, message = CanPerformAction(source)
    
    if not canPerform then
        xPlayer.showNotification(message)
        return
    end
    
    SetCooldown(source)
    xPlayer.addInventoryItem(Config.Items.Raw.name, 1)
    xPlayer.showNotification("Você coletou 1 " .. Config.Items.Raw.label)
    
    local logMessage = string.format("[COLLECT] Player %s (%s) coletou 1 %s", GetPlayerName(source), source, Config.Items.Raw.label)
    sendWebhookLog(logMessage)
end)

RegisterNetEvent('safetamina:process')
AddEventHandler('safetamina:process', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local rawItem = xPlayer.getInventoryItem(Config.Items.Raw.name)
    
    if rawItem.count >= Config.Processing.RequiredAmount then
        xPlayer.removeInventoryItem(Config.Items.Raw.name, Config.Processing.RequiredAmount)
        xPlayer.addInventoryItem(Config.Items.Processed.name, Config.Processing.ProducedAmount)
        xPlayer.showNotification("Você processou " .. Config.Processing.RequiredAmount .. " " .. Config.Items.Raw.label .. " em " .. Config.Processing.ProducedAmount .. " " .. Config.Items.Processed.label)
        
        local logMessage = string.format("[PROCESS] Player %s (%s) processou %d %s em %d %s", GetPlayerName(source), source, Config.Processing.RequiredAmount, Config.Items.Raw.label, Config.Processing.ProducedAmount, Config.Items.Processed.label)
        sendWebhookLog(logMessage)
    else
        xPlayer.showNotification("Você não tem " .. Config.Items.Raw.label .. " suficiente para processar.")
    end
end)

RegisterNetEvent('safetamina:sell')
AddEventHandler('safetamina:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local processedItem = xPlayer.getInventoryItem(Config.Items.Processed.name)
    
    if not processedItem then
        print("ERRO: Item processado não encontrado")
        xPlayer.showNotification("Ocorreu um erro ao tentar vender o item.")
        return
    end
    
    if processedItem.count > 0 then
        local price = math.random(Config.Selling.PriceRange.min, Config.Selling.PriceRange.max)
        local reward = processedItem.count * price
        
        xPlayer.removeInventoryItem(Config.Items.Processed.name, processedItem.count)
        xPlayer.addMoney(reward)
        xPlayer.showNotification("Você vendeu " .. processedItem.count .. " " .. Config.Items.Processed.label .. " por $" .. reward)
        
        local logMessage = string.format("[SELL] Player %s (%s) vendeu %d %s por $%d", GetPlayerName(source), source, processedItem.count, Config.Items.Processed.label, reward)
        sendWebhookLog(logMessage)
    else
        xPlayer.showNotification("Você não tem " .. Config.Items.Processed.label .. " para vender.")
    end
end)
