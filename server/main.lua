local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

ESX.RegisterServerCallback("adictos-skills:fetchStatus", function(source, cb)
     local src = source
     local xPlayer = ESX.GetPlayerFromId(src)
	 local defaultMaxWeight = ESX.GetConfig().MaxWeight
	 
     local fetch = [[
          SELECT
               skills
          FROM
               users
          WHERE
               identifier = @identifier
     ]]

     MySQL.Async.fetchScalar(fetch, {
          ["@identifier"] = xPlayer.identifier

     }, function(status)
          
          if status ~= nil then
             -- local peso = json.decode(status)["Fuerza"]["Current"]/4
             -- xPlayer.setMaxWeight(defaultMaxWeight + peso)
          
               cb(json.decode(status))
          else
               local fetch = [[
				  SELECT
					   skills
				  FROM
					   users
				  WHERE
					   identifier = @identifier
			 ]]

			 MySQL.Async.fetchScalar(fetch, {
				  ["@identifier"] = xPlayer.identifier

			 }, function(status)
				  
				  if status ~= nil then
					 -- local peso = json.decode(status)["Fuerza"]["Current"]/4
					 -- xPlayer.setMaxWeight(defaultMaxWeight + peso)
				  
					   cb(json.decode(status))
				  else
					   cb(nil)
				  end
			 
			 end)
          end
     
     end)
end)


RegisterServerEvent("adictos-skills:update")
AddEventHandler("adictos-skills:update", function(data, discord, habilidad)
     local src = source
     local xPlayer = ESX.GetPlayerFromId(src)
	 local defaultMaxWeight = ESX.GetConfig().MaxWeight
	 local peso = json.decode(data)["Fuerza"]["Current"]/4
	
	xPlayer.setMaxWeight(defaultMaxWeight + peso)
	if xPlayer then
		if discord then
			if discord ~= "nada" then
				sendDiscord1('Estadisticas', '/Estadisticas **' .. xPlayer.name .. '** ha subido las estadisticas de '.. habilidad ..' al ' .. discord .. '%')
			end
		end
     local insert = [[
          UPDATE
               users
          SET
               skills = @skills
          WHERE
               identifier = @identifier
     ]]

     MySQL.Async.execute(insert, {
          ["@skills"] = data,
          ["@identifier"] = xPlayer.identifier
     })
	end
end)

RegisterCommand("estadisticasmax", function(source, args, rawCommand)	-- players		show online players | console only
	local xPlayer1 = ESX.GetPlayerFromId(source)
		if xPlayer1.group == "superadmin" or xPlayer1.group == "admin" or xPlayer1.group == "mod" then
			local xPlayer = ESX.GetPlayerFromId(args[1])
			if xPlayer then
				TriggerClientEvent("adictos-skills:modificarmax", xPlayer.source)
				sendDiscord1('/estadisticasmax', '/estadisticasmax **' .. xPlayer1.name .. '** ha subido al maximo las estadisticas de **'.. xPlayer.name ..'**')
			else
				xPlayer1.showNotification("Debes poner la ID del jugador")
			end
		end
end, false)

RegisterCommand("estadisticas", function(source, args, rawCommand)	-- players		show online players | console only
	local xPlayer1 = ESX.GetPlayerFromId(source)
		if xPlayer1.group == "superadmin" or xPlayer1.group == "admin" or xPlayer1.group == "mod" then
			local xPlayer = ESX.GetPlayerFromId(args[1])
			if xPlayer then
			--print(args[1], args[2], args[3])
				estadistica = args[2]
				valor = args[3]
				TriggerClientEvent("adictos-skills:modificar", xPlayer.source, estadistica, valor)
				sendDiscord1('/estadisticasmax', '/estadisticasmax **' .. xPlayer1.name .. '** ha subido las estadisticas de '.. estadistica ..' un ' .. valor .. '% a ' ..xPlayer.name.. '')
			else
				xPlayer1.showNotification("Debes poner la ID del jugador")
			end
		end
end, false)




webhookurl1 = '' 

function sendDiscord1(name, message)
  	PerformHttpRequest(webhookurl1, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end