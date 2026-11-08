--[[
    Pigeon Police Scanner: client.

    Plays GTA's own police radio reports (PlayPoliceReport) every minute or two while the player is somewhere
    a scanner would be: in or near an emergency vehicle, at a police station, or on duty as police. Only the
    player hears it. Players can turn it off and on with /scanner, which is remembered between sessions.
]]

local CHECK_MS = 2000
local EMERGENCY_CLASS = 18
local FIRST_DELAY = { 5, 15 }   -- seconds before the first report after the player starts listening

-- 'auto' follows ox_lib's language (the ox:locale convar), and English when that isn't set.
local locale = Config.Locale == 'auto' and GetConvar('ox:locale', 'en') or Config.Locale
local strings = Locales[locale] or Locales.en

local function t(key, values)
    local text = strings[key] or Locales.en[key] or key
    return (text:gsub('{(%w+)}', function(name)
        local value = values and values[name]
        return value ~= nil and tostring(value) or '{' .. name .. '}'
    end))
end

local function notify(text, kind)
    if not Config.ShowMessages then return end
    local mode = Config.Notifications
    if mode == 'ox_lib' or (mode == 'auto' and GetResourceState('ox_lib') == 'started') then
        TriggerEvent('ox_lib:notify', { title = strings.title, description = text, type = kind or 'inform' })
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(false, false)
    end
end

local enabled = GetResourceKvpString('enabled') ~= 'off'
local where = Config.Where or {}
local policeJobs = {}
for _, job in ipairs(Config.PoliceJobs or {}) do policeJobs[job] = true end

---------------------------------------------------------------------------
-- Where the player is

local function nearEmergency(ped)
    local coords = GetEntityCoords(ped)
    for _, veh in ipairs(GetGamePool('CVehicle')) do
        if GetVehicleClass(veh) == EMERGENCY_CLASS and #(coords - GetEntityCoords(veh)) <= Config.NearDistance then
            return true
        end
    end
    return false
end

local function atStation(ped)
    local coords = GetEntityCoords(ped)
    for _, station in ipairs(Config.Stations or {}) do
        if #(coords - station) <= Config.StationRadius then return true end
    end
    return false
end

--- The player's framework job, or nil. Qbox, QBCore and ESX.
local qbCore, esx
local function job()
    if GetResourceState('qbx_core') == 'started' then
        local data = exports.qbx_core:GetPlayerData()
        return data and data.job
    elseif GetResourceState('qb-core') == 'started' then
        qbCore = qbCore or exports['qb-core']:GetCoreObject()
        local data = qbCore.Functions.GetPlayerData()
        return data and data.job
    elseif GetResourceState('es_extended') == 'started' then
        esx = esx or exports.es_extended:getSharedObject()
        local data = esx.GetPlayerData()
        return data and data.job
    end
end

local function onDutyPolice()
    local current = job()
    if not current then return false end
    if not (current.type == 'leo' or policeJobs[current.name]) then return false end
    return current.onduty ~= false and current.onDuty ~= false
end

local function listening()
    if not enabled then return false end
    if where.Everywhere then return true end
    local ped = PlayerPedId()
    if IsPedDeadOrDying(ped, true) then return false end
    local veh = GetVehiclePedIsIn(ped, false)
    if where.InEmergencyVehicle and veh ~= 0 and GetVehicleClass(veh) == EMERGENCY_CLASS then return true end
    if where.NearEmergencyVehicle and veh == 0 and nearEmergency(ped) then return true end
    if where.AtStations and atStation(ped) then return true end
    if where.PoliceJob and onDutyPolice() then return true end
    return false
end

---------------------------------------------------------------------------
-- Playing reports

local reports = Config.Reports or {}
local last

local function play(name)
    PlayPoliceReport(name, 0.0)
    last = name
end

local function playRandom()
    if #reports == 0 then return end
    local name
    repeat name = reports[math.random(#reports)] until name ~= last or #reports == 1
    play(name)
end

CreateThread(function()
    local wasListening, nextAt = false, 0
    while true do
        local now = GetGameTimer()
        local on = listening()
        if on and not wasListening then
            nextAt = now + math.random(FIRST_DELAY[1], FIRST_DELAY[2]) * 1000
        elseif not on and wasListening then
            CancelAllPoliceReports()
        end
        wasListening = on
        if on and now >= nextAt then
            playRandom()
            local low = math.max(10, tonumber(Config.MinSeconds) or 60)
            local high = math.max(low, tonumber(Config.MaxSeconds) or low)
            nextAt = now + math.random(low, high) * 1000
        end
        Wait(CHECK_MS)
    end
end)

---------------------------------------------------------------------------
-- Command and exports

local testIndex = 0

RegisterCommand(Config.Command, function(_, args)
    local action = args[1] and args[1]:lower()
    if action == 'test' then
        if #reports == 0 then return end
        local n = tonumber(args[2])
        if n then testIndex = math.max(1, math.min(#reports, math.floor(n))) else testIndex = testIndex % #reports + 1 end
        CancelAllPoliceReports()
        play(reports[testIndex])
        notify(t('testing', { number = testIndex, total = #reports, name = reports[testIndex] }))
        return
    end

    if action == 'on' then enabled = true
    elseif action == 'off' then enabled = false
    else enabled = not enabled end
    SetResourceKvp('enabled', enabled and 'on' or 'off')
    if not enabled then CancelAllPoliceReports() end
    notify(t(enabled and 'on' or 'off'))
end, false)

TriggerEvent('chat:addSuggestion', '/' .. Config.Command, t('usage'), { { name = 'on / off / test' } })

--- Turn the scanner off (false) or on (true) for this player, for example from a radio or phone resource.
exports('SetEnabled', function(value)
    enabled = value and true or false
    SetResourceKvp('enabled', enabled and 'on' or 'off')
    if not enabled then CancelAllPoliceReports() end
end)

--- True while the player is hearing the scanner.
exports('IsListening', function() return listening() end)
