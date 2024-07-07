Config = {
    Locale = 'pt-PT',

    CollectionPoints = {
        {coords = vector3(364.26,6483.07,29.23), radius = 3.0}
    },
    
    ProcessingPoint = {coords = vector3(2328.97,2571.31,46.67), radius = 3.0},
    SellingPoint = {coords = vector3(-1311.28,-1527.74,4.40), radius = 15.0},
    
    Items = {
        Raw = {name = "safetamina", label = "Safetamina Bruta"},
        Processed = {name = "safetamina_process", label = "Safetamina Processada"}
    },
    
    Timers = {
        Collection = 5000, -- 5 segundos
        Processing = 10000, --10 segundos
        Cooldown = 2000 --2 segundos
    },
    
    Processing = {
        RequiredAmount = 5,
        ProducedAmount = 1
    },
    
    Selling = {
        PriceRange = {min = 3500, max = 7200},
    },
    
    Blips = {
        Collection = {sprite = 403, color = 2, scale = 0.8},
        Processing = {sprite = 403, color = 3, scale = 0.8},
        Selling = {sprite = 403, color = 1, scale = 0.8}
    },

    Markers = {
        Type = 1,
        Size = vector3(1.0, 1.0, 1.0),
        Color = {r = 255, g = 255, b = 255, a = 100}
    },
    
    webhooklogs = "https://discord.com/api/webhooks/1259192821626306680/HwuZ7QIBKmD3IKPbh85UKj0q9OHLG7qSgPKl4DJKljtkC4JWMIufnU2hoxA56SMhCxfb"
}