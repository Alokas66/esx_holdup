local holdingup = false
local store = ""
local blipRobbery = nil


RegisterNetEvent('BBWMqktLdH6yHbfdddd')
AddEventHandler('BBWMqktLdH6yHbfdddd', function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
end)

function BBWMqktLdH6yHbfddd(msg)
		BeginTextCommandDisplayHelp('STRING')
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandDisplayHelp(0, false, true, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if outline then SetTextOutline() end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('arp_holdup:currentlyrobbing')
AddEventHandler('arp_holdup:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('arp_holdup:killblip')
AddEventHandler('arp_holdup:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('arp_holdup:lopetaanimaatio')
AddEventHandler('arp_holdup:lopetaanimaatio', function()
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('arp_holdup:setblip')
AddEventHandler('arp_holdup:setblip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
	SetBlipSprite(blipRobbery, 459)
	SetBlipScale(blipRobbery, 1.5)
	SetBlipDisplay(blipRobbery, 4)
	SetBlipColour(blipRobbery, 2)
	SetBlipFlashes(blipRobbery, true)

	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(('Kaupparyöstö'))
    EndTextCommandSetBlipName(blipRobbery)
end)

RegisterNetEvent('arp_holdup:toofar')
AddEventHandler('arp_holdup:toofar', function()
	holdingup = false
	TriggerEvent("BBWMqktLdH6yHbfdddd",'Ryöstö keskeytyi!')
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('arp_holdup:robberycomplete')
AddEventHandler('arp_holdup:robberycomplete', function(award)
	holdingup = false
	TriggerEvent("BBWMqktLdH6yHbfdddd",'~r~Ryöstö onnistui~g~ '..award.."~s~ €")
	store = ""
	incircle = false
end)



RegisterNetEvent('arp_holdup:starttimer')
AddEventHandler('arp_holdup:starttimer', function()
	timer = (Config.ryostoaika)
	Citizen.CreateThread(function()
		while timer > 0 do
			Citizen.Wait(0)
			Citizen.Wait(1000)
			if (timer > 0) then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if holdingup then
				drawTxt(0.66, 1.4, 1.0,1.0,0.4, ('Kaupparyöstö: ~r~'..timer.."~s~ sekunttia jäljellä"), 255, 255, 255, 255)
			else
				Citizen.Wait(1000)
			end
		end
	end)
end)



Citizen.CreateThread(function()
	for k,v in pairs(Stores) do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 156)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Kaupparyöstö')
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0 then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0 then
						if not incirle then
							BBWMqktLdH6yHbfddd('Paina ~INPUT_CONTEXT~ ~o~ryöstääksesi~s~ Kauppa!')
						end

						incircle = true
						if IsControlJustReleased(0, 38) then
							if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_FLASHLIGHT') == false then
								TriggerServerEvent('arp_holdup:rob', k)
							else
								TriggerEvent("BBWMqktLdH6yHbfdddd",'~r~Taskulamppu??? MENE TÖIHIN!')
							end		
						end

					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then

			local pos2 = Stores[store].position
			
			BBWMqktLdH6yHbfddd('Paina ~INPUT_VEH_DUCK~ keskeyttääksesi ryöstö')
			
			if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > Config.MaxDistance then
			
				TriggerServerEvent('arp_holdup:toofar')
				
			elseif IsControlPressed(0, 73) then
			
				TriggerServerEvent('arp_holdup:toofar')
				
				TriggerEvent('arp_holdup:lopetaanimaatio')
				
			elseif IsPedDeadOrDying(PlayerPedId()) then
			
				TriggerServerEvent('arp_holdup:toofar')
				
				TriggerEvent('arp_holdup:lopetaanimaatio')
				

			end
		end
	end
end)