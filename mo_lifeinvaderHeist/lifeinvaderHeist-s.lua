--© Mo1810--
local currentRobbery = false
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("lifeinvaderRobbery:getOnlinePoliceCount",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Players = ESX.GetPlayers()
	local policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == "police" then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPolice then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('esx:showNotification', source, _U('not_enough_police'))
	end
end)

ESX.RegisterServerCallback('lifeinvaderRobbery:removeEmptyUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	if xPlayer.getInventoryItem('usbstick').count > 0 then
		xPlayer.removeInventoryItem('usbstick', 1)
		cb(true)
	else
		xPlayer.showNotification(_U('not_enough_empty'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('lifeinvaderRobbery:addDataUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	xPlayer.addInventoryItem('usbstick_data', 1)
	cb(true)
end)

ESX.RegisterServerCallback('lifeinvaderRobbery:removeDataUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	if xPlayer.getInventoryItem('usbstick_data').count > 0 then
		xPlayer.removeInventoryItem('usbstick_data', 1)
		cb(true)
	else
		xPlayer.showNotification(_U('not_enough_data'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('lifeinvaderRobbery:sellData', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	xPlayer.addAccountMoney('black_money', Config.sellPrice)
	cb(true)
end)

ESX.RegisterServerCallback('lifeinvaderRobbery:getCurrentRobbery', function(source, cb)
	cb(currentRobbery)
end)

RegisterServerEvent('lifeinvaderRobbery:currentRobbery')
AddEventHandler('lifeinvaderRobbery:currentRobbery', function(bool)
	currentRobbery = bool
end)

RegisterServerEvent('lifeinvaderRobbery:shutLightsDown')
AddEventHandler('lifeinvaderRobbery:shutLightsDown', function()
	TriggerClientEvent('lifeinvaderRobbery:shutLightsDown', -1)
end)

RegisterServerEvent('lifeinvaderRobbery:callPolice')
AddEventHandler('lifeinvaderRobbery:callPolice', function()
	TriggerClientEvent('lifeinvaderRobbery:callPolice', -1)
end)
--© Mo1810--