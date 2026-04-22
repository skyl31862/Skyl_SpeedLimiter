-- Local state
local limiterEnabled  = false
local limitedSpeedKmh = 0
local limiterVehicle  = 0   -- Vehicle currently using the limiter

-- ====================================
-- ESX initialization
-- ====================================
local ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

-- ====================================
-- Round the speed up using the configured step
-- ====================================
local function roundUpSpeed(speed)
    local step = Config.SpeedStepKmh
    local roundedSpeed = math.ceil(speed / step) * step

    -- If the speed already matches the step, go one step higher
    if roundedSpeed == speed then
        roundedSpeed = roundedSpeed + step
    end

    return roundedSpeed
end

-- ====================================
-- Display notifications
-- ====================================
local function sendNotification(message, notificationType)
    if Config.NotificationProvider == 'esx' then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(message)
        else
            TriggerEvent('esx:showNotification', message)
        end

    elseif Config.NotificationProvider == 'ox_lib' then
        lib.notify({
            title       = 'Limiteur de vitesse',
            description = message,
            type        = notificationType or 'info',
            duration    = Config.NotificationDuration,
        })
    end
end

-- ====================================
-- Get the vehicle speed in km/h
-- ====================================
local function getVehicleSpeedKmh(vehicle)
    return math.floor(GetEntitySpeed(vehicle) * 3.6)
end

-- ====================================
-- Check if the vehicle class is blacklisted
-- ====================================
local function isBlacklistedVehicleClass(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    return Config.BlacklistedVehicleClasses[vehicleClass] == true
end

-- ====================================
-- Disable the limiter cleanly
-- ====================================
local function disableLimiter(silent)
    limiterEnabled = false

    -- Reset the max speed on the stored vehicle, even if the player left it
    if DoesEntityExist(limiterVehicle) and limiterVehicle ~= 0 then
        -- SetVehicleMaxSpeed(vehicle, 0.0) fully resets the limiter in FiveM
        SetVehicleMaxSpeed(limiterVehicle, 0.0)
    end

    limiterVehicle  = 0
    limitedSpeedKmh = 0

    if not silent then
        sendNotification(Config.Messages.Disabled, 'error')
    end
end

-- ====================================
-- Enable or disable the limiter
-- ====================================
local function toggleLimiter()
    local ped     = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if limiterEnabled then
        disableLimiter(false)
        return
    end

    -- The player must be inside a vehicle
    if not DoesEntityExist(vehicle) or vehicle == 0 then
        sendNotification(Config.Messages.NotInVehicle, 'error')
        return
    end

    -- The player must be the driver
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then
        sendNotification(Config.Messages.NotInVehicle, 'error')
        return
    end

    -- Blacklisted vehicle classes cannot use the limiter
    if isBlacklistedVehicleClass(vehicle) then
        sendNotification(Config.Messages.VehicleBlacklisted, 'error')
        return
    end

    -- Check the current speed
    local speed = getVehicleSpeedKmh(vehicle)
    if speed > Config.MaxSpeedKmh then
        sendNotification(Config.Messages.TooFast, 'error')
        return
    end

    -- Force the minimum speed if the current speed is lower
    if speed < Config.MinSpeedKmh then
        speed = Config.MinSpeedKmh
        limiterVehicle = vehicle
        limiterEnabled  = true
        limitedSpeedKmh = Config.MinSpeedKmh
        sendNotification(string.format(Config.Messages.Enabled, limitedSpeedKmh), 'success')
        return
    end

    -- Calculate the rounded target speed
    limitedSpeedKmh = roundUpSpeed(speed)
    if limitedSpeedKmh < Config.SpeedStepKmh then
        limitedSpeedKmh = Config.SpeedStepKmh
    end

    limiterVehicle = vehicle
    limiterEnabled  = true

    sendNotification(string.format(Config.Messages.Enabled, limitedSpeedKmh), 'success')
end

-- ====================================
-- Main limiter thread
-- ====================================
CreateThread(function()
    while true do
        local sleep = 500

        if limiterEnabled then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)

            -- The player must still be driving the same vehicle
            if DoesEntityExist(vehicle) and vehicle ~= 0
            and vehicle == limiterVehicle
            and GetPedInVehicleSeat(vehicle, -1) == ped then

                sleep = 0

                local limitedSpeedMs = limitedSpeedKmh / 3.6

                -- Apply the limit with a reliable native
                SetVehicleMaxSpeed(vehicle, limitedSpeedMs)

                -- Extra safety if the vehicle exceeds the cap
                local speedMs = GetEntitySpeed(vehicle)
                if speedMs > (limitedSpeedMs + 0.5) then
                    local vel   = GetEntityVelocity(vehicle)
                    local ratio = limitedSpeedMs / speedMs
                    SetEntityVelocity(vehicle, vel.x * ratio, vel.y * ratio, vel.z * ratio)
                end

            else
                -- The player left or switched vehicles, disable silently
                disableLimiter(true)
            end
        end

        Wait(sleep)
    end
end)

-- ====================================
-- HUD thread
-- ====================================
CreateThread(function()
    while true do
        local sleep = 500

        if limiterEnabled then
            sleep = 0
            if Config.HUD.Enabled then
                SetTextFont(4)
                SetTextProportional(true)
                SetTextScale(0.40, 0.40)
                SetTextColour(100, 220, 100, 240)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(string.format(Config.HUD.Text, limitedSpeedKmh))
                DrawText(Config.HUD.PositionX, Config.HUD.PositionY)
            end
        end

        Wait(sleep)
    end
end)

-- ====================================
-- Command + mapped key
-- RegisterCommand must be declared before RegisterKeyMapping
-- ====================================
RegisterCommand('skySpeedLimiter', function()
    toggleLimiter()
end, false)

RegisterKeyMapping('skySpeedLimiter', 'Activer / desactiver le limiteur de vitesse', 'keyboard', Config.ToggleKey)
