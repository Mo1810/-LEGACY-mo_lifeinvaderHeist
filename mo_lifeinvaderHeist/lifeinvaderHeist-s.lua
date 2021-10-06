--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--

local currentRobbery = false
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("lifeinvaderHeist:getOnlinePoliceCount",function(source,cb)
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

ESX.RegisterServerCallback('lifeinvaderHeist:removeEmptyUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	if xPlayer.getInventoryItem(Config.usbstickItem).count > 0 then
		xPlayer.removeInventoryItem(Config.usbstickItem, 1)
		cb(true)
	else
		xPlayer.showNotification(_U('not_enough_empty'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('lifeinvaderHeist:addDataUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	xPlayer.addInventoryItem(Config.usbstickDataItem, 1)
	cb(true)
end)

ESX.RegisterServerCallback('lifeinvaderHeist:removeDataUSB', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	if xPlayer.getInventoryItem(Config.usbstickDataItem).count > 0 then
		xPlayer.removeInventoryItem(Config.usbstickDataItem, 1)
		cb(true)
	else
		xPlayer.showNotification(_U('not_enough_data'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('lifeinvaderHeist:sellData', function(source, cb)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(_source)
		Citizen.Wait(0)
	end
	xPlayer.addAccountMoney('black_money', Config.sellPrice)
	cb(true)
end)

ESX.RegisterServerCallback('lifeinvaderHeist:getCurrentRobbery', function(source, cb)
	cb(currentRobbery)
end)

RegisterServerEvent('lifeinvaderHeist:currentRobbery')
AddEventHandler('lifeinvaderHeist:currentRobbery', function(bool)
	currentRobbery = bool
end)

RegisterServerEvent('lifeinvaderHeist:shutLightsDown')
AddEventHandler('lifeinvaderHeist:shutLightsDown', function()
	TriggerClientEvent('lifeinvaderHeist:shutLightsDown', -1)
end)

RegisterServerEvent('lifeinvaderHeist:callPolice')
AddEventHandler('lifeinvaderHeist:callPolice', function()
	TriggerClientEvent('lifeinvaderHeist:callPolice', -1)
end)

--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--
