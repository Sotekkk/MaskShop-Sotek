ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterServerEvent('Sotek:pay')
AddEventHandler('Sotek:pay', function()
 
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(200) 

end)
 
RegisterServerEvent('Sotek:saveMask')
AddEventHandler('Sotek:saveMask', function(skin) 

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_mask', xPlayer.identifier, function(store)

        store.set('hasMask', true) 

        store.set('skin', {
            mask_1 = skin.mask_1,
            mask_2 = skin.mask_2
        }) 

    end)

end) 

ESX.RegisterServerCallback('SotekCore:getPlayerOutfitMask', function(source, cb, num)

    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
      local outfit = store.get('skin', {
            mask_1 = skin.mask_1,
            mask_2 = skin.mask_2
        })
      cb(outfit.skin)
    end)
  
end)

ESX.RegisterServerCallback('Sotek:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= 20 then
		cb(true)
	else
		cb(false)
	end

end) 