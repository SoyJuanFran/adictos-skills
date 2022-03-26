Config = {}

Config.UpdateFrequency = 1200 -- seconds interval between removing values 

Config.Notifications = true -- notification when skill is added

Config.Skills = {
    ["Estamina"] = {
        ["Current"] = 20, -- Default value 
        ["RemoveAmount"] = -0.2, -- % to remove when updating,
        ["Stat"] = "MP0_STAMINA" -- GTA stat hashname
    },

    ["Fuerza"] = {
        ["Current"] = 5,
        ["RemoveAmount"] = -0.2,
        ["Stat"] = "MP0_STRENGTH"
    },

    ["Capacidad Pulmonar"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.01,
        ["Stat"] = "MP0_LUNG_CAPACITY"
    }
}


