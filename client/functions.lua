local aviso = false
local aviso1 = false
local aviso2 = false
local aviso3 = false
FetchSkills = function()
    ESX.TriggerServerCallback("adictos-skills:fetchStatus", function(data)
		if data then
            for status, value in pairs(data) do
                if Config.Skills[status] then
                    Config.Skills[status]["Current"] = value["Current"]
                else
                    print("Removing: " .. status) 
                end
            end
		end
        RefreshSkills()
    end)
end

SkillMenu = function()
    ESX.UI.Menu.CloseAll()
    local skills = {}

	for type, value in pairs(Config.Skills) do
		table.insert(skills, {
			["label"] = type .. ': <span style="color:yellow">' .. value["Current"] .. "</span> %"
		})
	end

	ESX.UI.Menu.Open("default", GetCurrentResourceName(), "skill_menu",
	{
		["title"] = "Skills",
		["align"] = "center",
		["elements"] = skills

	}, function(data, menu)
	
        
	end, function(data, menu)
		menu.close()
	end)
end

GetCurrentSkill = function(skill)
    return Config.Skills[skill]
end

UpdateSkill = function(skill, amount)

    if not Config.Skills[skill] then
        print("Skill " .. skill .. " doesn't exist")
        return
    end

    local SkillAmount = Config.Skills[skill]["Current"]
    
    if SkillAmount + tonumber(amount) < 0 then
        Config.Skills[skill]["Current"] = 0
    elseif SkillAmount + tonumber(amount) > 100 then
        Config.Skills[skill]["Current"] = 100
    else
        Config.Skills[skill]["Current"] = SkillAmount + tonumber(amount)
    end
	porcentaje = Config.Skills[skill]["Current"]
	
	if porcentaje > 50 and porcentaje < 75 then
		if not aviso then
			aviso = true
			discord = Config.Skills[skill]["Current"]
			habilidad = skill
		else
			discord = "nada"
			habilidad = "nada"
		end
	elseif porcentaje > 75 and porcentaje < 90 then
		if not aviso1 then
			aviso1 = true
			discord = Config.Skills[skill]["Current"]
			habilidad = skill
		else
			discord = "nada"
			habilidad = "nada"
		end
	elseif porcentaje > 90 and porcentaje < 98 then
		if not aviso2 then
			aviso2 = true
			discord = Config.Skills[skill]["Current"]
			habilidad = skill
		else
			discord = "nada"
			habilidad = "nada"
		end
	elseif porcentaje > 98 then
		if not aviso3 then
			aviso3 = true
			discord = Config.Skills[skill]["Current"]
			habilidad = skill
		else
			discord = "nada"
			habilidad = "nada"
		end
	else
		discord = "nada"
		habilidad = "nada"
	end
	
    RefreshSkills()
	
	TriggerServerEvent("adictos-skills:update", json.encode(Config.Skills), discord, habilidad)
	
    if Config.Notifications then
        if tonumber(amount) > 0 then
			if skill == "Estamina" and amount ~= 0.01 then
				TriggerEvent("pNotify:SendNotification",{
					text = "Has aumentado un " .. amount .. "% tu " .. skill ,
					type = "error",
					timeout = (4000),
					layout = "bottomLeft",
					queue = "global"
				})
			end
        end
    end
	
end


function round(num) 
    return math.floor(num+.5) 
end

RefreshSkills = function()
    for type, value in pairs(Config.Skills) do
        
        if value["Stat"] then
            StatSetInt(value["Stat"], round(value["Current"]), true)
        end
        
        if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "skill_menu") then
            SkillMenu()
        end
    end
end

MessageBox = function(text, alpha)
    if alpha > 255 then
        alpha = 255
    elseif alpha < 0 then
        alpha = 0
    end
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, math.floor(alpha))
    SetTextEdge(2, 0, 0, 0, math.floor(alpha))
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextScale(0.31, 0.31)
    AddTextComponentString(text)
    local factor = (string.len(text)) / 350
    local x = 0.015
    local y = 0.5
    local width = 0.05 
    local height = 0.025
    DrawText(x + (width / 2.0), y + (height / 2.0) - 0.01)
    DrawRect(x + (width / 2.0), y + (height / 2.0), width, height, 25, 25, 25, math.floor(alpha))
end

