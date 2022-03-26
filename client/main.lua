ESX = nil
local fuerza = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerLoaded = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)

	while not playerLoaded do
        Citizen.Wait(1000)
    end
	
	FetchSkills()
	Citizen.Wait(2000)
	UpdateSkill("Estamina", 0.01)
	Citizen.Wait(2000)
	for skill, value in pairs(Config.Skills) do
		UpdateSkill(skill, value["RemoveAmount"])
	end
	TriggerServerEvent("adictos-skills:update", json.encode(Config.Skills))
	
	while true do
		Citizen.Wait(2000000)
		for skill, value in pairs(Config.Skills) do
			UpdateSkill(skill, value["RemoveAmount"])
		end
		TriggerServerEvent("adictos-skills:update", json.encode(Config.Skills))
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		
		for skill, value in pairs(Config.Skills) do
			if skill == "Fuerza" then
				fuerza = value.Current / 5
			end
		end
		Citizen.Wait(55000)
		if IsPedRunning(ped) and not IsPedInAnyVehicle(ped, false) then
			UpdateSkill("Estamina", 0.6)
		elseif IsPedSwimmingUnderWater(ped) then
			UpdateSkill("Capacidad Pulmonar", 1.0)
		elseif DoesEntityExist(vehicle) then
			local speed = GetEntitySpeed(vehicle) * 3.6

			if GetVehicleClass(vehicle) == 13 and speed >= 5 then
				UpdateSkill("Estamina", 0.7)
			end 
		end
	end
end)


RegisterNetEvent("adictos-skills:modificarmax")
AddEventHandler("adictos-skills:modificarmax", function()
  UpdateSkill("Estamina", 99.9)
  UpdateSkill("Capacidad Pulmonar", 99.9)
  UpdateSkill("Fuerza", 99.9)
end)

RegisterNetEvent("adictos-skills:modificar")
AddEventHandler("adictos-skills:modificar", function(estadistica, valor)
	--print(estadistica, valor)
	if estadistica == "fuerza" or estadistica == "Fuerza" then
		UpdateSkill("Fuerza", valor)
	elseif estadistica == "estamina" or estadistica == "Estamina" or estadistica == "resistencia" or estadistica == "Resistencia" then
		UpdateSkill("Estamina", valor)
	elseif estadistica == "oxigeno" or estadistica == "capacidad" or estadistica == "pulmones" or estadistica == "Capacidad Pulmonar" or estadistica == "capacidad pulmonar" then
		UpdateSkill("Capacidad Pulmonar", valor)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local jugador = PlayerPedId()
		local player = PlayerId()
		if GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_SNOWBALL') then
            SetPlayerWeaponDamageModifier(player, 0.0)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_UNARMED') then
            SetPlayerWeaponDamageModifier(player, 0.13 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_HAMMER') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_BAT') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_KNIFE') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_CROWBAR') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_MACHETE') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_MACHETE') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_SWITCHBLADE') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_WRENCH') then
			SetPlayerWeaponDamageModifier(player, 0.1 * fuerza)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_NIGHTSTICK') then
			SetPlayerWeaponDamageModifier(player, 0.1)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_WRENCH') then
			SetPlayerWeaponDamageModifier(player, 0.1)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_SMOKEGRENADE') then
			SetPlayerWeaponDamageModifier(player, 0.0)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_GUSENBERG') then
			SetPlayerWeaponDamageModifier(player, 0.7)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_COMBATMG') then
			SetPlayerWeaponDamageModifier(player, 0.5)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_DOUBLEACTION') then
			SetPlayerWeaponDamageModifier(player, 0.6)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_FLASHLIGHT') then
			SetPlayerWeaponDamageModifier(player, 0.01)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_HATCHET') then
			SetPlayerWeaponDamageModifier(player, 0.01)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_PISTOL50') then
			SetPlayerWeaponDamageModifier(player, 0.5)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_BULLPUPSHOTGUN') then
			SetPlayerWeaponDamageModifier(player, 3.7)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_PUMPSHOTGUN') then
			SetPlayerWeaponDamageModifier(player, 2.0)
		elseif GetSelectedPedWeapon(jugador) == GetHashKey('WEAPON_SAWNOFFSHOTGUN') then
			SetPlayerWeaponDamageModifier(player, 1.5)
		else
			SetPlayerWeaponDamageModifier(player, 1.0)
			Citizen.Wait(1000)
        end
	end
end)