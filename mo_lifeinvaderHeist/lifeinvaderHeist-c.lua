--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--

local USBplugged, robberyHacked, USBtaken, dataUploading, dataSended, currentRobbery = false, false, false, false, false, false

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for _, player in ipairs(GetActivePlayers()) do
	SetArtificialLightsState(false)
end

Citizen.CreateThread(function()
	local LBlip = AddBlipForCoord(Config.LBlip.Coords.x, Config.LBlip.Coords.y, Config.LBlip.Coords.z)
	SetBlipDisplay(LBlip, Config.LBlip.Display)
	SetBlipSprite(LBlip, Config.LBlip.Sprite)
	SetBlipColour(LBlip, Config.LBlip.Colour)
	SetBlipScale(LBlip, Config.LBlip.Scale)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Lifeinvader')
	EndTextCommandSetBlipName(LBlip)
	SetBlipAsShortRange(LBlip, true)
	
	local HackingBlip = AddBlipForCoord(Config.HackingBlip.Coords.x, Config.HackingBlip.Coords.y, Config.HackingBlip.Coords.z)
	SetBlipDisplay(HackingBlip, Config.HackingBlip.Display)
	SetBlipSprite(HackingBlip, Config.HackingBlip.Sprite)
	SetBlipColour(HackingBlip, Config.HackingBlip.Colour)
	SetBlipScale(HackingBlip, Config.HackingBlip.Scale)
	SetBlipAsShortRange(HackingBlip, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        local usbDistance = GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
		if usbDistance < 1 and not currentRobbery then
			while GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true) < 1 and not currentRobbery do
				Draw3DText(Config.RobberyUSBStick.Coords.x + 0.1, Config.RobberyUSBStick.Coords.y + 0.7, Config.RobberyUSBStick.Coords.z + 0.3, 1.5, "~r~[E] ~s~| ".._U('robbery_plugInUSB'))
				Citizen.Wait(4)
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        local lesterDistance = GetDistanceBetweenCoords(Config.LesterCoords.Coords.x, Config.LesterCoords.Coords.y, Config.LesterCoords.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
		if lesterDistance < 2.5 and not dataUploading then
			while lesterDistance < 2.5 and not dataUploading do
				Draw3DText(Config.LesterCoords.Coords.x, Config.LesterCoords.Coords.y, Config.LesterCoords.Coords.z, 1.5, "~r~[E] ~s~| ".._U('lester_laptop'))
				if IsControlJustReleased(0, Config.trigger_key) then
					ESX.TriggerServerCallback('lifeinvaderRobbery:removeDataUSB', function(hasRemoved)
						if hasRemoved then
							uploadData()
						end
					end)
				end
				Citizen.Wait(4)
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		ESX.TriggerServerCallback('lifeinvaderRobbery:getCurrentRobbery', function(cb) 
			currentRobbery = cb
		end)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local usbDistance = GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
		if usbDistance < 1 and not currentRobbery then
			while GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true) < 1 and not currentRobbery do
				if IsControlJustReleased(0, Config.trigger_key) then
					ESX.TriggerServerCallback('lifeinvaderRobbery:getOnlinePoliceCount', function(enoughCops)
						if enoughCops then
							local usbDistance = GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
							if usbDistance < 1 then
								ESX.TriggerServerCallback('lifeinvaderRobbery:removeEmptyUSB', function(hasRemoved)
									if not hasRemoved then
										TriggerServerEvent('lifeinvaderRobbery:currentRobbery', false)
									else
										startRobbery()
									end
								end)
							end
						end
					end)
				end
				Citizen.Wait(50)
			end
		end
	end
end)

function startRobbery()
	local playerPed = GetPlayerPed(PlayerId())
	robberyHacked = false
	USBtaken = false
	TriggerServerEvent('lifeinvaderRobbery:currentRobbery', true)
	
	RequestAnimDict("amb@prop_human_atm@female@enter")
	while not HasAnimDictLoaded("amb@prop_human_atm@female@enter") do
		RequestAnimDict("amb@prop_human_atm@female@enter")
		Citizen.Wait(0)
	end
	TaskGoStraightToCoord(playerPed, Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z - 1, 1.0, -1, Config.RobberyUSBStick.Heading, 0.1)
	Citizen.Wait(1500)
	FreezeEntityPosition(playerPed, true)
	SetEntityHeading(playerPed, Config.RobberyUSBStick.Heading)
	SetCurrentPedWeapon(playerPed, GetHashKey('weapon_unarmed'), true)
	ESX.Streaming.RequestAnimDict("amb@prop_human_atm@female@enter", function()
		TaskPlayAnim(playerPed, "amb@prop_human_atm@female@enter", "enter", 2.0, 2.0, 4333, 1, 1.0, true, true, true)
	end)
	Citizen.Wait(4333)
	FreezeEntityPosition(playerPed, false)
	notify(_U('usb_switch_robbery'))
	while not robberyHacked do
		local robberyDistance = GetDistanceBetweenCoords(Config.RobberyStart.Coords.x, Config.RobberyStart.Coords.y, Config.RobberyStart.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
		if robberyDistance < 1 then
			Draw3DText(Config.RobberyStart.Coords.x, Config.RobberyStart.Coords.y, Config.RobberyStart.Coords.z, 1.5, "~r~[E] ~s~| ".._U('robbery_start'))
			if IsControlJustReleased(0, Config.trigger_key) then
				local playerCoords = vector3(GetEntityCoords(playerPed, true))
				local obj = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 3.0, GetHashKey('prop_off_chair_01'), false, true, true)
				RequestAnimDict("amb@prop_human_seat_computer@male@base")
				while not HasAnimDictLoaded("amb@prop_human_seat_computer@male@base") do
					RequestAnimDict("amb@prop_human_seat_computer@male@base")
					Citizen.Wait(0)
				end
						
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				FreezeEntityPosition(playerPed, true)
				local objCoords = vector3(GetEntityCoords(obj).x, GetEntityCoords(obj).y, GetEntityCoords(obj).z)
				SetEntityHeading(playerPed, GetEntityHeading(obj) - 150)
				SetEntityCoords(playerPed, GetEntityCoords(obj))
				playerCoords = vector3(GetEntityCoords(GetPlayerPed(PlayerId()), true))
				SetEntityCoords(playerPed, playerCoords.x, playerCoords.y, playerCoords.z - 1.5)
				SetCurrentPedWeapon(playerPed, GetHashKey('weapon_unarmed'), true)
				ESX.Streaming.RequestAnimDict("amb@prop_human_seat_computer@male@base", function()
					TaskPlayAnim(playerPed, "amb@prop_human_seat_computer@male@base", "base", 2.0, 2.0, 12166, 1, 1.0, true, true, true)
				end)
				Citizen.Wait(500)
				DoScreenFadeIn(1000)
				TriggerServerEvent('lifeinvaderRobbery:callPolice')
				notify(_U('robbery_downloading'))
				Citizen.Wait(10166)
				PlaySound(-1, 'Kill_List_Counter', 'GTAO_FM_Events_Soundset', 0, 0, 1)
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				FreezeEntityPosition(playerPed, false)
				SetEntityHeading(playerPed, Config.RobberyStandUp.Heading)
				SetEntityCoords(playerPed, Config.RobberyStandUp.Coords.x, Config.RobberyStandUp.Coords.y, Config.RobberyStandUp.Coords.z)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
				Citizen.Wait(1000)
				notify(_U('robbery_wait', Config.DownloadWaitTime))
				robberyHacked = true
			end
		end
		Citizen.Wait(1)
	end
	Citizen.Wait(Config.DownloadWaitTime * 60000)
	PlaySound(-1, 'OOB_Start', 'GTAO_FM_Events_Soundset', 0, 0, 1)
	notify(_U('robbery_takeUSBText'))
	while not USBtaken do
		local usbDistance = GetDistanceBetweenCoords(Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z, GetEntityCoords(GetPlayerPed(PlayerId())), true)
		if usbDistance < 1 then
			Draw3DText(Config.RobberyUSBStick.Coords.x + 0.1, Config.RobberyUSBStick.Coords.y + 0.7, Config.RobberyUSBStick.Coords.z + 0.3, 1.5, "~r~[E] ~s~| ".._U('robbery_takeUSB'))
			if IsControlJustReleased(0, Config.trigger_key) then
				RequestAnimDict("amb@prop_human_atm@male@enter")
				while not HasAnimDictLoaded("amb@prop_human_atm@male@enter") do
					RequestAnimDict("amb@prop_human_atm@male@enter")
					Citizen.Wait(0)
				end
				TaskGoStraightToCoord(playerPed, Config.RobberyUSBStick.Coords.x, Config.RobberyUSBStick.Coords.y, Config.RobberyUSBStick.Coords.z - 1, 1.0, -1, Config.RobberyUSBStick.Heading, 0.1)
				Citizen.Wait(1500)
				FreezeEntityPosition(playerPed, true)
				SetEntityHeading(playerPed, Config.RobberyUSBStick.Heading)
				SetCurrentPedWeapon(playerPed, GetHashKey('weapon_unarmed'), true)
				ESX.Streaming.RequestAnimDict("amb@prop_human_atm@male@enter", function()
					TaskPlayAnim(playerPed, "amb@prop_human_atm@male@enter", "enter", 2.0, 2.0, 4333, 1, 1.0, true, true, true)
				end)
				Citizen.Wait(4333)
				FreezeEntityPosition(playerPed, false)
				USBtaken = true
				notify(_U('robbery_USBtaken'))
				ESX.TriggerServerCallback('lifeinvaderRobbery:addDataUSB', function(hasGiven)
				end)
				if Config.shutPowerDown == true then
					notify(_U('robbery_powerShutDown'))
					TriggerServerEvent('lifeinvaderRobbery:shutLightsDown')
				end
				SetArtificialLightsState(true)
				Citizen.SetTimeout(2 * 60000, function()
					SetArtificialLightsState(false)
				end)
				Citizen.SetTimeout(Config.NextRobberyWaitTime * 60000, function()
					TriggerServerEvent('lifeinvaderRobbery:currentRobbery', false)
				end)
			end
		end
		Citizen.Wait(1)
	end
end

function uploadData() 
	local playerPed = GetPlayerPed(PlayerId())
	dataUploading = true
	notify(_U('lester_uploading'))
	notify(_U('lester_wait', Config.UploadWaitTime))
	PlaySound(-1, 'Kill_List_Counter', 'GTAO_FM_Events_Soundset', 0, 0, 1)
	Citizen.Wait(Config.UploadWaitTime * 60000)
	notify(_U('lester_uploaded'))
	PlaySound(-1, 'OOB_Start', 'GTAO_FM_Events_Soundset', 0, 0, 1)
	dataSended = false
	while not dataSended do
		Citizen.Wait(0)
		Draw3DText(Config.LesterCoords.Coords.x, Config.LesterCoords.Coords.y, Config.LesterCoords.Coords.z, 1.5, "~r~[E] ~s~| ".._U('lester_sell'))
		if IsControlJustReleased(0, Config.trigger_key) then
			notify(_U('lester_selled', Config.sellPrice))
			ESX.TriggerServerCallback('lifeinvaderRobbery:sellData', function(hasSelled)
				dataUploading = false
				dataSended = true
				return
			end)
		end
	end
end

RegisterNetEvent('lifeinvaderRobbery:shutLightsDown')
AddEventHandler('lifeinvaderRobbery:shutLightsDown', function()
print("test1")
	SetArtificialLightsState(true)
	Citizen.SetTimeout(2 * 60000, function()
		SetArtificialLightsState(false)
	end)
end)

RegisterNetEvent('lifeinvaderRobbery:callPolice')
AddEventHandler('lifeinvaderRobbery:callPolice', function()
	local ped = GetPlayerPed(PlayerId())
	if ESX.GetPlayerData(ped).job.name == 'police' then
		Citizen.Wait(1000)
		notify(_U('robbery_police'))
		for i=2, 1, -1 do
		PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(125)
		end
		Citizen.Wait(500)
		for i=2, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(125)
		end
		Citizen.Wait(3000)
		for i=2, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(125)
		end
		Citizen.Wait(500)
		for i=2, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(125)
		end
	end
end)

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.0, 0.4)
        SetTextLeading(true)
        SetTextFont(4)
        SetTextProportional(0.5)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        if Config.greySquare == true then
			local factor = (string.len(text)) / 370
			DrawRect(_x,_y+0.0125, 0.015+ factor, 0.038, 003, 003, 003, 75)
        end
        DrawText(_x, _y)
    end
end

function notify(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	EndTextCommandThefeedPostTicker(false, true)
end

--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--
