// Love Manolis Vrondakis. @vrondakis
if SERVER then 
function checkLevel(ply,entity)
	if(entity.level) then
		if not((ply:getDarkRPVar("level") or 0) >= (entity.level)) then
			return false, DarkRP.getPhrase("lvl_buy_entity")
		end
	end
end

hook.Add("canBuyPistol", "manolis:MVLevels:PistolBuy", checkLevel)
hook.Add("canBuyAmmo", "manolis:MVLevels:AmmoBuy", checkLevel)
hook.Add("canBuyShipment", "manolis:MVLevels:ShipmentBuy", checkLevel)
hook.Add("canBuyVehicle", "manolis:MVLevels:VehiclesBuy", checkLevel)
hook.Add("canBuyCustomEntity", "manolis:MVLevels:CEntityBuy", checkLevel)

hook.Add("playerCanChangeTeam", "manolis:MVLevels:playerTeamChange", function(ply, jobno) 
	// This one requires a little extra work
	job = RPExtraTeams[jobno]
	if (job.level) then
		if not ((ply:getDarkRPVar("level") or 0) >= (job.level)) then
			return false, DarkRP.getPhrase("lvl_take_job")
		end
	end
end)

end

if CLIENT then
function LevelPrompts()
	timer.Simple(0.15,function()

		for k,v in pairs(DarkRPEntities) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. " - Level "..v.level)
			end
		end

		for k,v in pairs(RPExtraTeams) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. " - Level "..v.level)
			end
		end

		for k,v in pairs(CustomVehicles) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. " - Level "..v.level)
			end
		end

		for k,v in pairs(CustomShipments) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. " - Level "..v.level)
			end
		end

		for k,v in pairs(GAMEMODE.AmmoTypes) do
			v.label = v.name
			if v.level then
				v.label = (v.label .. " - Level "..v.level)
			end
		end
	end)

end

hook.Add( "InitPostEntity", "manolis:MVLevels:PostEntInit", function()
	LevelPrompts()
end) 

hook.Add( "OnReloaded", "manolis:MVLevels:LuaReloadA", function()
	LevelPrompts()
end)

end


if CLIENT then

function ButtonColors()
	timer.Simple(0.1, function()

		if(LevelSystemConfiguration.GreenAllBars) then
			for k,v in pairs(DarkRPEntities) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar("level") or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end

			end
		end

		if(LevelSystemConfiguration.GreenJobBars) then
			for k,v in pairs(RPExtraTeams) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar("level") or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end

			end
		end

		if(LevelSystemConfiguration.GreenAllBars) then
			for k,v in pairs(CustomVehicles) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar("level") or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end

			for k,v in pairs(CustomShipments) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar("level") or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end

			for k,v in pairs(GAMEMODE.AmmoTypes) do 
				if v.level then
					if not((LocalPlayer():getDarkRPVar("level") or 0) >= v.level) then
						v.buttonColor = Color(100,0,0)
					else
						v.buttonColor = Color(0,100,0)
					end
				else
					v.buttonColor = Color(0,100,0)
				end
			end
		end
	end)
end
hook.Add("F4MenuTabs", "manolis:MVLevels:FFourMenuTabs", ButtonColors)
hook.Add("PlayerLevelChanged", "manolis:MVLevels:PlayerLevelChangedA", ButtonColors)

end

function PlayerInitialSpawn(ply)
	if SERVER then
		DarkRP.retrievePlayerLevelData(ply)
	end
end

hook.Add("PlayerInitialSpawn", "manolis:MVLevels:PlayerSpawnB", function(ply) timer.Simple( 1, function () PlayerInitialSpawn(ply) end) end)
