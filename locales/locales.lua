Locales = {}

Locales['pt-BR'] = {
    ['wait_before_action'] = 'Você precisa esperar antes de realizar esta ação novamente.',
    ['not_enough_cops'] = 'Não há policiais suficientes na cidade.',
    ['collected'] = 'Você coletou 1 %s',
    ['processed'] = 'Você processou %s',
    ['not_enough_raw'] = 'Você não tem %s suficiente',
    ['sold'] = 'Você vendeu %d %s por $%d',
    ['not_enough_processed'] = 'Você não tem %s',
    ['starting'] = 'Iniciando %s...',
    ['collect_progress'] = 'Coletando Safetamina',
    ['process_progress'] = 'Processando Safetamina',
    ['press_collect'] = 'Pressione ~INPUT_CONTEXT~ para coletar safetamina bruta',
    ['press_process'] = 'Pressione ~INPUT_CONTEXT~ para processar safetamina',
    ['press_sell'] = 'Pressione ~INPUT_CONTEXT~ para vender safetamina processada',
    ['drug_alert'] = 'Alerta de Drogas',
    ['drug_activity_detected'] = 'Possível atividade de drogas detectada',
    ['location'] = 'Localização: %s',
    ['suspicious_activity'] = 'Atividade Suspeita',
    ['blip_collection'] = 'Coleta de Safetamina',
    ['blip_processing'] = 'Processamento de Safetamina',
    ['blip_selling'] = 'Venda de Safetamina'
}

Locales['pt-PT'] = {
    ['wait_before_action'] = 'Precisas de esperar antes de realizar esta ação novamente.',
    ['not_enough_cops'] = 'Não há polícias suficientes na cidade.',
    ['collected'] = 'Coletaste 1 %s',
    ['processed'] = 'Processaste %s',
    ['not_enough_raw'] = 'Não tens %s suficiente',
    ['sold'] = 'Vendeste %d %s por €%d',
    ['not_enough_processed'] = 'Não tens %s',
    ['starting'] = 'A iniciar %s...',
    ['collect_progress'] = 'A coletar Safetamina',
    ['process_progress'] = 'A processar Safetamina',
    ['press_collect'] = 'Prime ~INPUT_CONTEXT~ para coletar safetamina bruta',
    ['press_process'] = 'Prime ~INPUT_CONTEXT~ para processar safetamina',
    ['press_sell'] = 'Prime ~INPUT_CONTEXT~ para vender safetamina processada',
    ['drug_alert'] = 'Alerta de Drogas',
    ['drug_activity_detected'] = 'Possível atividade de drogas detetada',
    ['location'] = 'Localização: %s',
    ['suspicious_activity'] = 'Atividade Suspeita',
    ['blip_collection'] = 'Coleta de Safetamina',
    ['blip_processing'] = 'Processamento de Safetamina',
    ['blip_selling'] = 'Venda de Safetamina'
}

Locales['en-EN'] = {
    ['wait_before_action'] = 'You need to wait before performing this action again.',
    ['not_enough_cops'] = 'There are not enough police officers in the city.',
    ['collected'] = 'You collected 1 %s',
    ['processed'] = 'You processed %s',
    ['not_enough_raw'] = 'You don\'t have enough %s',
    ['sold'] = 'You sold %d %s for $%d',
    ['not_enough_processed'] = 'You don\'t have %s',
    ['starting'] = 'Starting %s...',
    ['collect_progress'] = 'Collecting Safetamine',
    ['process_progress'] = 'Processing Safetamine',
    ['press_collect'] = 'Press ~INPUT_CONTEXT~ to collect raw safetamine',
    ['press_process'] = 'Press ~INPUT_CONTEXT~ to process safetamine',
    ['press_sell'] = 'Press ~INPUT_CONTEXT~ to sell processed safetamine',
    ['drug_alert'] = 'Drug Alert',
    ['drug_activity_detected'] = 'Possible drug activity detected',
    ['location'] = 'Location: %s',
    ['suspicious_activity'] = 'Suspicious Activity',
    ['blip_collection'] = 'Safetamine Collection',
    ['blip_processing'] = 'Safetamine Processing',
    ['blip_selling'] = 'Safetamine Selling'
}

Locales['es-ES'] = {
    ['wait_before_action'] = 'Necesitas esperar antes de realizar esta acción de nuevo.',
    ['not_enough_cops'] = 'No hay suficientes policías en la ciudad.',
    ['collected'] = 'Has recolectado 1 %s',
    ['processed'] = 'Has procesado %s',
    ['not_enough_raw'] = 'No tienes suficiente %s',
    ['sold'] = 'Has vendido %d %s por €%d',
    ['not_enough_processed'] = 'No tienes %s',
    ['starting'] = 'Iniciando %s...',
    ['collect_progress'] = 'Recolectando Safetamina',
    ['process_progress'] = 'Procesando Safetamina',
    ['press_collect'] = 'Presiona ~INPUT_CONTEXT~ para recolectar safetamina cruda',
    ['press_process'] = 'Presiona ~INPUT_CONTEXT~ para procesar safetamina',
    ['press_sell'] = 'Presiona ~INPUT_CONTEXT~ para vender safetamina procesada',
    ['drug_alert'] = 'Alerta de Drogas',
    ['drug_activity_detected'] = 'Posible actividad de drogas detectada',
    ['location'] = 'Ubicación: %s',
    ['suspicious_activity'] = 'Actividad Sospechosa',
    ['blip_selling'] = 'Venta de Safetamina',
    ['blip_processing'] = 'Procesamiento de Safetamina',
    ['blip_collection'] = 'Recolección de Safetamina'
}

function _(str, ...)
    if Locales[Config.Locale] ~= nil then
        if Locales[Config.Locale][str] ~= nil then
            return string.format(Locales[Config.Locale][str], ...)
        else
            return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.Locale .. '] does not exist'
    end
end