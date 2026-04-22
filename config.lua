Config = {}

-- Key used to enable or disable the speed limiter.
-- Key list: https://docs.fivem.net/docs/game-references/controls/
Config.ToggleKey = 'EQUALS' -- Default "=" key, can be changed in FiveM settings

-- Minimum speed required to enable the limiter (km/h)
Config.MinSpeedKmh = 30

-- Maximum speed allowed to enable the limiter (km/h)
Config.MaxSpeedKmh = 200

-- Speed step used when rounding up the current speed
-- Example: 5 rounds 78 -> 80 and 132 -> 135
Config.SpeedStepKmh = 5

-- ====================================
-- Notification configuration
-- ====================================
-- 'esx'    = native ESX notifications
-- 'ox_lib' = ox_lib notifications
Config.NotificationProvider = 'esx'

-- Notification messages
Config.Messages = {
    Enabled = "Limiteur de vitesse active a %s km/h", -- %s will be replaced with the speed
    Disabled = "Limiteur de vitesse desactive",
    TooFast = "Votre vitesse est trop elevee pour activer le limiteur",
    NotInVehicle = "Vous devez etre dans un vehicule pour utiliser le limiteur",
    VehicleBlacklisted = "Cette classe de vehicule ne peut pas utiliser le limiteur",
}

-- Notification display duration in ms, used only with ox_lib
Config.NotificationDuration = 3000

-- ====================================
-- Blacklisted vehicle classes
-- ====================================
Config.BlacklistedVehicleClasses = {
    [13] = true, -- Cycles
    [15] = true, -- Helicopters
    [16] = true, -- Planes
    [21] = true, -- Trains
}
-- Vehicle class reference
-- 0  = Compacts
-- 1  = Sedans
-- 2  = SUVs
-- 3  = Coupes
-- 4  = Muscle
-- 5  = Sports Classics
-- 6  = Sports
-- 7  = Super
-- 8  = Motorcycles
-- 9  = Off-Road
-- 10 = Industrial
-- 11 = Utility
-- 12 = Vans
-- 13 = Cycles
-- 14 = Boats
-- 15 = Helicopters
-- 16 = Planes
-- 17 = Service
-- 18 = Emergency
-- 19 = Military
-- 20 = Commercial
-- 21 = Trains

-- ====================================
-- HUD configuration
-- ====================================
Config.HUD = {
    -- Enable or disable the HUD in game
    Enabled = false,

    -- Displayed text (%s = limited speed)
    Text = "%s km/h ~s~verrouille",

    -- Screen position (0.0 = left/top, 1.0 = right/bottom)
    PositionX = 0.95,
    PositionY = 0.95,
}
