Config = {}

-- Language for the text players see. 'auto' follows ox_lib's language (setr ox:locale "de" in
-- server.cfg) and is English when that isn't set. Or name a file from locales/, such as 'de' or 'pt-br'.
Config.Locale = 'auto'

-- The command players use: /scanner turns it off and on for themselves, /scanner test plays each report
-- in turn so you can listen to them.
Config.Command = 'scanner'

-- Where players hear the scanner. Any that's true is enough.
Config.Where = {
    InEmergencyVehicle = true,      -- sitting in a police car, ambulance or fire truck (GTA's emergency class)
    NearEmergencyVehicle = true,    -- standing within Config.NearDistance of one
    AtStations = true,              -- within Config.StationRadius of a police station in Config.Stations
    PoliceJob = false,              -- anywhere, while on duty in a police job on Qbox, QBCore or ESX
    Everywhere = false,             -- anywhere at all
}

-- How close, in metres, a player on foot has to be to an emergency vehicle.
Config.NearDistance = 10.0

-- Police stations, and how close, in metres, counts as being at one. Add your own map's stations here.
Config.StationRadius = 50.0
Config.Stations = {
    vector3(442.0, -985.0, 30.0),   -- Mission Row
    vector3(1854.0, 3687.0, 33.0),  -- Sandy Shores Sheriff
    vector3(-445.0, 6013.0, 31.0),  -- Paleto Bay Sheriff
}

-- Police jobs, for Config.Where.PoliceJob. On Qbox and QBCore, any job with type 'leo' counts as well.
-- Players must be on duty on frameworks that have duty.
Config.PoliceJobs = { 'police', 'sheriff', 'bcso', 'sasp', 'lspd', 'statepolice' }

-- Seconds between reports: a random time between these two.
Config.MinSeconds = 60
Config.MaxSeconds = 180

-- Tell players when they turn the scanner off and on.
Config.ShowMessages = true

-- How messages are shown.
-- 'auto' uses ox_lib notifications if ox_lib is running, otherwise GTA's notification feed.
-- 'ox_lib' or 'gta' to force one.
Config.Notifications = 'auto'

-- GTA's police radio reports to play. These are the game's own; remove any you don't want, and use
-- /scanner test to listen to them in game.
Config.Reports = {
    'DLC_GR_Div_Scanner', 'LAMAR_1_POLICE_LOST',
    'SCRIPTED_SCANNER_REPORT_AH_3B_01', 'SCRIPTED_SCANNER_REPORT_AH_MUGGING_01',
    'SCRIPTED_SCANNER_REPORT_AH_PREP_01', 'SCRIPTED_SCANNER_REPORT_AH_PREP_02',
    'SCRIPTED_SCANNER_REPORT_ARMENIAN_1_01', 'SCRIPTED_SCANNER_REPORT_ARMENIAN_1_02',
    'SCRIPTED_SCANNER_REPORT_ASS_BUS_01', 'SCRIPTED_SCANNER_REPORT_ASS_MULTI_01',
    'SCRIPTED_SCANNER_REPORT_BARRY_3A_01', 'SCRIPTED_SCANNER_REPORT_BS_2A_01',
    'SCRIPTED_SCANNER_REPORT_BS_2B_01', 'SCRIPTED_SCANNER_REPORT_BS_2B_02',
    'SCRIPTED_SCANNER_REPORT_BS_2B_03', 'SCRIPTED_SCANNER_REPORT_BS_2B_04',
    'SCRIPTED_SCANNER_REPORT_BS_PREP_A_01', 'SCRIPTED_SCANNER_REPORT_BS_PREP_B_01',
    'SCRIPTED_SCANNER_REPORT_CAR_STEAL_2_01', 'SCRIPTED_SCANNER_REPORT_CAR_STEAL_4_01',
    'SCRIPTED_SCANNER_REPORT_DH_PREP_1_01', 'SCRIPTED_SCANNER_REPORT_FIB_1_01',
    'SCRIPTED_SCANNER_REPORT_FIN_C2_01', 'SCRIPTED_SCANNER_REPORT_Franklin_2_01',
    'SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP', 'SCRIPTED_SCANNER_REPORT_GETAWAY_01',
    'SCRIPTED_SCANNER_REPORT_JOSH_3_01', 'SCRIPTED_SCANNER_REPORT_JOSH_4_01',
    'SCRIPTED_SCANNER_REPORT_JSH_2A_01', 'SCRIPTED_SCANNER_REPORT_JSH_2A_02',
    'SCRIPTED_SCANNER_REPORT_JSH_2A_03', 'SCRIPTED_SCANNER_REPORT_JSH_2A_04',
    'SCRIPTED_SCANNER_REPORT_JSH_2A_05', 'SCRIPTED_SCANNER_REPORT_JSH_PREP_1A_01',
    'SCRIPTED_SCANNER_REPORT_JSH_PREP_1B_01', 'SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_01',
    'SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_02', 'SCRIPTED_SCANNER_REPORT_LAMAR_1_01',
    'SCRIPTED_SCANNER_REPORT_MIC_AMANDA_01', 'SCRIPTED_SCANNER_REPORT_NIGEL_1A_01',
    'SCRIPTED_SCANNER_REPORT_NIGEL_1D_01', 'SCRIPTED_SCANNER_REPORT_PS_2A_01',
    'SCRIPTED_SCANNER_REPORT_PS_2A_02', 'SCRIPTED_SCANNER_REPORT_PS_2A_03',
    'SCRIPTED_SCANNER_REPORT_SEC_TRUCK_01', 'SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02',
    'SCRIPTED_SCANNER_REPORT_SEC_TRUCK_03', 'SCRIPTED_SCANNER_REPORT_SIMEON_01',
    'SCRIPTED_SCANNER_REPORT_Sol_3_01', 'SCRIPTED_SCANNER_REPORT_Sol_3_02',
}

-- Update checks are controlled in server.cfg for every Pigeon Studios resource at once:
--     set pigeon_update_check "on"      (default)  |  "quiet"  |  "off"
