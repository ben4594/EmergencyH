local ESX = nil
local hasPerms = 0
local playerRank
RegisterCommand("clear", function()
	RemoveAllPedWeapons(GetPlayerPed(-1, true))
	notify("~r~Cleared all weapons")
end)
RegisterCommand("givepistolandknife", function()
	
	ESX.TriggerServerCallback("EmergencyH:fetchUserRank", function(playerRank)
		if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
			giveWeapon("weapon_pistol")
			giveWeapon("weapon_knife")
			alert("~b~Given you guns, no worries :)")
			
		else
			notify("~r~Insufficient Permissions.")
		end
	end)
end)
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()

	local h_key = 74
	local x_key = 73
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(1, h_key) then
			ESX.TriggerServerCallback("EmergencyH:fetchUserRank", function(playerRank)
        		if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
					giveWeapon("weapon_pistol")
					giveWeapon("weapon_knife")
					alert("~b~Given weapons with ~INPUT_VEH_HEADLIGHT~")
				else
					notify("~r~Insufficient Permissions.")
				end
			end)
		end
		if IsControlJustReleased(1, x_key) then
			
			ESX.TriggerServerCallback("EmergencyH:fetchUserRank", function(playerRank)
				if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
					RemoveAllPedWeapons(GetPlayerPed(-1, true))
					alert("~r~Cleared all weapons")
					

				else
					notify("~r~Insufficient Permissions."+playerRank)
				end
			end)
		end

	end

end)

